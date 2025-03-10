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
Write-Host "               Model Adder"
Write-Host ""
}
Title

While ($continue -ne "n"){
    Write-Host "Add a new model:"
    $Model = Read-Host "Enter screenname"
    Write-Host "You have added $Model to your recording schedule"
    $Query = "INSERT INTO [dbo].[Models] ([ScreenName],[Online],[URL],[PID],[DoRecord]) VALUES ('$Model','','','',1)"
    Invoke-Sqlcmd -Query $Query -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True"
    $continue = Read-Host "Do you want to add another? (Y/N)"
}