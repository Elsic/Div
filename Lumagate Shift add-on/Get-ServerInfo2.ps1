$inFile = "C:\Downloads\Servere-v5.csv"
$outfile = "C:\Downloads\outServere-v5.csv"

$oServers = @()
$oServers = Import-Csv -Path $infile -Delimiter ";"

#$oServers = @()

#$oServers | Add-Member –MemberType NoteProperty –Name PingTest –Value $null
#$oServers | Add-Member –MemberType NoteProperty –Name NameResolutionSucceeded –Value $null

foreach ($server in $oServers) {


        #Usedspace math...
        [string]$usedspace = $null
        $usedspace = $server.'Totalt diskplass'

        if ($usedspace -like "*GB*") {
            $usedspace = $usedspace.trim("GB")
            $usedspace = $usedspace.trim(" ")
            [double]$usedspace = $usedspace
            $server.'Totalt diskplass' = $usedspace

        }
        if ($usedspace -like "*TB*") {
            $usedspace = $usedspace.trim("TB")
            $usedspace = $usedspace.trim(" ")
            [double]$usedspace = $usedspace
            $usedspace = $usedspace * 1024
            $server.'Totalt diskplass' = $usedspace
        }

    if (($server.Migreres -eq "JA") -and ($server.Servernavn -ne "") -and ($server.PowerState -eq "Powered On")) {
    
        #Reset variables
        $pingstat = $null
        $remotePS = $null
        $disks = $null
        $dotnet = $null

        Write-Host "Tester " $server.Servernavn -ForegroundColor Yellow

        #Collect info
        $pingstat = Test-NetConnection -ComputerName $server.Servernavn -Hops 1 -ErrorAction Ignore
        if ($pingstat.PingSucceeded -eq $true) {
            Write-Host "Pingtest " $server.Servernavn " ok" -ForegroundColor Green
        }
        $remotePS = [bool](Test-WSMan -ComputerName $server.Servernavn -ErrorAction Ignore)


        if ($remotePS -eq $true) {
            Write-Host "RemotePS " $server.Servernavn " ok" -ForegroundColor Green

            #Check disk
            $disks = Get-WmiObject Win32_logicaldisk -ComputerName $server.Servernavn -ErrorAction Ignore
            if ($disks.Count -ne 1) {
                foreach ($disk in $disks| where {$_.DriveType -eq 3}) {
                    $disk.FreeSpace = $disk.FreeSpace/1024/1024
                    $server.'Ledig diskplass' += $disk.DeviceID + " "+ $disk.FreeSpace.ToString() + ","
                }
            }
            else {
            $server.'Ledig diskplass' = $disk.FreeSpace/1024/1024
            }
            
            #Check cluster
            $clusvc = Get-Service -ComputerName $server.Servernavn -Name ClusSvc -ErrorAction Ignore
            #Check nlb
            $nlbsvc = Get-Service -ComputerName $server.Servernavn -Name wlbs -ErrorAction Ignore
                
        }
        else {
            Write-Host "RemotePS failed " $server.Servernavn -ForegroundColor Red
        }



        

        $numberofDisks = ($disks | where {$_.DriveType -eq 3}) | Measure-Object

        #$dotnetjob = Invoke-Command -ComputerName $server.Servernavn -ScriptBlock {
        #    Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -ErrorAction SilentlyContinue
        #} -AsJob -ErrorAction Ignore
        #Wait-Job $dotnetjob | Out-Null
        #$dotnet = Receive-Job $dotnetjob

        $dotnetversions = C:\Downloads\Get-NetFrameworkVersion.ps1 -ComputerName $server.Servernavn
        $dotnetversions[-1]


        #Write information to object
        if ($pingstat.PingReplyDetails.Status -ne $null) {
            $server.PingTest = $pingstat.PingReplyDetails.Status
        }
        else {
            $server.PingTest = "False"
        }
        $server.NameResolutionSucceeded = $pingstat.NameResolutionSucceeded
        if ($pingstat.NameResolutionSucceeded -eq $true) {
            $server.IP = $pingstat.RemoteAddress
        }
        $server.RemotePowerShell = $remotePS
        if ($dotnetversions -ne "") {
        $server.dotnet = $dotnetversions[-1].NetFXVersion + "." + $dotnetversions[-1].NetFXBuild
        }
        else {
            $server.dotnet = "NA"
        }
        $server.Disks = $numberofDisks.Count
        $server.Cluster = $clusvc.Status
        $server.NLB = $nlbsvc.Status
        



    }
    if ($server.Migreres -eq "NEI") {
        Write-host $server.Servernavn " skal ikke migreres" -ForegroundColor Red
    }
    if ($server.PowerState -eq "Powered Off") {
        Write-host $server.Servernavn " er slått av" -ForegroundColor Red
    }
}

Write-Output $oServers | Export-Csv -Path $outfile -Delimiter ";" -NoTypeInformation -Encoding Unicode