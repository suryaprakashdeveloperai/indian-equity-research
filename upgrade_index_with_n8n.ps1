# Script to upgrade index.html with PART H (n8n Automation Studio) and PART I (6-Slide Institutional Deck)

$indexPath = "C:\Users\ELCOT\.gemini\antigravity-ide\scratch\indian_equity_multiagent_engine\index.html"
$html = [System.IO.File]::ReadAllText($indexPath, [System.Text.Encoding]::UTF8)

# 1. Add CSS for n8n Studio & Slide Deck before </style>
$n8nCss = @'
    /* PART H: N8N AUTOMATION STUDIO & PIPELINES */
    .n8n-studio-banner {
      background: linear-gradient(135deg, rgba(255, 109, 0, 0.15), rgba(124, 77, 255, 0.15));
      border: 1px solid rgba(255, 109, 0, 0.4);
      border-radius: 14px;
      padding: 20px 24px;
      margin-bottom: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 16px;
    }
    .n8n-pipeline-tabs {
      display: flex;
      gap: 12px;
      margin-bottom: 18px;
    }
    .n8n-pipe-btn {
      background: var(--surface-card);
      border: 1px solid var(--border);
      color: var(--text-secondary);
      padding: 10px 18px;
      border-radius: 10px;
      font-size: 13px;
      font-weight: 800;
      cursor: pointer;
      transition: all 0.2s;
      display: flex;
      align-items: center;
      gap: 8px;
    }
    .n8n-pipe-btn.active {
      background: rgba(255, 109, 0, 0.15);
      border-color: #ff6d00;
      color: #ff6d00;
      box-shadow: 0 0 15px rgba(255, 109, 0, 0.3);
    }
    .n8n-canvas {
      background: #070b12;
      border: 1px solid var(--border);
      border-radius: 16px;
      padding: 24px;
      position: relative;
      overflow-x: auto;
    }
    .n8n-flow-row {
      display: flex;
      align-items: center;
      gap: 16px;
      min-width: 980px;
      margin-bottom: 24px;
    }
    .n8n-node {
      background: var(--surface-card);
      border: 1px solid var(--border);
      border-radius: 12px;
      padding: 16px;
      width: 210px;
      flex-shrink: 0;
      transition: all 0.3s;
      position: relative;
    }
    .n8n-node.active-exec {
      border-color: #00e676;
      box-shadow: 0 0 25px rgba(0, 230, 118, 0.6);
      transform: translateY(-3px);
    }
    .n8n-node-header {
      display: flex;
      align-items: center;
      justify-content: space-between;
      margin-bottom: 8px;
    }
    .n8n-node-badge {
      font-size: 9px;
      font-weight: 800;
      padding: 2px 6px;
      border-radius: 6px;
      font-family: 'JetBrains Mono', monospace;
    }
    .n8n-node-title {
      font-size: 13px;
      font-weight: 800;
      color: #fff;
      margin-bottom: 4px;
    }
    .n8n-node-desc {
      font-size: 11px;
      color: var(--text-muted);
      line-height: 1.4;
    }
    .n8n-arrow {
      color: #ff6d00;
      font-size: 20px;
      font-weight: bold;
      flex-shrink: 0;
    }
    .n8n-terminal {
      background: #03060a;
      border: 1px solid var(--border);
      border-radius: 10px;
      padding: 16px;
      font-family: 'JetBrains Mono', monospace;
      font-size: 11px;
      color: #00e5ff;
      height: 180px;
      overflow-y: auto;
      line-height: 1.6;
    }

    /* PART I: 6-SLIDE PRESENTATION DECK */
    .deck-nav-bar {
      display: flex;
      gap: 8px;
      overflow-x: auto;
      padding-bottom: 12px;
      margin-bottom: 16px;
    }
    .slide-tab-btn {
      background: var(--surface-card);
      border: 1px solid var(--border);
      color: var(--text-secondary);
      padding: 8px 16px;
      border-radius: 8px;
      font-size: 12px;
      font-weight: 700;
      cursor: pointer;
      white-space: nowrap;
      transition: all 0.2s;
    }
    .slide-tab-btn.active {
      border-color: var(--emerald);
      color: var(--emerald);
      background: rgba(0, 230, 118, 0.12);
    }
    .slide-card-presentation {
      background: linear-gradient(135deg, #0a0f18, #0e1624);
      border: 2px solid var(--border);
      border-radius: 20px;
      padding: 32px;
      box-shadow: 0 10px 40px rgba(0, 0, 0, 0.6);
      min-height: 480px;
      position: relative;
    }
    .slide-header-row {
      display: flex;
      justify-content: space-between;
      align-items: flex-start;
      border-bottom: 1px solid var(--border);
      padding-bottom: 16px;
      margin-bottom: 24px;
    }
    .slide-number-tag {
      font-family: 'JetBrains Mono', monospace;
      font-size: 12px;
      font-weight: 800;
      color: var(--cyan);
      background: rgba(0, 229, 255, 0.1);
      padding: 4px 10px;
      border-radius: 6px;
      border: 1px solid rgba(0, 229, 255, 0.3);
    }
    .slide-body-content {
      font-size: 15px;
      line-height: 1.8;
      color: #e2e8f0;
    }
    .slide6-audit-box {
      background: rgba(0, 230, 118, 0.08);
      border: 1px solid var(--emerald);
      border-radius: 12px;
      padding: 16px 20px;
      margin-top: 24px;
      display: flex;
      justify-content: space-between;
      align-items: center;
      flex-wrap: wrap;
      gap: 12px;
    }
    .audit-stat {
      font-size: 12px;
      font-family: 'JetBrains Mono', monospace;
    }
'@

if ($html.IndexOf("/* PART H: N8N AUTOMATION STUDIO") -eq -1) {
    $html = $html.Replace("  </style>", "$n8nCss`n  </style>")
}

# 2. Add header quick-jump buttons before Universal Search
$headerSearchTarget = '<div class="search-box">'
$headerButtons = @'
      <!-- n8n Automation & 6-Slide Quick Jump -->
      <button class="voice-tester-btn" onclick="switchTab('tab-n8n')" style="background: rgba(255, 109, 0, 0.15); border-color: #ff6d00; color: #ff6d00; font-weight: 800;">
        ⚡ N8N WORKFLOWS
      </button>
      <button class="voice-tester-btn" onclick="switchTab('tab-deck')" style="background: rgba(0, 230, 118, 0.15); border-color: var(--emerald); color: var(--emerald); font-weight: 800;">
        📑 6-SLIDE DECK
      </button>

      <div class="search-box">
'@

if ($html.IndexOf("⚡ N8N WORKFLOWS") -eq -1) {
    $html = $html.Replace($headerSearchTarget, $headerButtons)
}

# 3. Add Tab items to .tab-bar
$tabBarTarget = '<div class="tab-item" id="tabNavMlLab" onclick="switchTab(''tab-ml-lab'')"'
$newTabs = @'
      <div class="tab-item" id="tabNavN8n" onclick="switchTab('tab-n8n')" style="color: #ff6d00; border-color: rgba(255, 109, 0, 0.5); font-weight: 800;">PART H: ⚡ N8N AUTOMATION STUDIO</div>
      <div class="tab-item" id="tabNavDeck" onclick="switchTab('tab-deck')" style="color: var(--emerald); border-color: rgba(0, 230, 118, 0.5); font-weight: 800;">PART I: 📑 6-SLIDE INSTITUTIONAL DECK</div>
    </div>
'@

# Replace closing of tab bar after tabNavMlLab
$tabBarEndTarget = 'PART G: ðŸ§  QUANT &amp; ML VALUATION LAB</div>'
if ($html.IndexOf("PART H: ⚡ N8N AUTOMATION STUDIO") -eq -1) {
    if ($html.IndexOf($tabBarEndTarget) -ne -1) {
        $html = $html.Replace($tabBarEndTarget, "$tabBarEndTarget`n      <div class=""tab-item"" id=""tabNavN8n"" onclick=""switchTab('tab-n8n')"" style=""color: #ff6d00; border-color: rgba(255, 109, 0, 0.5); font-weight: 800;"">PART H: ⚡ N8N AUTOMATION STUDIO</div>`n      <div class=""tab-item"" id=""tabNavDeck"" onclick=""switchTab('tab-deck')"" style=""color: var(--emerald); border-color: rgba(0, 230, 118, 0.5); font-weight: 800;"">PART I: 📑 6-SLIDE INSTITUTIONAL DECK</div>")
    }
}

[System.IO.File]::WriteAllText($indexPath, $html, [System.Text.Encoding]::UTF8)
Write-Host "Upgraded index.html successfully with styles, header buttons, and tabs!" -ForegroundColor Green
