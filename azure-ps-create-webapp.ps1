$appname = <app service plan name>
$location = "southcentralus"
$rgname = <resource group name>
$sub = <azure subscription> # optional
$gitrepo = "https://github.com/ksichien/win-srv-notes.git"

add-azurermaccount
set-azurermcontext -subscriptionname $sub # optional
new-azurermresourcegroup -name $rgname -location $location
new-azurermappserviceplan -name $appname -location $location -resourcegroupname $rgname -tier Standard
new-azurermwebapp -name $appname -location $location -appserviceplan $appname -resourcegroupname $rgname
new-azurermwebappslot -name $appname -resourcegroupname $rgname -slot staging # this creates a new slot with the 'staging' name
$propertiesobject = @{ "repourl" = "$gitrepo"; "branch" = "master"; "ismanualintegration" = true; }
set-azurermresource -properties $propertiesobject -resourcegroupname $rgname -resourcetype "Microsoft.Web/sites/slots/sourcecontrols" -resourcename "$appname/staging/web" -apiversion 2015-08-01 -force # makes a request to the azure management rest api through powershell
swap-azurermwebappslot -name $appname -resourcegroupname $rgname -sourceslotname staging -destinationslotname production
