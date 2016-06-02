# Create new Tenant in Azure

## Synopsis
NewTenantWithDC.json
Used to create a new tenant in Public Azure, with Virtual Networks, Subnets, VM, NSG and Storage

### Deploy to azure
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantWithDC.json) 

<a href="http://armviz.io/#/?load=https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantWithOMS.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Deploy using PowerShell:

New-AzureRmResourceGroupDeployment -Name Deploy01 -ResourceGroupName (New-AzureRmResourceGroup -Name NewTenant -Location "west europe").ResourceGroupName -TemplateUri "https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantWithDC.json" -tenantvnetName "tenantvnet" -tenantname "tenant"


## Synopsis
Used to create a new tenant in Public Azure, with Virtual Networks, Subnets, NSG and Storage
NewTenantResources.json
### Deploy to azure
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantResources.json) 

<a href="http://armviz.io/#/?load=https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantResources.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Deploy using PowerShell:

New-AzureRmResourceGroupDeployment -Name Deploy01 -ResourceGroupName (New-AzureRmResourceGroup -Name NewTenant -Location "west europe").ResourceGroupName -TemplateUri "https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantResources.json" -tenantvnetName "tenantvnet" -tenantname "tenant"

## Synopsis
Used to create a new tenant in Public Azure, with Virtual Networks, Subnets, VM, NSG, Storage and connect to existing OMS workspace
NewTenantWithOMS.json
### Deploy to azure
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantWithOMS.json) 

<a href="http://armviz.io/#/?load=https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantWithOMS.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Deploy using PowerShell:

New-AzureRmResourceGroupDeployment -Name Deploy01 -ResourceGroupName (New-AzureRmResourceGroup -Name NewTenant -Location "west europe").ResourceGroupName -TemplateUri "https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantWithOMS.json" -tenantvnetName "tenantvnet" -tenantname "tenant"

