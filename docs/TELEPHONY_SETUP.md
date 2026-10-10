# Telephony & Voice Agent Setup Guide

This guide walks you through connecting **Exotel**, **Twilio**, and **ElevenLabs Conversational AI** to the F.R.I.D.A.Y. 2.0 Equity Research Engine for outbound calls to `+91 6382480091`.

---

## 1. Safety Principles & Default Dry-Run Mode

> [!IMPORTANT]
> By default, `CALLS_ENABLED=false` in the application environment. In this mode, whenever a milestone is triggered, the engine logs the exact speech script, simulated call duration, and session data **without placing any actual phone call or incurring cellular charges**.

To activate live calls:
1. Complete provider onboarding below.
2. Verify recipient number ownership.
3. Update `.env` with provider API keys.
4. Set `CALLS_ENABLED=true`.

---

## 2. Telephony Provider Options

### Option A: Exotel (Recommended for Indian Numbers `+91`)
Exotel is an Indian cloud telephony provider with native PSTN routing and TRAI/DLT compliance.

#### Setup Steps:
1. **Register for an Exotel Account**: Sign up at [exotel.com](https://my.exotel.com/).
2. **Obtain an Exophone (Virtual Caller ID)**:
   - Rent a virtual number (e.g. `080XXXXXXXX` or `011XXXXXXXX`) from the Exotel dashboard.
   - Set this as `EXOTEL_CALLER_ID` in your `.env`.
3. **Generate API Credentials**:
   - Navigate to **API Settings** -> **API Keys**.
   - Copy **Account SID**, **API Key**, and **API Token**.
4. **Configure Outbound Webhook App**:
   - Create an App in Exotel App Bazaar.
   - Add a "Connect to URL" or "Gather" applet pointing to your server webhook:
     `https://indian-equity-research.onrender.com/webhook/voice-milestone-call`
5. **Update `.env`**:
   ```env
   TELEPHONY_PROVIDER=exotel
   EXOTEL_ACCOUNT_SID=your_account_sid
   EXOTEL_API_KEY=your_api_key
   EXOTEL_API_TOKEN=your_api_token
   EXOTEL_CALLER_ID=080XXXXXXXX
   EXOTEL_SUBDOMAIN=api.exotel.com
   CALLS_ENABLED=true
   ```

---

### Option B: Twilio (Global Fallback & WebRTC Voice)

Twilio offers international voice calling and programmable voice response using TwiML.

#### Setup Steps:
1. **Register for a Twilio Account**: Sign up at [twilio.com](https://www.twilio.com/).
2. **Verify Caller ID**:
   - In Trial mode, verify `+91 6382480091` under **Phone Numbers -> Verified Caller IDs**.
3. **Get Credentials**:
   - Copy **Account SID** and **Auth Token** from the Twilio Console.
   - Buy or assign a Twilio phone number (e.g. `+1205XXXXXXX`).
4. **Update `.env`**:
   ```env
   TELEPHONY_PROVIDER=twilio
   TWILIO_ACCOUNT_SID=ACXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   TWILIO_AUTH_TOKEN=your_twilio_auth_token_here
   TWILIO_PHONE_NUMBER=+1XXXXXXXXXX
   CALLS_ENABLED=true
   ```

---

### Option C: ElevenLabs Conversational Voice AI

To give F.R.I.D.A.Y. an ultra-realistic, low-latency conversational persona (e.g., teenage voice, natural inflections, no robotic pauses):

1. **Sign Up**: Register at [elevenlabs.io](https://elevenlabs.io/).
2. **Select Voice**:
   - Choose a conversational voice ID (e.g. `21m00Tcm4TlvDq8ikWAM` or create a custom cloned voice).
3. **Create Conversational Agent**:
   - Go to **Conversational AI** in the ElevenLabs console.
   - Set the System Prompt to the contents of `prompts/conversational_voice_agent_prompt.md`.
   - Add dynamic server tool callback:
     - Endpoint: `https://indian-equity-research.onrender.com/api/voice/session/query`
     - Parameters: `session_id` (string), `spoken_query` (string)
4. **Update `.env`**:
   ```env
   ELEVENLABS_API_KEY=your_elevenlabs_api_key_here
   ELEVENLABS_VOICE_ID=21m00Tcm4TlvDq8ikWAM
   ELEVENLABS_AGENT_ID=your_conversational_agent_id_here
   ```

---

## 3. Testing Outbound Milestone Calls

### Test 1: Dry-Run Test (Zero Cost)
Ensure `CALLS_ENABLED=false` in `.env`. Send a test request via curl or PowerShell:

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

**Expected Response**:
```json
{
  "status": "DRY_RUN_LOGGED",
  "dispatched_to": "+916382480091",
  "reason": "CALLS_ENABLED is false in environment. Voice dispatch was simulated.",
  "spoken_script": "Namaste! This is FRIDAY from your Dalal Street Research Desk. Your comprehensive 6-slide institutional research report on Tata Motors Limited is ready. Our final verdict is BUY with High conviction over a 3+ years horizon...",
  "estimated_call_duration_sec": 42
}
```

### Test 2: Live Call Dispatch
1. Change `CALLS_ENABLED=true` in `.env`.
2. Re-run the command above.
3. Your mobile phone at `+91 6382480091` will ring within 5–10 seconds.
4. Answer the call to hear F.R.I.D.A.Y. deliver the milestone briefing and enter interactive Q&A mode.

---

## 4. Testing Two-Way Conversational Dialogue

Once connected, ask questions naturally. The engine routes your speech to `services/voice_agent_server.py`:

| User Question | Engine Response Focus | Maximum Spoken Duration |
| :--- | :--- | :--- |
| *"Why did you classify this stock as a BUY?"* | Margin of safety, DCF target price, order book visibility | ~30 seconds |
| *"What is the biggest risk?"* | Macro demand slowdown, input cost volatility, regulatory changes | ~25 seconds |
| *"What supports your valuation?"* | 2-stage DCF, 11.8% Indian WACC, 5-year discrete cash flow forecast | ~35 seconds |
| *"Which source supports this conclusion?"* | BSE filing timestamp, Q3 investor concall transcript | ~20 seconds |
| *"Can you explain what WACC means?"* | Weighted Average Cost of Capital in simple terms | ~30 seconds |
| *"What is the CEO's favorite color?"* | Gracefully admits: "That data point is not covered in our filings." | ~10 seconds |

---

## 5. Cost Optimization & Rate Limiting

- **Exotel Rates**: Typically ₹0.40–₹0.80 per minute for outbound Indian PSTN calls.
- **Twilio Rates**: ~$0.014–$0.025 per minute depending on destination carrier.
- **ElevenLabs Conversational AI**: Tier-based character usage (~$0.05–$0.10 per call turn).
- **Default Safeguards**:
  - Maximum single call duration: **3 minutes**.
  - Rate limit: Maximum **3 automated milestone calls per ticker per 24-hour cycle**.
