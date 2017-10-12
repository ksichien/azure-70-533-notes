# The VM will need a restart after being scaled.
$rgname = <resource group name>
$subname = <azure subscription>
$vmname = <virtual machine name>

add-azurermaccount # login to azure
set-azurermcontext -subscriptionname $subname # set subscription
get-azurermvmsize -resourcegroupname $rgname -vmname $vmname # check all available vm sizes based on resource group
$vm = get-azurermvm -resourcegroupname $rgname -vmname $vmname # retrieve vm object
$vm.hardwareprofile.vmsize = "Standard_DS2_v2" # change hardware profile
update-azurermvm -vm $vm -resourcegroupname $rgname # push changes to azure
