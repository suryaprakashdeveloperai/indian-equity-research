# Test 1: Yahoo Finance Free News API for Indian Stocks
try {
    $yRes = Invoke-RestMethod -Uri "https://query2.finance.yahoo.com/v1/finance/search?q=TATAMOTORS.NS&newsCount=5" -Headers @{"User-Agent"="Mozilla/5.0"}
    Write-Host "=== YAHOO FINANCE FREE API ==="
    Write-Host "Count: $($yRes.news.Count)"
    Write-Host "Top News: $($yRes.news[0].title)"
    Write-Host "Publisher: $($yRes.news[0].publisher)"
    Write-Host "Link: $($yRes.news[0].link)"
} catch {
    Write-Host "Yahoo Finance Error: $($_.Exception.Message)"
}

# Test 2: Reddit r/IndianStreetBets Hot API (Free, Zero Key)
try {
    $rRes = Invoke-RestMethod -Uri "https://www.reddit.com/r/IndianStreetBets/hot.json?limit=5" -Headers @{"User-Agent"="Mozilla/5.0"}
    Write-Host "`n=== REDDIT INDIAN STREET BETS API ==="
    Write-Host "Count: $($rRes.data.children.Count)"
    Write-Host "Top Post: $($rRes.data.children[1].data.title)"
} catch {
    Write-Host "Reddit Error: $($_.Exception.Message)"
}
