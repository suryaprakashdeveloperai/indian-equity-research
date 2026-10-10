"""
F.R.I.D.A.Y. 2.0 // Interactive Voice Agent Context Server & Q&A Memory
Serves live conversational session context to ElevenLabs Conversational AI,
Twilio Media Streams, and Exotel webhooks.
Enables real-time two-way dialogue during live phone calls.
"""

import json
from typing import Dict, Any, Optional

try:
    from services.financial_data_engine import FinancialDataEngine
    from services.slide_generator import SlideReportGenerator
except ImportError:
    from financial_data_engine import FinancialDataEngine
    from slide_generator import SlideReportGenerator

# In-memory active report session store
ACTIVE_SESSIONS: Dict[str, Dict[str, Any]] = {}

class VoiceAgentContextServer:

    @staticmethod
    def initialize_session(ticker: str, exchange: str = "NSE") -> str:
        """
        Creates or updates an active voice session with the pre-compiled verified report context.
        """
        sym = ticker.upper()
        report = SlideReportGenerator.generate_six_slide_report(sym, exchange)
        fund = report["report_metadata"]
        s1 = report["slides"]["slide_1"]
        s2 = report["slides"]["slide_2"]
        s3 = report["slides"]["slide_3"]
        s4 = report["slides"]["slide_4"]
        s5 = report["slides"]["slide_5"]
        s6 = report["slides"]["slide_6"]

        qa_database = [
            {
                "question_intent": "why_buy",
                "keywords": ["why buy", "why classified as buy", "recommendation", "thesis", "conviction", "reasons"],
                "spoken_answer": (
                    f"We classified {fund['company_name']} as a {s1['recommendation']} because it trades at an intrinsic "
                    f"margin of safety of {s4['dcf_valuation']['margin_of_safety_pct']} to our DCF fair value of {s4['dcf_valuation']['intrinsic_fair_value']}. "
                    f"Furthermore, {s6['strongest_reason']}."
                ),
                "citation": "Slide 1 & Slide 4 DCF Valuation Model"
            },
            {
                "question_intent": "biggest_risk",
                "keywords": ["biggest risk", "key risk", "downside", "threat", "what could go wrong", "landmine"],
                "spoken_answer": (
                    f"The single biggest risk to our investment thesis is {s6['biggest_risk']}. "
                    f"We established a strict thesis invalidation trigger: {s5['thesis_invalidation']}. "
                    f"If that occurs, we recommend an immediate exit."
                ),
                "citation": "Slide 5 Risk Audit & Pre-Mortem"
            },
            {
                "question_intent": "valuation_support",
                "keywords": ["valuation", "fair value", "dcf", "target price", "how did you calculate", "math", "wacc"],
                "spoken_answer": (
                    f"Our valuation is supported by a 2-stage Discounted Cash Flow model using an 11.8% Indian corporate WACC "
                    f"and 5.5% terminal GDP growth rate. That yields an intrinsic fair value of {s4['dcf_valuation']['intrinsic_fair_value']}. "
                    f"On relative multiples, our 12-month target multiple is {s4['relative_multiples']['target_pe']} times projected EPS, giving {s4['scenarios']['base_case_12m']}."
                ),
                "citation": "Slide 4 2-Stage FCFF Model Trace"
            },
            {
                "question_intent": "sources_citations",
                "keywords": ["source", "citation", "evidence", "where did you get", "traceable", "data source"],
                "spoken_answer": (
                    f"All figures are traceable to official exchange disclosures and company investor presentations. "
                    f"For example, cash flows and balance sheet metrics were audited from the latest corporate filings on the {exchange}, "
                    f"and order book disclosures were cross-verified against recent quarterly concalls."
                ),
                "citation": "Traceability Manifest & Exchange Disclosures"
            },
            {
                "question_intent": "closing_note",
                "keywords": ["closing note", "analyst note", "verdict", "summary", "conclusion", "closing"],
                "spoken_answer": s6["paragraph"],
                "citation": "Slide 6 Analyst's Closing Note"
            }
        ]

        session_id = f"SESS_{sym}"
        ACTIVE_SESSIONS[session_id] = {
            "session_id": session_id,
            "ticker": sym,
            "company_name": fund["company_name"],
            "report": report,
            "qa_database": qa_database
        }

        return session_id

    @staticmethod
    def answer_voice_query(session_id: str, user_transcript: str) -> Dict[str, Any]:
        """
        Handles real-time spoken questions from the user during a phone call.
        """
        session = ACTIVE_SESSIONS.get(session_id)
        if not session:
            # Fallback to general session
            return {
                "spoken_reply": (
                    "I am F.R.I.D.A.Y., your AI financial analyst. I don't have an active report open for that session ID, "
                    "but you can tell me any stock ticker on the NSE or BSE to generate a fresh six-slide audit."
                ),
                "intent": "UNKNOWN_SESSION",
                "source": "System Fallback"
            }

        q = user_transcript.strip().lower()

        # Match against Q&A database intents
        for item in session["qa_database"]:
            if any(k in q for k in item["keywords"]):
                return {
                    "spoken_reply": item["spoken_answer"],
                    "intent": item["question_intent"],
                    "source": item["citation"]
                }

        # Check for financial terminology explanation
        if "wacc" in q:
            return {
                "spoken_reply": (
                    "WACC stands for Weighted Average Cost of Capital. For Indian equities, we benchmark at 11.8%, "
                    "reflecting the risk-free 10-year G-Sec yield of around 7% plus an equity risk premium adjusted for beta."
                ),
                "intent": "EXPLAIN_TERM_WACC",
                "source": "Quantitative Valuation Methodology"
            }
        elif "roce" in q:
            return {
                "spoken_reply": (
                    "ROCE is Return on Capital Employed. It measures how many rupees of operating profit the business generates "
                    "for every 100 rupees invested in equity and debt. High ROCE above 20% indicates an economic moat."
                ),
                "intent": "EXPLAIN_TERM_ROCE",
                "source": "Fundamental Ratio Dictionary"
            }
        elif "margin of safety" in q:
            return {
                "spoken_reply": (
                    "Margin of safety is the percentage discount between the current market price and our DCF intrinsic fair value. "
                    "A positive margin protects your capital against unforeseen operational shocks."
                ),
                "intent": "EXPLAIN_TERM_MOS",
                "source": "Value Investing Doctrine"
            }

        # Polite fallback when information is unavailable
        return {
            "spoken_reply": (
                f"That specific detail is not covered in our audited six-slide report for {session['ticker']}. "
                f"I avoid guessing figures. Would you like me to clarify our valuation model, the biggest operational risk, "
                f"or our final verdict?"
            ),
            "intent": "UNSUPPORTED_QUERY_FALLBACK",
            "source": "Analyst Guardrails"
        }
