# Standalone SQL
Based on https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/iis-2vm-sql-1vm/azuredeploy.json. But removed web servers

### Deploy to azure
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https://raw.githubusercontent.com/Elsic/Div/master/ARM/StandaloneSQL/standalonesqldeploy.json) 

<a href="http://armviz.io/#/?load=https://raw.githubusercontent.com/Elsic/Div/master/ARM/NewTenant/NewTenantWithOMS.json" target="_blank">
    <img src="http://armviz.io/visualizebutton.png"/>
</a>

### Deploy using PowerShell:

New-AzureRmResourceGroupDeployment -Name Deploy01 -ResourceGroupName (New-AzureRmResourceGroup -Name NewTenant -Location "west europe").ResourceGroupName -TemplateUri "https://raw.githubusercontent.com/Elsic/Div/master/ARM/StandaloneSQL/standalonesqldeploy.json" -envprefixname "test"
