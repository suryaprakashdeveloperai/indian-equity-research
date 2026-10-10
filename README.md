# F.R.I.D.A.Y. 2.0 // AI Stock Analyst with n8n & Human-Like Voice Calls

Autonomous Indian Equity Research Desk (NSE & BSE) integrating traceable financial models, a 6-Slide presentation deck generator with automated Slide 6 compliance validation, bi-directional n8n automation workflows, and low-latency outbound conversational voice calls to `+91 6382480091`.

---

## 🌟 Key Highlights

1. **Traceable Financial Data & Citations**:
   - Zero hallucination guarantee: financial figures are mapped to timestamped regulatory filings (BSE Corporate Announcements, MCA filings, and investor concalls).
2. **Deterministic Financial Modeling**:
   - **2-Stage Discounted Cash Flow (DCF)** with an **11.8% Indian WACC** baseline (10-Yr G-Sec 7.1% + 5.5% ERP) and 5.5% terminal growth rate.
   - 3-Year EPS Compounding model incorporating capex guidance and capacity utilization.
   - Quantitative Alpha outperformance scoring calibrated via Sigmoid probability distribution.
3. **Institutional 6-Slide Presentation Deck**:
   - Preserves Slides 1–5 (Executive Summary, Core Financials, Forensic Screen, Valuation Breakdown, Peer Benchmarking).
   - Generates and enforces **Slide 6: Conclusion Report — Analyst's Closing Note**.
4. **Slide 6 Automated Validator & Self-Repair**:
   - Strictly 1 single paragraph.
   - Strictly between 120 and 160 words.
   - Contains single strongest reason, biggest risk, long-term vs. tactical suitability justification, and thesis review trigger.
   - Ends with exact pattern: `Final Verdict: [STRONG BUY / BUY / HOLD / SELL / STRONG SELL] | Conviction: [High / Medium / Low] | Time Horizon: [3–6 months / 6–12 months / 3+ years].`
   - Built-in `auto_repair_slide_6` synthesizer for automated deterministic correction.
5. **Low-Latency Outbound Telephony & Two-Way Voice AI**:
   - Native outbound calls to `+91 6382480091` triggered at milestones (`report_started`, `report_completed`, `critical_failure`).
   - Supports **Exotel** (India PSTN), **Twilio** (Global), and **ElevenLabs** (Conversational AI).
   - Two-way voice dialogue: answers spoken questions about valuation, risks, WACC, citations, and admits unknowns gracefully within <45 seconds per response.
6. **n8n Automation Workflows**:
   - **Workflow A**: `n8n/workflow_a_stock_research_report.json` — Scheduled or webhook-driven research, calculation, 6-slide deck creation, and Slide 6 validation.
   - **Workflow B**: `n8n/workflow_b_voice_call_conversation.json` — Telephony dispatch, safety gating, and two-way voice callback routing.
7. **Fail-Safe Safety Default**:
   - `CALLS_ENABLED=false` by default to prevent unwanted cellular charges.
   - Provides dry-run execution payloads with full spoken scripts and simulated call logs.

---

## 📂 Project Repository Structure

```text
├── .env.example                               # Safe environment variables template
├── backend/                                   # FastAPI production backend
│   ├── main.py                                # API endpoints for research, news, and voice webhooks
│   ├── ml_engine.py                           # Quantitative ML scoring engine
│   ├── requirements.txt                       # Backend dependencies
│   └── Dockerfile                             # Render / Cloud deployment container
├── docs/                                      # System documentation
│   ├── ARCHITECTURE.md                        # Complete architecture blueprint & diagrams
│   └── TELEPHONY_SETUP.md                     # Exotel, Twilio & ElevenLabs setup guide
├── n8n/                                       # Importable n8n Workflows (v1.x)
│   ├── workflow_a_stock_research_report.json  # Workflow A: Research & Report generation
│   └── workflow_b_voice_call_conversation.json# Workflow B: Voice Calls & Webhooks
├── prompts/                                   # AI System & Audit Prompts
│   ├── stock_research_prompt.md               # Master Stock Research prompt
│   ├── independent_verification_prompt.md     # Independent Audit & Verification prompt
│   └── conversational_voice_agent_prompt.md   # Conversational Voice Agent persona prompt
├── schemas/                                   # JSON Schemas
│   ├── research_request_schema.json           # Input request validation schema
│   ├── report_output_schema.json              # 6-Slide Presentation output schema
│   └── voice_session_schema.json              # Conversational voice session schema
├── services/                                  # Modular Python Core Services
│   ├── financial_data_engine.py               # Traceable filings & 2-stage DCF engine
│   ├── slide_generator.py                     # 6-Slide Deck builder & markdown/pptx exporter
│   ├── slide_validator.py                     # Slide 6 validator & auto-repair synthesizer
│   ├── telephony_manager.py                   # Multi-carrier outbound phone dispatcher
│   └── voice_agent_server.py                  # In-memory session store & conversational Q&A
├── tests/                                     # Comprehensive Automated Test Suites
│   ├── run_all_tests.py                       # Master test suite runner
│   ├── test_financial_engine.py               # Calculations & citations tests
│   ├── test_slide_validator.py                # Slide 6 rules & repair tests
│   └── test_telephony_policy.py               # Telephony safety & dispatch tests
├── verify_stock_analyst.ps1                   # Windows PowerShell automated test suite
├── index.html                                 # Web HUD & Interactive Voice interface
└── README.md                                  # Master documentation
```

---

## 🛠️ Quick Start & Local Execution

### 1. Prerequisites
- Python 3.10+ (or Docker)
- n8n (self-hosted or n8n Cloud)
- Optional: Exotel or Twilio account for live phone calls

### 2. Environment Setup
Copy the environment template and configure your parameters:
```bash
cp .env.example .env
```

Ensure `CALLS_ENABLED=false` initially to test in dry-run mode without placing real calls.

### 3. Run Backend Locally
```bash
pip install -r backend/requirements.txt
uvicorn backend.main:app --host 0.0.0.0 --port 8000 --reload
```
The API documentation is accessible at `http://localhost:8000/docs`.

### 4. Run Automated Test Suites

#### Using Python Test Suite:
```bash
python tests/run_all_tests.py
```

#### Using Windows PowerShell Test Suite:
```powershell
.\verify_stock_analyst.ps1
```

Both test suites verify:
- Slide 6 strict word count (120–160 words) and exact verdict regex.
- DCF valuation calculations at 11.8% WACC.
- Full 6-slide deck generation and JSON schema compliance.
- Interactive two-way voice Q&A responses.
- Telephony safety lock enforcement (`CALLS_ENABLED=false`).

---

## 🔄 n8n Workflow Import & Configuration

### Importing Workflow A (Research & Report Deck)
1. Open your n8n workspace.
2. Click **Add workflow** -> **Import from File**.
3. Select `n8n/workflow_a_stock_research_report.json`.
4. Update the **HTTP Request** node base URL to point to your backend:
   `https://indian-equity-research.onrender.com`
5. Activate the workflow. Trigger it via POST to `/webhook/stock-research`:
   ```json
   {
     "ticker": "TATAMOTORS",
     "exchange": "NSE",
     "period": "1Y",
     "investor_profile": "LONG_TERM_COMPOUNDER"
   }
   ```

### Importing Workflow B (Voice Calls & Webhooks)
1. In n8n, click **Import from File**.
2. Select `n8n/workflow_b_voice_call_conversation.json`.
3. Configure your Exotel or Twilio credentials in the respective HTTP Request nodes.
4. Verify the destination recipient phone: `+916382480091`.
5. Activate the workflow. It will automatically process milestone triggers emitted by Workflow A.

---

## 📞 Outbound Phone Calls & Two-Way Voice Agent

Detailed setup instructions for Exotel, Twilio, and ElevenLabs are provided in [docs/TELEPHONY_SETUP.md](docs/TELEPHONY_SETUP.md).

### Testing a Milestone Call via API
```bash
curl -X POST "https://indian-equity-research.onrender.com/webhook/voice-milestone-call" \
  -H "Content-Type: application/json" \
  -d '{
    "milestone": "report_completed",
    "ticker": "TATAMOTORS",
    "company_name": "Tata Motors Limited",
    "recipient_phone": "+916382480091",
    "report_summary": {
      "verdict": "BUY",
      "conviction": "High",
      "time_horizon": "3+ years",
      "strongest_reason": "JLR net auto debt reduction and ₹25,000 Cr annualized FCF"
    }
  }'
```

### Spoken Questions Answered Naturally Over the Phone
During the call, the user can speak freely with F.R.I.D.A.Y.:
- *"Why did you classify this stock as a BUY?"* -> Answers with margin of safety and DCF fair value.
- *"What is the biggest risk?"* -> Outlines macro demand and raw material volatility.
- *"What supports your valuation?"* -> Explains 2-stage DCF, 11.8% WACC, and cash conversion cycle.
- *"Which source supports this conclusion?"* -> Recites the exact timestamped filing source.
- *"Can you explain what WACC means?"* -> Delivers a spoken-friendly definition of Weighted Average Cost of Capital.
- *Unverified trivia* -> Gracefully admits that the specific metric is not covered in verified filings.

---

## 📊 API Reference

| Endpoint | Method | Description |
| :--- | :--- | :--- |
| `/api/reports/generate` | POST | Generates complete 6-slide deck with Slide 6 validation and export |
| `/api/reports/sample/{ticker}` | GET | Returns pre-computed validated 6-slide report for key Indian tickers |
| `/webhook/voice-milestone-call` | POST | Milestone webhook triggering outbound voice call with safety gating |
| `/api/voice/session/query` | POST | Conversational endpoint for live phone call speech Q&A |
| `/api/stock/{ticker}` | GET | Real-time quote, fundamentals, and quantitative ML score |
| `/api/news` | GET | Real-time multi-source Indian financial news feeds |

---

## 🔒 Security & Privacy Commitments

- **No Secrets in Repo**: All API keys, tokens, and credentials are kept in environment variables.
- **Safety Gate by Default**: Outbound cellular calls are disabled (`CALLS_ENABLED=false`) until explicitly activated by the administrator.
- **Private Direct Whitelisting**: Telephony calls are constrained to the user's verified private number (`+91 6382480091`).
