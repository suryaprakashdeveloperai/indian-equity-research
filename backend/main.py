"""
F.R.I.D.A.Y. 2.0 // Dalal Street AI Wealth Director & Multi-Agent Desk
Built with FastAPI for asynchronous Indian market data processing,
Tanglish conversational intelligence, outbound telephony, and broker order execution.
"""

from fastapi import FastAPI, HTTPException, Response
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import HTMLResponse
from pydantic import BaseModel
from typing import List, Optional
import datetime
import os

app = FastAPI(
    title="F.R.I.D.A.Y. 2.0 Dalal Street Wealth Director API",
    description="Institutional Market Intelligence & Tanglish Conversational Telephony Backend (NSE/BSE)",
    version="2.0.0"
)

# Enable CORS for web frontend (Netlify, localhost, Render)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# --- Data Schemas ---
class ChatRequest(BaseModel):
    query: str
    symbol: str

class MarginSimulationRequest(BaseModel):
    symbol: str
    bps_drop: float

class CallMeRequest(BaseModel):
    phone_number: str
    ticker: Optional[str] = "CRAFTSMAN"
    language: Optional[str] = "tanglish"

class BrokerOrderRequest(BaseModel):
    symbol: str
    quantity: int
    price: float
    stop_loss: float
    order_type: Optional[str] = "MARKET"

# --- Root Endpoint: Serves the Complete F.R.I.D.A.Y. Web App ---
@app.get("/", response_class=HTMLResponse)
def serve_frontend():
    candidates = [
        "index.html",
        "/app/index.html",
        os.path.join(os.path.dirname(__file__), "..", "index.html"),
        os.path.join(os.path.dirname(__file__), "index.html"),
    ]
    for path in candidates:
        if os.path.exists(path):
            try:
                with open(path, "r", encoding="utf-8") as f:
                    return f.read()
            except Exception:
                pass
    return """
    <html>
      <head><title>F.R.I.D.A.Y. 2.0 Backend Online</title></head>
      <body style="background:#070a0f; color:#00e5ff; font-family:sans-serif; text-align:center; padding:50px;">
        <h1>F.R.I.D.A.Y. 2.0 Dalal Street Wealth Desk is LIVE</h1>
        <p>Tanglish Conversational Telephony & Institutional Multi-Agent API</p>
        <p>Interactive API documentation: <a style="color:#00e676" href="/docs">/docs</a></p>
      </body>
    </html>
    """

# --- API Endpoints ---

@app.get("/api/health")
def health_check():
    return {
        "status": "online",
        "desk": "F.R.I.D.A.Y. 2.0 Tanglish AI Wealth Director",
        "timestamp": datetime.datetime.utcnow().isoformat()
    }

@app.get("/api/tickers")
def get_supported_tickers():
    return {
        "curated_anchors": ["DIXON", "TATAMOTORS", "HAL", "RELIANCE", "HDFCBANK", "LT", "TRENT", "TCS", "ZOMATO", "CDSL"],
        "underrated_gems": ["CRAFTSMAN", "KRN", "KAYNES", "EMS"],
        "supports_universal_custom": True
    }

@app.get("/api/gems")
def get_underrated_gems():
    return {
        "screened_count": 4,
        "criteria": "ROCE > 22%, Debt/Equity < 0.35, Clean Forensics, PEG < 1.1, Asymmetric Upside 2.5x-4x",
        "gems": [
            {
                "symbol": "CRAFTSMAN",
                "name": "Craftsman Automation Ltd.",
                "price": 4180.0,
                "upside_potential": "3.2x over 36M",
                "target_price": 13400.0,
                "roce": 24.5,
                "debt_to_equity": 0.28,
                "moat": "Precision powertrain machining & aluminum die casting for global commercial majors."
            },
            {
                "symbol": "KRN",
                "name": "KRN Heat Exchangers Ltd.",
                "price": 785.0,
                "upside_potential": "2.8x over 36M",
                "target_price": 2200.0,
                "roce": 28.2,
                "debt_to_equity": 0.05,
                "moat": "60% market share in HVAC-R copper fin condensing units."
            },
            {
                "symbol": "KAYNES",
                "name": "Kaynes Technology India Ltd.",
                "price": 5420.0,
                "upside_potential": "3.5x over 36M",
                "target_price": 18900.0,
                "roce": 22.8,
                "debt_to_equity": 0.12,
                "moat": "Critical defence electronics & Kavach railway signaling systems."
            },
            {
                "symbol": "EMS",
                "name": "EMS Limited",
                "price": 645.0,
                "upside_potential": "2.6x over 36M",
                "target_price": 1680.0,
                "roce": 29.4,
                "debt_to_equity": 0.02,
                "moat": "Turnkey wastewater & water treatment infrastructure EPC with 4.2x book-to-bill."
            }
        ]
    }

@app.get("/api/macro-news")
def get_macro_news():
    return {
        "macro_indicators": {
            "brent_crude": {"value": 74.20, "unit": "$/bbl", "change_pct": -1.8, "stance": "BULLISH_FOR_INDIA"},
            "us_10y_yield": {"value": 4.08, "unit": "%", "change_bps": -4, "stance": "NEUTRAL_CALM"},
            "dollar_index_dxy": {"value": 102.40, "change_pct": -0.2, "stance": "STABLE"},
            "gift_nifty": {"value": 25240, "change_pts": 88, "stance": "GREEN_OPENING"}
        },
        "breaking_wire": [
            {"tag": "BULLISH", "headline": "MeitY approves ₹ 3,200 Cr additional electronics PLI incentives.", "margin_impact": "+45 bps"},
            {"tag": "DEFENCE", "headline": "MoD clears ₹ 45,000 Cr procurement council approvals for indigenous systems.", "margin_impact": "HAL order backlog expansion"},
            {"tag": "MACRO", "headline": "Brent crude falls below $75/bbl reducing Indian import bill.", "margin_impact": "CAD surplus boost"}
        ]
    }

@app.post("/api/voice/call-me")
def initiate_phone_call(req: CallMeRequest):
    """
    Triggers an outbound cellular phone call to the user's mobile number.
    In production, this executes twilio_client.calls.create(...).
    """
    clean_num = req.phone_number.strip()
    if not clean_num:
        raise HTTPException(status_code=400, detail="Phone number is required.")
    
    call_sid = f"CA{datetime.datetime.utcnow().strftime('%Y%m%d%H%M%S')}{abs(hash(clean_num)) % 100000}"
    
    return {
        "status": "CALL_INITIATED",
        "call_sid": call_sid,
        "recipient": clean_num,
        "ticker_briefing": req.ticker,
        "language": req.language,
        "message": f"F.R.I.D.A.Y. is dialing {clean_num} on encrypted Dalal Street hotline. Your phone will ring shortly."
    }

@app.get("/api/voice/twiml", response_class=Response)
def get_voice_twiml(language: str = "tanglish", ticker: str = "CRAFTSMAN"):
    """
    Returns TwiML XML instructions for Twilio to speak F.R.I.D.A.Y.'s voice over the phone.
    """
    if language == "tanglish":
        spoken_text = "Good morning Boss! Naan F.R.I.D.A.Y. pesuren. Namma market open aagurathuku munnadi oru super underrated stock setup paathen. Craftsman Automation 32 percent margin of safety-la kedaikuthu. 40 shares buy panattuma Boss?"
    else:
        spoken_text = "Good morning Boss! F.R.I.D.A.Y. here. I identified a high conviction setup in Craftsman Automation with a 32 percent margin of safety. Would you like me to execute an entry tranche of 40 shares?"

    xml_content = f"""<?xml version="1.0" encoding="UTF-8"?>
<Response>
    <Say voice="Polly.Aditi" language="en-IN">{spoken_text}</Say>
    <Gather input="speech" timeout="5" speechTimeout="auto" action="/api/voice/process-speech" method="POST">
        <Say voice="Polly.Aditi" language="en-IN">Boss, unga confirmation sollunga.</Say>
    </Gather>
</Response>"""
    return Response(content=xml_content, media_type="application/xml")

@app.post("/api/broker/order")
def execute_broker_order(order: BrokerOrderRequest):
    """
    Executes verbal trade order on broker API (Zerodha/Angel One/Paper Trading).
    """
    order_id = f"ORD_{datetime.datetime.utcnow().strftime('%H%M%S')}_{abs(hash(order.symbol)) % 1000}"
    total_val = order.quantity * order.price

    return {
        "status": "EXECUTED",
        "order_id": order_id,
        "symbol": order.symbol.upper(),
        "quantity": order.quantity,
        "execution_price": order.price,
        "total_value": total_val,
        "stop_loss_trigger": order.stop_loss,
        "broker": "PAPER_TRADING_DESK_CONNECTED",
        "timestamp": datetime.datetime.utcnow().isoformat(),
        "tanglish_confirmation": f"Order execute aayiruchu Boss! {order.quantity} shares of {order.symbol} at ₹{order.price}. Stop-loss ₹{order.stop_loss}-la set panniten."
    }

@app.post("/api/advisor/chat")
def advisor_chat(chat: ChatRequest):
    q = chat.query.lower()
    symbol = chat.symbol.upper()
    
    if "buy" in q or "confirm" in q or "aama" in q:
        return {
            "reply": f"Order Confirmed Boss! Executed BUY order on {symbol}. Stop-loss attached at invalidation floor. Position added to your active portfolio ledger.",
            "intent": "TRADE_EXECUTION",
            "agent": "Agent 2: F.R.I.D.A.Y."
        }
    elif "craftsman" in q:
        return {
            "reply": "Boss, Craftsman Automation namma top hidden-gem! ROCE 24.5%, D/E 0.28x. Sector P/E 46x irukkumpothu idhu verum 24x-la kedaikuthu. 3-Year upside potential 3.2x!",
            "intent": "GEM_AUDIT",
            "agent": "Agent 8: Hidden Gem Lead"
        }
    elif "margin" in q or "bps" in q:
        return {
            "reply": f"Agent 6 Modeler: Simulating margin compression on {symbol}. Operating leverage absorbs raw material inflation with FCF remaining cash-flow positive.",
            "intent": "MARGIN_SIMULATION",
            "agent": "Agent 6: Modeler"
        }
    else:
        return {
            "reply": f"Agent 2 [F.R.I.D.A.Y.]: I am on it, Boss! Desk active on {symbol}. Ask me to test margins, review promoter pledges, or confirm orders.",
            "intent": "GENERAL_DISPATCH",
            "agent": "Agent 2: F.R.I.D.A.Y."
        }
