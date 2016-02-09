# get-AzureVMImage | Where-Object { $_.Label -like "Windows Server 2012 R2*" }

# Variables
#$AzureSubscriptionID = "db8ffa29-4fa6-4a1b-a539-c523ee7535c6"

$AzureSubscriptionID = (Get-AzureSubscription).SubscriptionId
$AzureStorageAccount = "sdpstorage01"
$Location = "SkogData-NE (North Europe)"
$VMname = "SDARR01"
$VMcloudservice = "SDARR"
$SourceVHD = "c:\temp\LocalDiskname.vhd"
$DestVHD = "http://" + $AzureStorageAccount + ".blob.core.windows.net/vhds/AzureDiskname.vhd"
$OSDiskPath = "https://" + $AzureStorageAccount + ".blob.core.windows.net/vhds/" + $VMname + "_OS_PIO.vhd"
$VMsize = "Standard_DS2"
#$imageName = "a699494373c04fc0bc8f2bb1389d6106__Windows-Server-2012-R2-201504.01-en.us-127GB.vhd" # Windows Server 2012 R2
$templates = get-AzureVMImage | Where-Object { $_.Label -like "Windows Server 2012 R2*" } | select imagename,PublishedDate | sort PublisedDate
$template = $templates | Select-Object -Last 1
$imageName = $template.ImageName
# $imageName = "fb83b3509582419d99629ce476bcb5c8__SQL-Server-2014RTM-12.0.2000.8-Standard-ENU-WS2012R2-AprilGA" # Windows Server 2012 R2 with SQL 2014
# $imageName = "b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-14_04_2_LTS-amd64-server-20150309-en-us-30GB" # Ubuntu Server 14.04 LTE
# $imageName = "b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-15_04-amd64-server-20150513-en-us-30GB" # Ubuntu Server 15.04
# $VMdisk = "GPNRAPPORTWEB-GPNRAPPORTWEB-0-201503231459370995"
$VMdomainName = "sdmfd1"
$VMdomainFQDN = "drift.sdnett.no"
$VMdomainUserName = "zos"
$VMdomainUserPw = "LumaSkog2015"
#$vmdomainuser = Get-Credential "Enter username and password for domain join"
$VMadminName = "localadmin"
$VMadminPw = "NorskeSkog-KongLear"
$VMTimeZone = "W. Europe Standard Time"
$affgroup = ""
$vnet = "skogdataazurenetwork"
$VMsubnet = "SkogData-Prod"

# Sets subscription and storage account
# Set-AzureSubscription -SubscriptionId $AzureSubscriptionID -CurrentStorageAccountName $AzureStorageAccount

# Create new cloud service
New-AzureService -ServiceName $VMcloudservice -Location $Location

# Option 1: Configures new virtual machine based on uploaded VHD disk
# Add-AzureVhd -LocalFilePath $SourceVHD -Destination $DestVHD 
# Add-AzureDisk -OS Windows -MediaLocation $DestVHD -DiskName $VMdisk
# $newVM = New-AzureVMConfig -Name $VMname -InstanceSize $VMsize -DiskName $VMdisk | 

# Option 2: Configures new virtual machine based on Azure Windows template (domain member)
$newVM = New-AzureVMConfig -Name $VMname -InstanceSize $VMsize -ImageName $imageName -MediaLocation $OSDiskPath | 
Add-AzureProvisioningConfig -WindowsDomain -AdminUsername $VMadminName -Password $VMadminPw -TimeZone $VMTimeZone -JoinDomain $VMdomainFQDN -Domain $VMdomainName -DomainUserName $VMdomainUserName -DomainPassword $VMdomainUserPw | 

# Option 3: Configures new virtual machine based on Azure Windows template (workgroup)
# $newVM = New-AzureVMConfig -Name $VMname -InstanceSize $VMsize -ImageName $imageName -MediaLocation $OSDiskPath | 
# Add-AzureProvisioningConfig -Windows -AdminUsername $VMadminName -Password $VMadminPw -TimeZone $VMTimeZone | 

# Option 4: Configures new virtual machine based on Azure Linux template
# $newVM = New-AzureVMConfig -Name $VMname -InstanceSize $VMsize -ImageName $imageName -MediaLocation $OSDiskPath | 
# Add-AzureProvisioningConfig -Linux -LinuxUser $VMadminName -Password $VMadminPw | 

# Set subnet (and static IP)
Set-AzureSubnet -SubNetNames $VMsubnet #| Set-AzureStaticVNetIP -IPAddress 10.200.2.4

# Creates the new virtual machine
New-AzureVM -ServiceName $VMcloudservice -VMs $newVM -VNetName $vnet

# Optional new premium datadisk
$AzureStorageAccount = "gpnpremiumstorage1"
$vmName ="GPNZIRIUS4"
$vm = Get-AzureVM -ServiceName $vmName -Name $vmName
$LunNo = 1
$path = "http://" + $AzureStorageAccount + ".blob.core.windows.net/vhds/" + $vmName + "_DataDisk_" + $LunNo + "_PIO.vhd"
$label = "Disk " + $LunNo
Add-AzureDataDisk -CreateNew -MediaLocation $path -DiskSizeInGB 128 -DiskLabel $label -LUN $LunNo -HostCaching ReadOnly -VM $vm | Update-AzureVm
