Clear

Write-Host ""
Write-Host -ForegroundColor DarkRed " .o88b. d8888b.      .d8888.  .o88b. "
Write-Host -ForegroundColor Red "d8P  Y8 88  `8D      88'  YP d8P  Y8 "
Write-Host -ForegroundColor Red "8P      88oooY'      `8bo.   8P      "
Write-Host -ForegroundColor Yellow "8b      88~~~b.        `Y8b. 8b      "
Write-Host -ForegroundColor Yellow "Y8b  d8 88   8D      db   8D Y8b  d8 "
Write-Host -ForegroundColor DarkYellow " ``Y88P' Y8888P'      ``8888Y'  ``Y88P' "
Write-Host ""
Write-Host "       Chaturbate Stream Capture"
Write-Host "                 V 1.0"
Write-Host "              Config Util"
Write-Host ""

Function LogDt{
    $date = get-date -format "yyyy-MM-dd HH:MM:SS"
    write-host "$date -"
}

$Paths = ("C:\Temp\CBSCInstall\FFMPEG")

ForEach ($Path in $Paths){
    $PathCk = Test-Path $Path

    If ($PathCk -eq $false){
        New-Item -Path "$Path" -ItemType Directory | Out-Null
    }
}

# Extract 7-Zip Binaries
Write-Host LogDt " Extracting FFMPEG Binaries"
Start-Process "C:\Program Files\7-Zip\7z.exe" -ArgumentList "e -oC:\Temp\CBSCInstall\FFMPEG C:\Temp\CBSCInstall\ffmpeg-git-essentials.7z" -Wait

# Setup Database
Write-Host LogDt " Creating database and tables"
Invoke-Sqlcmd -InputFile ".\src\SQL\DBCreate.sql" -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=Master;Integrated Security=True"

# Create app directory structure
Write-Host LogDt " Creating Directory Structure"
$Paths = ("C:\CBCap")

ForEach ($Path in $Paths){
    $PathCk = Test-Path $Path

    If ($PathCk -eq $false){
        New-Item -Path "$Path" -ItemType Directory | Out-Null
    }
}

Copy-Item -Path "C:\Temp\CBSCInstall\FFMPEG\ffmpeg.exe" -Destination "C:\CBCAP"
Copy-Item -Path ".\src\PS\modeladder.ps1" -Destination "C:\CBCAP"
Copy-Item -Path ".\src\PS\SQLOnlineCheck.ps1" -Destination "C:\CBCAP"
Copy-Item -Path ".\src\BAT\AddModel.bat" -Destination "C:\CBCAP"
Copy-Item -Path ".\src\BAT\CBSC.bat" -Destination "C:\CBCAP"
Copy-Item -Path ".\src\Bat\Configure.bat" -Destination "C:\CBCAP"
Copy-Item -Path ".\src\PS\outputconf.ps1" -Destination "C:\CBCAP"