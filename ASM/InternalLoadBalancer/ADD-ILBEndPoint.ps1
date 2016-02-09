#Add endpoints to VMs
$svc="ServiceName"

$ilb="InternalLoadBalancerName"

$prot="tcp"

$locport=443

$pubport=443

$epname="EndpointName01"

$vmname="VMName01"

#Get-AzureVM –ServiceName $svc –Name $vmname | Add-AzureEndpoint -Name $epname –LBSetName “ADFS-SSL” -Protocol $prot -LocalPort $locport -PublicPort $pubport –DefaultProbe -InternalLoadBalancerName $ilb -LoadBalancerDistribution sourceIP -Verbose| Update-AzureVM
Get-AzureVM –ServiceName $svc –Name $vmname | Get-AzureEndpoint -Name $epname
$epname="EndpointName01"

$vmname="VMName02"
Get-AzureVM –ServiceName $svc –Name $vmname | Get-AzureEndpoint -Name $epname

#Get-AzureVM –ServiceName $svc –Name $vmname | Add-AzureEndpoint -Name $epname –LBSetName “ADFS-SSL” -Protocol $prot -LocalPort $locport -PublicPort $pubport –DefaultProbe -InternalLoadBalancerName $ilb -LoadBalancerDistribution sourceIP -verbose| Update-AzureVM