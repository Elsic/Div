#Create Azure Internal Load Balancer

$svc="ServiceName"
 
$ilb="InternalLoadBalancerName"
 
$subnet="SubnetName"
 
$IP="10.255.0.100"

Add-AzureInternalLoadBalancer -ServiceName $svc -InternalLoadBalancerName $ilb –SubnetName $subnet –StaticVNetIPAddress $IP
