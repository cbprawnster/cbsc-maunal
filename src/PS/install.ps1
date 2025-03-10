# CB Screen Cap Installer

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
Write-Host "               Installer"
Write-Host ""

# Suppress progress bars for Start-BitsTransfer
$OriginalPref = $ProgressPreference # Default is 'Continue'
$ProgressPreference = "SilentlyContinue"


Function LogDt{
    $date = get-date -format "yyyy-MM-dd HH:MM:SS"
    write-host "$date -"
}

$TempCk = Test-Path "C:\Temp"
$InstallCk = Test-Path "C:\Temp\CBSCInstall"

If ($TempCk -eq $false){
    Write-Host "$LogDt Creating Temp Directory"
    New-Item -Path "C:\Temp" -ItemType Directory | Out-Null
}

If ($InstallCk -eq $false){
    Write-Host "$LogDt Creating Temp Install Directory"
    New-Item -Path "C:\Temp\CBSCInstall" -ItemType Directory | Out-Null
}

# Download required software
# SQL Server Express 2022
Write-Host "$LogDt Downloading SQL Server Express 2022"
Start-BitsTransfer -Source "https://download.microsoft.com/download/5/1/4/5145fe04-4d30-4b85-b0d1-39533663a2f1/SQL2022-SSEI-Expr.exe" -Destination "C:\Temp\CBSCInstall"

# 7-Zip
Write-Host "$LogDt Downloading 7-Zip"
Start-BitsTransfer -Source "https://www.7-zip.org/a/7z2409-x64.exe" -Destination "C:\Temp\CBSCInstall"

# FFMPEG
Write-Host "$LogDt Downloading FFMPEG"
Start-BitsTransfer -Source "https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-essentials.7z" -Destination "C:\Temp\CBSCInstall"

# Install Software

# 7-Zip
Write-Host "$LogDt Installing 7-Zip"
Start-Process -FilePath ".\Temp\CBSCInstall\7z2409-x64.exe" -ArgumentList "/S" -Wait

# SQL Server Express
Write-Host "$LogDt Installing SQL Server Express 2022"
Start-Process -FilePath ".\SQL2022-SSEI-Expr.exe" -ArgumentList "/ACTION=Download MEDIAPATH=C:\Temp\CBSCInstall /MEDIATYPE=Core /QUIET" -Wait
Start-Process -FilePath ".\SQLEXPR_x64_ENU.exe" -ArgumentList "/q /x:.\SQLEXPR_2022" -Wait
Start-Process -FilePath ".\SQLEXPR_2022\Setup.exe" -ArgumentList "/ConfigurationFile=.\src\SQL\ConfigurationFile2.ini" -Wait

Write-Host "End"

# Reset progress preference
$ProgressPreference = $OriginalPref