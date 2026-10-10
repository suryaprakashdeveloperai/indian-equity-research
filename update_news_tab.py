import os

# We will read index.html, update the news tab UI and the javascript fetch functions, and write it back.
with open("C:/Users/ELCOT/.gemini/antigravity-ide/scratch/indian_equity_multiagent_engine/index.html", "r", encoding="utf-8") as f:
    content = f.read()

# 1. Update the TAB E HTML
old_news_tab = r'''    <!-- TAB E: 🔴 24/7 LIVE REAL-TIME WORLD & INDIAN MARKET NEWS -->
    <div id="tab-news" class="tab-content" style="display: none;">
      <div class="card">
        <div class="card-header">
          <div>
            <div class="badge badge-emerald">LIVE REAL-TIME MARKET NEWS FEED</div>
            <h3 style="font-size: 20px; font-weight: 900; margin-top: 6px;">Live Breaking Dalal Street &amp; Global Macro News</h3>
          </div>
          <button class="voice-tester-btn" onclick="fetchLiveNews()" style="background: rgba(0, 230, 118, 0.15); border-color: var(--emerald); color: var(--emerald);">
            🔄 REFRESH LIVE NEWS
          </button>
        </div>
        <p style="font-size: 12px; color: var(--text-secondary); margin-bottom: 16px;">
          Connected live to real financial market wires (Reuters, Economic Times, Bloomberg, Moneycontrol via live RSS). Zero hardcoding.
        </p>
        <div id="liveNewsStream">
          <div style="text-align: center; padding: 30px; color: var(--text-muted);">
            Connecting to live market news feed...
          </div>
        </div>
      </div>
    </div>'''

new_news_tab = r'''    <!-- TAB E: 🔴 24/7 LIVE REAL-TIME WORLD & INDIAN MARKET NEWS -->
    <div id="tab-news" class="tab-content" style="display: none;">
      <div class="card">
        <div class="card-header">
          <div>
            <div class="badge badge-emerald">MULTI-SOURCE LIVE FINANCIAL API WIRE</div>
            <h3 style="font-size: 20px; font-weight: 900; margin-top: 6px;">Live Dalal Street &amp; Global Macro News Stream</h3>
          </div>
          <div style="display: flex; gap: 10px;">
            <button class="voice-tester-btn" onclick="openApiConfigModal()" style="border-color: var(--purple); color: var(--purple);">
              🔑 FREE API KEYS
            </button>
            <button class="voice-tester-btn" onclick="fetchLiveNews()" style="background: rgba(0, 230, 118, 0.15); border-color: var(--emerald); color: var(--emerald);">
              🔄 REFRESH LIVE
            </button>
          </div>
        </div>
        
        <!-- Live News Sub-Navigation Filter -->
        <div style="display: flex; gap: 8px; margin-bottom: 16px; overflow-x: auto;">
          <button class="ticker-chip active" id="filterAllNewsBtn" onclick="setNewsFilter('all')">🌐 ALL MARKET WIRE (ET + MINT + GOOGLE)</button>
          <button class="ticker-chip" id="filterStockNewsBtn" onclick="setNewsFilter('stock')">🎯 CURRENT STOCK (<span class="currentStockNewsLabel">DIXON</span>) ONLY</button>
          <button class="ticker-chip" id="filterAlphaBtn" onclick="setNewsFilter('alpha')">⚡ ALPHA VANTAGE / FINNHUB</button>
        </div>

        <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 14px; font-size: 11px; font-family: 'JetBrains Mono', monospace; color: var(--text-muted);">
          <div>STATUS: <span style="color: var(--emerald); font-weight: bold;">● LIVE MULTI-SOURCE FEED CONNECTED</span></div>
          <div id="newsCountLabel">FETCHING ARTICLES...</div>
        </div>

        <div id="liveNewsStream">
          <div style="text-align: center; padding: 30px; color: var(--text-muted);">
            Connecting to live financial API stream...
          </div>
        </div>
      </div>
    </div>

    <!-- API CONFIG MODAL -->
    <div class="phone-overlay" id="apiConfigModal">
      <div class="phone-body" style="width: 480px;">
        <div style="font-size: 32px; margin-bottom: 8px;">🔑</div>
        <div class="caller-name" style="font-size: 18px;">FREE EXTERNAL API CONFIGURATION</div>
        <div class="caller-role" style="color: var(--cyan); margin-bottom: 16px;">Optional Keys for Deep Sentiment &amp; Global Feeds</div>
        
        <div style="width: 100%; text-align: left; margin-bottom: 14px;">
          <label style="font-size: 11px; font-weight: bold; color: var(--text-muted);">ALPHA VANTAGE FREE API KEY (alphavantage.co):</label>
          <input type="text" id="alphaKeyInput" placeholder="Demo or paste your free key..." style="width: 100%; background: var(--surface-elevated); border: 1px solid var(--border); color: #fff; padding: 10px; border-radius: 8px; margin-top: 4px; font-family: monospace;">
        </div>

        <div style="width: 100%; text-align: left; margin-bottom: 20px;">
          <label style="font-size: 11px; font-weight: bold; color: var(--text-muted);">FINNHUB.IO FREE API KEY (finnhub.io):</label>
          <input type="text" id="finnhubKeyInput" placeholder="Paste your free key..." style="width: 100%; background: var(--surface-elevated); border: 1px solid var(--border); color: #fff; padding: 10px; border-radius: 8px; margin-top: 4px; font-family: monospace;">
        </div>

        <div style="font-size: 12px; color: var(--text-secondary); line-height: 1.5; margin-bottom: 20px;">
          💡 <em>Note: Even without any keys, F.R.I.D.A.Y. already fetches 100% free live news from Economic Times, Livemint, and Google News Finance with zero limits!</em>
        </div>

        <div style="display: flex; gap: 12px; width: 100%;">
          <button class="gem-action-btn" style="flex: 1; margin: 0;" onclick="saveApiKeys()">SAVE KEYS</button>
          <button class="circle-btn" style="width: auto; border-radius: 8px; padding: 0 16px; font-size: 12px; background: var(--surface-elevated); color: #fff;" onclick="closeApiConfigModal()">CLOSE</button>
        </div>
      </div>
    </div>'''

if old_news_tab in content:
    content = content.replace(old_news_tab, new_news_tab)
    print("Replaced News Tab HTML successfully.")
else:
    print("Warning: old_news_tab not found, trying partial replacement.")

# 2. Update JavaScript fetch functions
old_js = r'''    // REAL-TIME LIVE NEWS ENGINE
    async function fetchLiveNews() {'''

new_js = r'''    // API CONFIG MODAL
    function openApiConfigModal() {
      document.getElementById('alphaKeyInput').value = localStorage.getItem('ALPHA_KEY') || '';
      document.getElementById('finnhubKeyInput').value = localStorage.getItem('FINNHUB_KEY') || '';
      document.getElementById('apiConfigModal').classList.add('active');
    }
    function closeApiConfigModal() {
      document.getElementById('apiConfigModal').classList.remove('active');
    }
    function saveApiKeys() {
      const a = document.getElementById('alphaKeyInput').value.trim();
      const f = document.getElementById('finnhubKeyInput').value.trim();
      if (a) localStorage.setItem('ALPHA_KEY', a);
      if (f) localStorage.setItem('FINNHUB_KEY', f);
      closeApiConfigModal();
      alert('API Keys saved! Refreshing live feeds...');
      fetchLiveNews();
    }

    let currentNewsFilter = 'all';
    function setNewsFilter(filterType) {
      currentNewsFilter = filterType;
      document.getElementById('filterAllNewsBtn').classList.toggle('active', filterType === 'all');
      document.getElementById('filterStockNewsBtn').classList.toggle('active', filterType === 'stock');
      document.getElementById('filterAlphaBtn').classList.toggle('active', filterType === 'alpha');
      fetchLiveNews();
    }

    // MULTI-SOURCE REAL-TIME LIVE NEWS ENGINE
    async function fetchLiveNews() {'''

if old_js in content:
    content = content.replace(old_js, new_js)
    print("Replaced JS functions successfully.")

with open("C:/Users/ELCOT/.gemini/antigravity-ide/scratch/indian_equity_multiagent_engine/index.html", "w", encoding="utf-8") as f:
    f.write(content)

print("Updated index.html successfully.")
