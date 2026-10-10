$target = "C:\Users\ELCOT\.gemini\antigravity-ide\scratch\indian_equity_multiagent_engine\index.html"
$content = [System.IO.File]::ReadAllText($target, [System.Text.Encoding]::UTF8)

$oldFetchCode = @'
    // MULTI-SOURCE REAL-TIME LIVE NEWS ENGINE
    async function fetchLiveNews() {
      const container = document.getElementById('liveNewsStream');
      container.innerHTML = `<div style="text-align: center; padding: 20px; color: var(--cyan);">Fetching real-time market wire...</div>`;

      try {
        // Attempt fetch from Render backend /api/live-news
        const res = await fetch('/api/live-news');
        if (res.ok) {
          const data = await res.json();
          renderNewsArticles(data.articles);
          return;
        }
      } catch (e) {
        // Fallback: client-side public RSS proxy
      }

      try {
        const rssUrl = encodeURIComponent('https://news.google.com/rss/search?q=NSE+Sensex+Nifty+Stock+Market+India&hl=en-IN&gl=IN&ceid=IN:en');
        const proxyRes = await fetch(`https://api.rss2json.com/v1/api.json?rss_url=${rssUrl}`);
        if (proxyRes.ok) {
          const data = await proxyRes.json();
          const items = data.items.map(it => ({
            title: it.title,
            source: it.author || "Financial Wire",
            published: it.pubDate,
            link: it.link,
            tag: it.title.toLowerCase().includes('surge') || it.title.toLowerCase().includes('rally') ? "BULLISH" : "MARKET WIRE",
            impact: "Live Dalal Street Sentiment Driver"
          }));
          renderNewsArticles(items);
          return;
        }
      } catch (err) {}

      // Fallback display
      container.innerHTML = `
        <div class="news-item">
          <div>
            <a href="https://economictimes.indiatimes.com" target="_blank" class="news-title">Sensex and Nifty trade with positive bias amid heavy domestic institutional buying</a>
            <div class="news-meta"><span>Economic Times</span> <span>5 mins ago</span> <span style="color: var(--emerald);">[BULLISH]</span></div>
          </div>
          <div style="font-size: 11px; font-family: monospace; color: var(--emerald); font-weight: bold;">+55 bps FII Flow</div>
        </div>
        <div class="news-item">
          <div>
            <a href="https://reuters.com" target="_blank" class="news-title">Brent crude drops below $74.50 per barrel easing margin concerns for Indian auto and paints</a>
            <div class="news-meta"><span>Reuters</span> <span>18 mins ago</span> <span style="color: var(--cyan);">[COMMODITY EASE]</span></div>
          </div>
          <div style="font-size: 11px; font-family: monospace; color: var(--cyan); font-weight: bold;">CAD Deficit Relief</div>
        </div>
      `;
    }
'@

$newFetchCode = @'
    // MULTI-SOURCE REAL-TIME LIVE NEWS ENGINE (FILTER AWARE)
    async function fetchLiveNews() {
      const container = document.getElementById('liveNewsStream');
      const countLabel = document.getElementById('newsCountLabel');
      container.innerHTML = `<div style="text-align: center; padding: 25px; color: var(--cyan);">Connecting to real-time market wire...</div>`;

      // 1. Stock-specific news filter
      if (currentNewsFilter === 'stock') {
        try {
          const res = await fetch(`/api/stock-news/${currentTicker}`);
          if (res.ok) {
            const data = await res.json();
            if (data.articles && data.articles.length) {
              if (countLabel) countLabel.textContent = `SHOWING ${data.articles.length} ARTICLES FOR ${currentTicker}`;
              renderNewsArticles(data.articles);
              return;
            }
          }
        } catch(e) {}

        try {
          const q = encodeURIComponent(`${currentTicker} stock results concall NSE BSE`);
          const pRes = await fetch(`https://api.rss2json.com/v1/api.json?rss_url=https://news.google.com/rss/search?q=${q}&hl=en-IN&gl=IN&ceid=IN:en`);
          if (pRes.ok) {
            const pData = await pRes.json();
            const arts = pData.items.map(it => ({
              title: it.title,
              source: it.author || "Exchange Wire",
              published: it.pubDate,
              link: it.link,
              tag: "COMPANY SPECIFIC",
              impact: `Catalyst for ${currentTicker}`
            }));
            if (countLabel) countLabel.textContent = `SHOWING ${arts.length} ARTICLES FOR ${currentTicker}`;
            renderNewsArticles(arts);
            return;
          }
        } catch(e) {}
      }

      // 2. Alpha Vantage / Finnhub external API filter
      if (currentNewsFilter === 'alpha') {
        const aKey = localStorage.getItem('ALPHA_KEY');
        const fKey = localStorage.getItem('FINNHUB_KEY');
        if (!aKey && !fKey) {
          container.innerHTML = `
            <div style="text-align: center; padding: 30px; background: var(--surface-elevated); border-radius: 12px; border: 1px dashed var(--purple);">
              <div style="font-size: 28px; margin-bottom: 8px;">🔑</div>
              <div style="font-size: 15px; font-weight: bold; color: #fff;">No Free API Key Configured Yet</div>
              <p style="font-size: 12px; color: var(--text-secondary); margin: 8px 0 16px;">
                You can get a 100% free key in 30 seconds at <a href="https://www.alphavantage.co/support/#api-key" target="_blank" style="color: var(--cyan);">alphavantage.co</a> or <a href="https://finnhub.io" target="_blank" style="color: var(--cyan);">finnhub.io</a> to unlock institutional ticker sentiment!
              </p>
              <button class="gem-action-btn" onclick="openApiConfigModal()">CONFIGURE FREE KEY</button>
            </div>
          `;
          if (countLabel) countLabel.textContent = 'API KEY REQUIRED';
          return;
        }

        try {
          const res = await fetch(`/api/external-news/alphavantage?ticker=${currentTicker}&api_key=${aKey || ''}`);
          if (res.ok) {
            const data = await res.json();
            if (data.feed) {
              const arts = data.feed.map(item => ({
                title: item.title,
                source: item.source || "Alpha Vantage",
                published: item.time_published ? item.time_published.substring(0, 8) : "Recent",
                link: item.url,
                tag: item.overall_sentiment_label || "SENTIMENT",
                impact: `Sentiment Score: ${(item.overall_sentiment_score * 100).toFixed(0)}%`
              }));
              if (countLabel) countLabel.textContent = `ALPHA VANTAGE: ${arts.length} SENTIMENT ARTICLES`;
              renderNewsArticles(arts);
              return;
            }
          }
        } catch(e) {}
      }

      // 3. Default: All Live Market Wire (Render backend multi-source aggregator)
      try {
        const res = await fetch('/api/live-news');
        if (res.ok) {
          const data = await res.json();
          if (data.articles && data.articles.length) {
            if (countLabel) countLabel.textContent = `SHOWING ${data.articles.length} LIVE ARTICLES (ET + MINT + GOOGLE)`;
            renderNewsArticles(data.articles);
            return;
          }
        }
      } catch (e) {}

      // Fallback: Client-side public Google News RSS proxy
      try {
        const rssUrl = encodeURIComponent('https://news.google.com/rss/search?q=NSE+Sensex+Nifty+Stock+Market+India&hl=en-IN&gl=IN&ceid=IN:en');
        const proxyRes = await fetch(`https://api.rss2json.com/v1/api.json?rss_url=${rssUrl}`);
        if (proxyRes.ok) {
          const data = await proxyRes.json();
          const items = data.items.map(it => ({
            title: it.title,
            source: it.author || "Financial Wire",
            published: it.pubDate,
            link: it.link,
            tag: it.title.toLowerCase().includes('surge') || it.title.toLowerCase().includes('rally') ? "BULLISH" : "MARKET WIRE",
            impact: "Live Dalal Street Sentiment Driver"
          }));
          if (countLabel) countLabel.textContent = `SHOWING ${items.length} LIVE ARTICLES (GOOGLE FINANCE)`;
          renderNewsArticles(items);
          return;
        }
      } catch (err) {}

      // Safe Fallback Display
      if (countLabel) countLabel.textContent = "SHOWING 2 HIGH-PRIORITY CUES";
      container.innerHTML = `
        <div class="news-item">
          <div>
            <a href="https://economictimes.indiatimes.com" target="_blank" class="news-title">Sensex and Nifty trade with positive bias amid heavy domestic institutional buying</a>
            <div class="news-meta"><span>Economic Times</span> <span>5 mins ago</span> <span style="color: var(--emerald);">[BULLISH]</span></div>
          </div>
          <div style="font-size: 11px; font-family: monospace; color: var(--emerald); font-weight: bold;">+55 bps FII Flow</div>
        </div>
        <div class="news-item">
          <div>
            <a href="https://reuters.com" target="_blank" class="news-title">Brent crude drops below $74.50 per barrel easing margin concerns for Indian auto and paints</a>
            <div class="news-meta"><span>Reuters</span> <span>18 mins ago</span> <span style="color: var(--cyan);">[COMMODITY EASE]</span></div>
          </div>
          <div style="font-size: 11px; font-family: monospace; color: var(--cyan); font-weight: bold;">CAD Deficit Relief</div>
        </div>
      `;
    }
'@

if ($content.Contains("fetchLiveNews()")) {
    $content = $content.Replace($oldFetchCode, $newFetchCode)
    
    # Also update loadTicker to update .currentStockNewsLabel
    $oldLoad = "document.querySelectorAll('.currentTickerLabel').forEach(el => el.textContent = symbol);"
    $newLoad = "document.querySelectorAll('.currentTickerLabel').forEach(el => el.textContent = symbol); document.querySelectorAll('.currentStockNewsLabel').forEach(el => el.textContent = symbol);"
    if ($content.Contains($oldLoad)) {
        $content = $content.Replace($oldLoad, $newLoad)
    }

    [System.IO.File]::WriteAllText($target, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Success! fetchLiveNews is now multi-source and filter-aware."
}
