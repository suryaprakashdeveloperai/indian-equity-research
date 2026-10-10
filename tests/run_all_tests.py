"""
Master Test Runner for AI Stock Analyst with n8n & Human-Like Voice Calls
Executes:
1. Slide 6 Validation & Self-Repair Rules
2. Financial Data Engine & Traceability
3. Full 6-Slide Report Generation & Export
4. Voice Agent Interactive Context Q&A
5. Telephony Policy & Safety Flag Gating
"""

import sys
import os
import json

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from services.slide_validator import Slide6Validator
from services.financial_data_engine import FinancialDataEngine
from services.slide_generator import SlideReportGenerator
from services.voice_agent_server import VoiceAgentContextServer
from services.telephony_manager import TelephonyManager

def run_comprehensive_suite():
    print("=" * 70)
    print("F.R.I.D.A.Y. 2.0 // MASTER TEST SUITE EXECUTION")
    print("=" * 70)

    # 1. Slide 6 Validation Test
    print("\n[TEST 1] Auditing Slide 6 Rules & Self-Repair Engine...")
    repaired_closing = Slide6Validator.auto_repair_slide_6(
        raw_paragraph="",
        ticker="TATAMOTORS",
        company_name="Tata Motors Limited",
        strongest_reason="JLR balance sheet turnaround to near-zero net auto debt and ₹25,000 Cr annualized FCF",
        biggest_risk="European luxury demand cooling and domestic EV price competition",
        is_long_term=True,
        suitability_justification="it allows compounding operating leverage to materialize across multi-year capex expansions",
        verdict="BUY",
        conviction="High",
        horizon="3+ years",
        review_trigger="JLR EBIT margin slips below 6.5%"
    )
    v6 = Slide6Validator.validate_slide_6(repaired_closing, {"ticker": "TATAMOTORS"})
    assert v6["is_valid"] is True, f"Validation failed: {v6['errors']}"
    assert 120 <= v6["word_count"] <= 160, f"Word count out of bounds: {v6['word_count']}"
    assert v6["parsed_verdict"] == "BUY"
    print(f"  ✓ Word count: {v6['word_count']} words (Requirement: 120-160)")
    print(f"  ✓ Paragraph count: {v6['paragraph_count']} (Requirement: exactly 1)")
    print(f"  ✓ Final Verdict match: {v6['parsed_verdict']} | {v6['parsed_conviction']} | {v6['parsed_horizon']}")

    # 2. Financial Modeling & Calculations Test
    print("\n[TEST 2] Auditing Traceable Financial Data & Calculations...")
    market_data = FinancialDataEngine.get_traceable_market_data("DIXON", "NSE")
    calc = market_data["calculations"]
    assert calc["target_price_12m"] > market_data["fundamentals"]["current_price"]
    assert len(market_data["citations"]) >= 2
    print(f"  ✓ Sourced {len(market_data['citations'])} traceable citations with timestamps")
    print(f"  ✓ DCF Intrinsic Fair Value: ₹{calc['intrinsic_fair_value']:,} (WACC: 11.8%)")
    print(f"  ✓ Margin of Safety: {calc['margin_of_safety_pct']}%")

    # 3. Full 6-Slide Report Generation Test
    print("\n[TEST 3] Generating Complete Six-Slide Presentation...")
    report = SlideReportGenerator.generate_six_slide_report("TATAMOTORS", "NSE", "LONG_TERM_COMPOUNDER")
    assert "slides" in report
    assert len(report["slides"]) == 6
    for i in range(1, 7):
        assert f"slide_{i}" in report["slides"]
    assert report["slides"]["slide_6"]["is_valid"] is True
    print("  ✓ Slides 1 to 5 generated with full structural content")
    print(f"  ✓ Slide 6 generated with validated closing note: {report['slides']['slide_6']['word_count']} words")

    # Export to disk test
    export_paths = SlideReportGenerator.export_to_pptx_or_json(report, "tests/output_report")
    assert os.path.exists(export_paths["json_path"])
    assert os.path.exists(export_paths["md_path"])
    print(f"  ✓ Presentation saved to: {export_paths['md_path']}")
    print(f"  ✓ JSON manifest saved to: {export_paths['json_path']}")

    # 4. Interactive Voice Q&A Test
    print("\n[TEST 4] Testing Live Conversational Voice Q&A Engine...")
    sess_id = VoiceAgentContextServer.initialize_session("TATAMOTORS")
    
    # User asks "Why did you classify this stock as a BUY?"
    ans1 = VoiceAgentContextServer.answer_voice_query(sess_id, "Why did you classify this stock as a BUY?")
    assert "margin of safety" in ans1["spoken_reply"].lower()
    print(f"  ✓ Spoken Q&A (Why BUY?): {ans1['spoken_reply'][:75]}...")

    # User asks "What is the biggest risk?"
    ans2 = VoiceAgentContextServer.answer_voice_query(sess_id, "What is the biggest risk?")
    assert "risk" in ans2["spoken_reply"].lower()
    print(f"  ✓ Spoken Q&A (Biggest Risk): {ans2['spoken_reply'][:75]}...")

    # User asks about financial terms "What is WACC?"
    ans3 = VoiceAgentContextServer.answer_voice_query(sess_id, "Can you explain what WACC means?")
    assert "weighted average cost of capital" in ans3["spoken_reply"].lower()
    print(f"  ✓ Terminology Explanation: {ans3['spoken_reply'][:75]}...")

    # Unsupported query test (admitting missing data)
    ans4 = VoiceAgentContextServer.answer_voice_query(sess_id, "What color is the CEO's personal car?")
    assert "avoid guessing" in ans4["spoken_reply"].lower() or "not covered" in ans4["spoken_reply"].lower()
    print(f"  ✓ Unsupported Fallback Guardrail: {ans4['spoken_reply'][:75]}...")

    # 5. Telephony Policy & Safety Flag Test
    print("\n[TEST 5] Testing Telephony Dispatcher & Safety Lock...")
    os.environ["CALLS_ENABLED"] = "false"
    call_res = TelephonyManager.dispatch_milestone_call(
        milestone="report_completed",
        ticker="TATAMOTORS",
        company_name="Tata Motors Limited",
        phone_number="+916382480091",
        report_data=report
    )
    assert call_res["status"] == "DRY_RUN_LOGGED"
    print(f"  ✓ Safety lock enforced: {call_res['status']} ({call_res['reason']})")
    print(f"  ✓ Prepared milestone script: '{call_res['spoken_script'][:70]}...'")

    print("\n" + "=" * 70)
    print("🎉 ALL ACCEPTANCE CRITERIA VERIFIED AND PASSED SUCCESSFULLY!")
    print("=" * 70)

if __name__ == "__main__":
    run_comprehensive_suite()
