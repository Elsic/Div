#juleøl


$url = "http://www.adressa.no/masq/juleoltest/2016/data/butikk.json"
$output = "$PSScriptRoot\butikk.json"

Invoke-WebRequest -Uri $url -OutFile $output


$url2 = "http://www.adressa.no/masq/juleoltest/2016/data/sterk.json"
$output2 = "$PSScriptRoot\sterk.json"

Invoke-WebRequest -Uri $url2 -OutFile $output2

#Get-Content $output -Encoding UTF8



$json = Get-Content -Path $output -Encoding UTF8 | ConvertFrom-Json


$json2 = Get-Content -Path $output2 -Encoding UTF8| ConvertFrom-Json


$json
$json2

$beer = $json + $json2
$beer