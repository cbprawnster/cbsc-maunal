Clear
Function Title{
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
Write-Host "           Stream Saver Config"
Write-Host ""
}
Title

Write-Host "Use this utility to configure the output location for stream captures."
Write-Host "A network location such as a NAS can be used so long as it is mapped"
Write-Host "in Windows as a network drive."
Write-Host ""
Write-Host "Example: D:\CBStreams"
Write-Host "NOTE: Do not add the final \ to your path D:\CBStreams\ is NOT valid."
Write-Host ""
$StreamOutputLoc = Read-Host "Enter directory location"

# Creates the directory if it does not exist
$PathCk = Test-Path $StreamOutputLoc

If ($PathCk -eq $false){
    New-Item -Path "$StreamOutputLoc" -ItemType Directory | Out-Null
}

$ConfTest = Test-Path "C:\CBCAP\Output.conf"
If ($ConfTest -eq $false){
    Add-Content -Path "C:\CBCAP\Output.conf" -Value "$StreamOutputLoc"
} Else {
    Remove-Item -Path "C:\CBCAP\Output.conf"
    Add-Content -Path "C:\CBCAP\Output.conf" -Value "$StreamOutputLoc"
}
