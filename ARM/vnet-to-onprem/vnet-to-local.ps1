$resgrp = "TestRG"
$location = "westeurope"
$GatewaySubnetIP = "10.0.0.0/30"
$subnet1IP = "10.0.1.0/24"
$vnetname = "Testvnet"
$vnetip = "10.0.0.0/16"
$localsitename = "LocalSite"
$localGWIP = "22.33.44.55"
$localIP = @('10.0.0.0/24','20.0.0.0/24')
$gwipname = "gwip"
$gwipconfigname = "gwipconfig1"
$vnetgwname = "vnetgw"
$VPNName = "Azure2OnPrem"
$sharedKey = "23dadsfFASF2"


#Create a new resourcegroup
New-AzureRmResourceGroup -Name $resgrp -Location $location

#Create subnets
$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix $GatewaySubnetIP
$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -Name 'Subnet1' -AddressPrefix $subnet1IP

#Create vnet with subnets
New-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $resgrp -Location $location -AddressPrefix $vnetip -Subnet $subnet1, $subnet2

#Create the local gw object
New-AzureRmLocalNetworkGateway -Name $localsitename -ResourceGroupName $resgrp -Location $location -GatewayIpAddress $localGWIP -AddressPrefix $localIP

#Create a new public IP for use with gw
$gwpip= New-AzureRmPublicIpAddress -Name $gwipname -ResourceGroupName $resgrp -Location $location -AllocationMethod Dynamic

#Create Gateway IP Config
$vnet = Get-AzureRmVirtualNetwork -Name $vnetname -ResourceGroupName $resgrp
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
$gwipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name $gwipconfigname -SubnetId $subnet.Id -PublicIpAddressId $gwpip.Id 

#create the vnet gateway
New-AzureRmVirtualNetworkGateway -Name $vnetgwname -ResourceGroupName $resgrp -Location $location -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType RouteBased

#Get the public IP to be used on local gw
Get-AzureRmPublicIpAddress -Name $gwpipname -ResourceGroupName $resgrp

$gateway1 = Get-AzureRmVirtualNetworkGateway -Name $vnetgwname -ResourceGroupName $resgrp
$local = Get-AzureRmLocalNetworkGateway -Name $localsitename -ResourceGroupName $resgrp


New-AzureRmVirtualNetworkGatewayConnection -Name $VPNName -ResourceGroupName $resgrp -Location $location -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local -ConnectionType IPsec -RoutingWeight 10 -SharedKey $sharedKey
Get-AzureRmVirtualNetworkGatewayConnection -Name $VPNName -ResourceGroupName $resgrp -Debug