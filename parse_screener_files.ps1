$allStocks = @(
    "DIXON", "RELIANCE", "HAL", "CRAFTSMAN", "HDFCBANK", "TCS", "TRENT", "CDSL", "KAYNES", "TMCV", "TMPV", "ETERNAL", "KRN", "EMS"
)

function Extract-ScreenerRatio($html, $ratioName) {
    # Match the <li> containing the ratio name
    $pattern = '<span class="name">\s*' + [regex]::Escape($ratioName) + '\s*</span>[\s\S]*?<span class="nowrap value">[\s\S]*?<span class="number">([^<]+)</span>'
    if ($html -match $pattern) {
        return $matches[1].Trim()
    }
    return "N/A"
}

foreach ($sym in $allStocks) {
    $file = "screener_$($sym.ToLower()).html"
    if (Test-Path $file) {
        $html = Get-Content $file -Raw
        $price = Extract-ScreenerRatio $html "Current Price"
        $mcap = Extract-ScreenerRatio $html "Market Cap"
        $pe = Extract-ScreenerRatio $html "Stock P/E"
        $roce = Extract-ScreenerRatio $html "ROCE"
        $roe = Extract-ScreenerRatio $html "ROE"
        $book = Extract-ScreenerRatio $html "Book Value"
        $highLow = ""
        if ($html -match 'High / Low[\s\S]*?<span class="nowrap value">[^<]*<span class="number">([^<]+)</span>\s*/\s*<span class="number">([^<]+)</span>') {
            $highLow = "$($matches[1]) / $($matches[2])"
        }
        
        Write-Host "$sym`: Price=Rs $price | MCap=Rs $mcap Cr | P/E=$pe | ROCE=$roce% | ROE=$roe% | Book=Rs $book | HighLow=$highLow"
    }
}
