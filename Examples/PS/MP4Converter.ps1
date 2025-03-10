cd C:\CBCAP
$Query = "SELECT FilePath FROM CBScreenCap.dbo.RecordLog WHERE RecordEnd IS NOT NULL AND Converted = 0"
$ConversionPaths = Invoke-Sqlcmd -Query $Query -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 

ForEach ($ConversionPath in $ConversionPaths){
    $PathStr = $ConversionPath | Select -ExpandProperty FilePath
    $PathReplace = $PathStr.Replace(".mkv",".mp4")
    $PathCk = Test-Path $PathStr
    If ($PathCk -eq $true){
        start-process -FilePath "C:\CBCap\ffmpeg.exe" -ArgumentList "-i $PathStr -c copy $PathReplace" -Wait
        $UpdateLog = "UPDATE CBScreenCap.dbo.RecordLog SET ConversionDate = getdate(), Converted = 1, ConversionPath = '$PathReplace' WHERE FilePath = '$PathStr'"
        Invoke-Sqlcmd -query $UpdateLog -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 
        Remove-Item -Path $PathStr
    } else {
        $DeleteLog = "DELETE FROM CBScreenCap.dbo.RecordLog WHERE FilePath = '$PathStr'"
        Invoke-Sqlcmd -query $DeleteLog -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True" 
    }
}