$SiteMap = Invoke-WebRequest -Uri "https://chaturbate.com/sitemap.xml"
$xml = [xml]$SiteMap.Content

$Broadcasters = $xml.sitemapindex.sitemap | where loc -like "*broadcasters*" | Select -ExpandProperty loc

ForEach ($Broadcaster in $Broadcasters){
    $BroadcasterURI = Invoke-WebRequest -Uri "$Broadcaster"
    $xml2 = [xml]$BroadcasterURI.Content

    $CamURLs = $xml2.urlset.url | Select -ExpandProperty loc

    ForEach ($CamURL in $CamURLs){
        $cleanup1 = $CamURL.Replace("https://chaturbate.com/","")
        $cleanup2 = $cleanup1.Replace("/","")
        
        $Model = $cleanup2

        $Query = "INSERT INTO [dbo].[Models] ([ScreenName],[Online],[URL],[PID],[DoRecord]) VALUES ('$Model','','','',1)"
        Invoke-Sqlcmd -Query $Query -ConnectionString "Data Source=localhost\SQLEXPRESS;Initial Catalog=CBScreenCap;Integrated Security=True"
    }
}