#$path = Read-Host "file location"

$wodlist = Get-Content "C:\GitHub\Div\Workout\WODs.txt"
$z = "3"

#$wods = Get-Content $path

$i = $wodlist.Length


for ($y=1; $y -le $z; $y++) {
    $wodnr = Get-Random -Minimum 0 -Maximum $i
    $wodlist[$wodnr]
}


#for($i=1; $i -le 10; $i++){Write-Host $i}