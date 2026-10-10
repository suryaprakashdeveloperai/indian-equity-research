try {
    $res = Invoke-WebRequest -Uri 'https://news.google.com/rss/search?q=NSE+Sensex+Nifty+Stock+Market+India&hl=en-IN&gl=IN&ceid=IN:en' -UseBasicParsing
    [xml]$xml = $res.Content
    Write-Host "Count: $($xml.rss.channel.item.Count)"
    Write-Host "Top Item: $($xml.rss.channel.item[0].title)"
    Write-Host "PubDate: $($xml.rss.channel.item[0].pubDate)"
} catch {
    Write-Host "Error: $($_.Exception.Message)"
}
