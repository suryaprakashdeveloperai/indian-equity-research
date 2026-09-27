# F.R.I.D.A.Y. // Indian Equity Research Multi-Agent Engine

Autonomous 8-Agent Equity Research & Market Intelligence Desk covering Indian listed companies (NSE/BSE).

---

## 🏛️ The 8 AI Worker Architecture

1. **Agent 1 [Manager]: Chief Investment Strategist (CIS)** — Resolves analytical conflicts between fundamentals and technicals; signs off on conviction scores and capital allocation sizing.
2. **Agent 2 [Executive Assistant]: F.R.I.D.A.Y. Briefing Interface** — Personal voice liaison to the Principal; translates filings into spoken briefings and tactical execution HUDs.
3. **Agent 3 [Team Lead]: Fundamental & Forensic Lead** — Directs historical balance sheet audits, forensic checks, and cash-flow integrity.
4. **Agent 4 [Team Lead]: Market Structure, Macro & Quant Lead** — Directs valuation modeling, peer benchmarking, and institutional liquidity flows.
5. **Agent 5 [Worker]: Forensic Accounting & Governance Auditor** — Scrutinizes annual reports, MCA/NCLT filings, auditor qualifications, RPTs, and promoter pledges.
6. **Agent 6 [Worker]: Financial Statement & Cash Flow Modeler** — Extracts 5-year financials + TTM numbers: Revenue, EBITDA margin, PAT, CCC, and Free Cash Flow (FCF = OCF - Capex).
7. **Agent 7 [Worker]: Capex, Order Book & Concall Scraper** — Ingests concall transcripts, guidance vs. actual delivery, and order book run-rate.
8. **Agent 8 [Worker]: Industry, Peer & Valuation Analyst** — Analyzes operational moats, PLI tailwinds, 3-peer comparisons, and Bull/Base/Bear scenarios.

---

## 🚀 Features

- **Two-Way Voice Assistant:** Speak to F.R.I.D.A.Y. via microphone (🎤) and listen to synthesized verbal briefings aloud (🔊).
- **Core Institutional Universe:** Pre-calibrated models for *Reliance, HDFC Bank, Tata Motors, Dixon Tech, HAL, L&T, Trent, TCS, Zomato, and CDSL*.
- **Universal Any-Stock Scanner:** Enter or speak *any* NSE/BSE ticker to generate an immediate institutional report.
- **Dalal Street Forensic Screen:** 0% promoter pledge enforcement, cash conversion cycle checks, and RPT audits.
- **Interactive Margin Stress Simulator:** Real-time operating margin sensitivity testing (-50 to -500 bps).

---

## 📂 Project Structure

```text
├── index.html        # Zero-dependency, ultra-fast 60 FPS interactive Web App HUD
├── backend/          # FastAPI production backend for cloud deployment
│   ├── main.py       # REST API endpoints for multi-agent synthesis & simulation
│   ├── requirements.txt
│   └── Dockerfile    # Docker container for Render / Railway / AWS deployment
├── lib/              # Production Flutter / Dart codebase (flutter-apply-architecture-best-practices)
│   ├── core/         # Stark-HUD theme, currency formatter, Result wrapper, DI
│   ├── data/         # Repositories & Services (NSE/BSE, filings, multi-agent engine)
│   ├── domain/       # Clean immutable models & use cases (Rule 1 & 2 zero-hallucination math)
│   └── ui/           # MVVM with ListenableBuilder (Part A, Part B sections 1-8, Part C Advisor)
└── test/             # Automated unit and integration tests
```

---

## 🌐 Cloud Deployment

### 1. Backend (FastAPI on Render.com)
- **Build Command:** `pip install -r backend/requirements.txt`
- **Start Command:** `uvicorn backend.main:app --host 0.0.0.0 --port $PORT`

### 2. Frontend (Vercel / GitHub Pages / Netlify)
- Link this repository to **Vercel** or enable **GitHub Pages** (Source: `/` root).
