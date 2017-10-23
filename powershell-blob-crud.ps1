$subname = <azure subscription name>
$rgname = <resource group name>
$storageaccountname = "lastoragedemo"
$containername = <storage container name>
$backupcontainer = <second storage container name>
$imagename = "apricots.jpg"
$imagetoupload = "C:\Users\DougV\Downloads" + $imagename
$imgdirectory = "C:\Users\DougV\Downloads\building"
$destinationfolder = "C:\Users\DougV\Downloads\azure"

add-azurermaccount # login to azure
get-azurermsubscription -subscriptionname $subname | select-azurermsubscription
$storageaccountkey = (get-azurermstorageaccountkey -resourcegroupname $rgname -name $storageaccountname).value[0]
$context = new-azurestoragecontext -storageaccountname $storageaccountname -storageaccountkey $storageaccountkey
set-azurermcurrentstorageaccount -context $context # this will let powershell know implicitly what storage account we mean for all the following commands
new-azurestoragecontainer -name $containername -permission blob # create new blob container
$properties = @{ "contenttype" = "image/jpeg" } # with this object we can set the content type, else it will default to application/octet-stream
set-azurestorageblobcontent -container $containername -file $imagetoupload -properties $properties -force # upload apricots file to azure
get-childitem -path $imgdirectory -file -recurse | set-azurestorageblobcontent -container $containername -properties $properties # upload all pictures in a given folder to azure
get-azurestorageblob -container $containername # show a list of all files in the azure storage container
$blobs = get-azurestorageblob -container $containername
new-item -path $destinationfolder -itemtype directory -force
$blobs | get-azurestorageblobcontent -destination $destinationfolder # download files recursively from azure to a local folder in an asynchronous manner
$blob = get-azurestorageblob -container $containername -blob $imagename
$snap = $blob.icloudblob.createsnapshot() # create snapshot of a file
$snaps =  get-azurestorageblob -prefix $imagename -container $containername | where-object {$_.icloudblob.issnapshot} # retrieve all snapshots of a file
foreach($item in $snaps) { write-host $item.name } # list the filename of every snapshot
new-azurestoragecontainer -name $backupcontainer -permission blob
start-azurestorageblobcopy -srcblob $imagename -destcontainer $backupcontainer -srccontainer $containername # asynchronously copy a file from one container to another (without snapshots!)
$blob | remove-azurestorageblob -force # delete file
$blobs = get-azurestorageblob -container $containername
foreach($item in $blobs) {
    start-azurestorageblobcopy -srcblob $item.name -destcontainer $backupcontainer -srccontainer $containername # copy all files from one container to another
}
