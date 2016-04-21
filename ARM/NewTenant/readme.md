# Create new Tenant in Azure

## Synopsis

Used to create a new tenant in Public Azure, with Virtual Networks, Subnets, VM, NSG and Storage

### Deploy to azure
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenant.json) 

<a href="http://armviz.io/#/?load=https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenant.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Deploy using PowerShell:


New-AzureRmResourceGroupDeployment -Name Deploy01 -ResourceGroupName (New-AzureRmResourceGroup -Name NewTenant -Location "west europe").ResourceGroupName -TemplateUri "https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenant.json" -tenantvnetName "tenantvnet" -tenantname "tenant" -VMName "dc01" -VMAdminUserName "localadmin"

