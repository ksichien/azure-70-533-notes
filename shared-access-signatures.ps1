$rgname = <resource group name>
$subname = <azure subscription>
$storageaccountname = "lastoragedemo"
$containername = "images"
$blobname = "apricots.jpg"
$policyname = $containername + "policy"

add-azurermaccount
get-azurermsubscription -subscriptionname $subname | select-azurermsubscription
$accountkey = (get-azurermstorageaccountkey -resourcegroupname $rgname -name $storageaccountname).value[0]
$context = new-azurestoragecontext -storageaccountname $storageaccountname -storageaccountkey $accountkey
$tokenstarttime = $((get-date).touniversaltime().addhours(-1)).tostring("yyyy-MM-ddTHH:mm:ssZ") # the token needs to be in UTC and in a very specific format
$tokenexpirytime = $((get-date).touniversaltime().addhours(1)).tostring("yyyy-MM-ddTHH:mm:ssZ")
$blobtokenurl = new-azurestorageblobsastoken -container $containername -blob $blobname -context $context -permission r -starttime $tokenstarttime -expirytime $tokenexpirytime -fulluri
write-host $blobtokenurl
$tokenurl = new-azurestorageaccountsastoken -service blob -resourcetype service, container -context $context -permission rwdl -starttime $tokenstarttime -expirytime $tokenexpirytime -protocol httpsonly
write-host $tokenurl
new-azurestoragecontainerstoredaccesspolicy -name $containername -policy $policyname -permission "rd" -starttime $tokenstarttime -expirytime $tokenexpirytime -context $context
$containerpolicytokenurl = new-azurestoragecontainersastoken -name $containername -policy $policyname -context $context -fulluri
write-host $containerpolicytokenurl
