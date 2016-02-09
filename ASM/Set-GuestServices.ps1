$name = "VMName"
$svc = "VM Service Name"

$vm = Get-AzureVM –serviceName $svc –Name $name
$vm.VM.ProvisionGuestAgent = $TRUE
Update-AzureVM –Name $name –VM $vm.VM –ServiceName $svc