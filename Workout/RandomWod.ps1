#$path = Read-Host "file location"
#$wodlist = Get-Content "C:\GitHub\Div\Workout\WODs.txt"

$url = "https://raw.githubusercontent.com/Elsic/Div/master/Workout/WODs.txt"
$output = "$PSScriptRoot\DownloadedWODs.txt"
Invoke-WebRequest -Uri $url -OutFile $output
$wodlist = Get-Content $output

$z = "3"

$i = $wodlist.Length

for ($y=1; $y -le $z; $y++) {
    $wodnr = Get-Random -Minimum 0 -Maximum $i
    $wodlist[$wodnr]
}

Remove-Item $output -Force
