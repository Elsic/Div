#Create Azure Internal Load Balancer
$svc="ServiceName"
$ilb="InternalLoadBalancerName"
$subnet="SubnetName"
$IP="10.255.0.100"

Add-AzureInternalLoadBalancer -ServiceName $svc -InternalLoadBalancerName $ilb –SubnetName $subnet –StaticVNetIPAddress $IP

#Add endpoints to VMs

$prot="tcp"
$locport=443
$pubport=443
$epname="EndpointName01"
$vmname="VMName01"

Get-AzureVM –ServiceName $svc –Name $vmname | Add-AzureEndpoint -Name $epname –LBSetName “SSL” -Protocol $prot -LocalPort $locport -PublicPort $pubport –DefaultProbe -InternalLoadBalancerName $ilb -LoadBalancerDistribution sourceIP -Verbose| Update-AzureVM
#Get-AzureVM –ServiceName $svc –Name $vmname | Get-AzureEndpoint -Name $epname
$epname="EndpointName02"
$vmname="VMName02"
#Get-AzureVM –ServiceName $svc –Name $vmname | Get-AzureEndpoint -Name $epname

Get-AzureVM –ServiceName $svc –Name $vmname | Add-AzureEndpoint -Name $epname –LBSetName “SSL” -Protocol $prot -LocalPort $locport -PublicPort $pubport –DefaultProbe -InternalLoadBalancerName $ilb -LoadBalancerDistribution sourceIP -verbose| Update-AzureVM