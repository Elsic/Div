# Create VNET1, if it doesn't already exist
$prefix = "os"
$rgname = "OSTestRG"

$vnet1Name = "$prefix-vnet1"
$subnet1Name = "$prefix-subnet1"
$subnet2Name = "GatewaySubnet"
$vnet2Name = "$prefix-vnet2"
$subnet1Name = "$prefix-subnet1"
$subnet2Name = "GatewaySubnet"
$location = "westeurope"

$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name $subnet1Name -AddressPrefix "10.0.1.0/24"
$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -Name $subnet2Name -AddressPrefix "10.0.2.0/24"

$vnet1 = New-AzureRmVirtualNetwork -Name $vnet1Name -ResourceGroupName $rgname -Location $location -AddressPrefix "10.0.0.0/16" -Subnet $subnet1,$subnet2


# Create VNET2

$vnet2Name = "$prefix-vnet2"
$subnet1Name = "$prefix-subnet1"
$subnet2Name = "GatewaySubnet"

$subnet1 = New-AzureRmVirtualNetworkSubnetConfig -Name $subnet1Name -AddressPrefix "10.1.1.0/24"
$subnet2 = New-AzureRmVirtualNetworkSubnetConfig -Name $subnet2Name -AddressPrefix "10.1.2.0/24"

$vnet2 = New-AzureRmVirtualNetwork -Name $vnet2Name -ResourceGroupName $rgname -Location $location -AddressPrefix "10.1.0.0/16" -Subnet $subnet1,$subnet2


# Register a Public IP for VNET1 Gateway

$vnet1GatewayName = "$prefix-gw1"

$vnet1PublicGatewayVipName = "$prefix-gw1vip"

$vnet1PublicGatewayVip = New-AzureRmPublicIpAddress -Name $vnet1PublicGatewayVipName -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic -DomainNameLabel $vnet1GatewayName

# Register a Public IP for VNET2 Gateway

$vnet2GatewayName = "$prefix-gw2"

$vnet2PublicGatewayVipName = "$prefix-gw2vip"
$vnet2PublicGatewayVip = New-AzureRmPublicIpAddress -Name $vnet2PublicGatewayVipName -ResourceGroupName $rgName -Location $location -AllocationMethod Dynamic -DomainNameLabel $vnet2GatewayName


# Create VNET1 Gateway

$vnet1GatewayIpConfigName = "$prefix-gw1ip"

$vnet1GatewayIpConfig = New-AzureRMVirtualNetworkGatewayIpConfig -Name $vnet1GatewayIpConfigName -PublicIpAddressId $vnet1PublicGatewayVip.Id -PrivateIpAddress "10.0.2.4" -SubnetId $vnet1.Subnets[1].Id

# Provision VNET1 Gateway

$vnet1Gateway = New-AzureRMVirtualNetworkGateway -Name $vnet1GatewayName -ResourceGroupName $rgName -Location $location -GatewayType Vpn -VpnType RouteBased -IpConfigurations $vnet1GatewayIpConfig


# Create VNET2 Gateway

# Create IP Config to attach VNET2 Gateway to VIP & Subnet

$vnet2GatewayIpConfigName = "$prefix-gw2ip"

$vnet2GatewayIpConfig = New-AzureRMVirtualNetworkGatewayIpConfig -Name $vnet2GatewayIpConfigName -PublicIpAddressId $vnet2PublicGatewayVip.Id -PrivateIpAddress "10.1.2.4" -SubnetId $vnet2.Subnets[1].Id

# Provision VNET2 Gateway
$vnet2Gateway = New-AzureRMVirtualNetworkGateway -Name $vnet2GatewayName -ResourceGroupName $rgName -Location $location -GatewayType Vpn -VpnType RouteBased -IpConfigurations $vnet2GatewayIpConfig


# Create VNET1-to-VNET2 connection

$vnet12ConnectionName = "$prefix-vnet-1-to-2-con"
$vnet12Connection = New-AzureRMVirtualNetworkGatewayConnection -Name $vnet12ConnectionName -ResourceGroupName $rgName -Location $location -ConnectionType Vnet2Vnet -VirtualNetworkGateway1 $vnet1Gateway -VirtualNetworkGateway2 $vnet2Gateway

# Create VNET2-to-VNET1 connection

$vnet21ConnectionName = "$prefix-vnet-2-to-1-con"
$vnet21Connection = New-AzureRMVirtualNetworkGatewayConnection -Name $vnet21ConnectionName -ResourceGroupName $rgName -Location $location -ConnectionType Vnet2Vnet -VirtualNetworkGateway1 $vnet2Gateway -VirtualNetworkGateway2 $vnet1Gateway