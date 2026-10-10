$feeds = @(
    @{ Name="Moneycontrol Stocks"; Url="https://www.moneycontrol.com/rss/MCtopnews.xml" },
    @{ Name="Economic Times Markets"; Url="https://economictimes.indiatimes.com/markets/stocks/rssfeeds/2146842.cms" },
    @{ Name="Livemint Markets"; Url="https://www.livemint.com/rss/markets" },
    @{ Name="Google News NSE"; Url="https://news.google.com/rss/search?q=NSE+Sensex+Nifty+India&hl=en-IN&gl=IN&ceid=IN:en" }
)

foreach ($f in $feeds) {
    try {
        $res = Invoke-WebRequest -Uri $f.Url -Headers @{"User-Agent"="Mozilla/5.0"} -UseBasicParsing -TimeoutSec 5
        [xml]$xml = $res.Content
        Write-Host "SUCCESS: $($f.Name) | Items: $($xml.rss.channel.item.Count) | Latest: $($xml.rss.channel.item[0].title)"
    } catch {
        Write-Host "FAILED: $($f.Name) - $($_.Exception.Message)"
    }
}
