
function ErDetHelg {
    $day = (get-date).DayOfWeek
    $time = Get-date -Format HH

    if ($day -like "Friday") {
        if (($time -gt 15) -or ($time -like 15)) {
            Write-host "Det er fredag og klokken er over 15. God Helg" -ForegroundColor Green
        }
        elseif ($time -lt 15) {
            Write-host "Klokken er ikke helt 15. Jobb videre" -ForegroundColor Yellow
        }
    }
    elseif (($day -like "Saturday") -or ($day -like "Saturday")) {
        Write-Host "Det er helg"
    }
    else {
        Write-Host "Det er ikke helg enda" -ForegroundColor Red
    }

}


ErDetHelg
pause