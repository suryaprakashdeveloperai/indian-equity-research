"""
Unit Tests for Slide 6 Automated Validator & Self-Repair Engine
"""

import sys
import os

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from services.slide_validator import Slide6Validator

def test_valid_slide_6():
    valid_text = (
        "Tata Motors Limited (TATAMOTORS) presents an evidence-backed investment setup anchored in operational resilience. "
        "The single strongest reason to own the equity is JLR balance sheet turnaround to near-zero net auto debt alongside ₹25,000 Cr annualized FCF and upcoming strategic CV/PV demerger. "
        "Conversely, the single biggest risk to the thesis remains European luxury demand deceleration and domestic EV price competition impacting gross margins. "
        "Balance sheet scrutiny confirms audited operating cash flows sufficiently protect debt service obligations, providing a measurable margin of safety across volatile commodity cycles. "
        "Regarding capital suitability, this stock is strictly recommended for a long-term compounder with a 3+ year horizon, as it allows compounding operating leverage to materialize across multi-year capex expansions while buffering against cyclical noise. "
        "Review Trigger: Invalidation activates if JLR EBIT margin slips below 6.5% or consolidated Net Debt/EBITDA exceeds 1.5x. "
        "Final Verdict: STRONG BUY | Conviction: High | Time Horizon: 3+ years."
    )
    result = Slide6Validator.validate_slide_6(valid_text, {"ticker": "TATAMOTORS"})
    print(f"Valid Slide 6 Word Count: {result['word_count']} words")
    print(f"Validation Status: {'PASS' if result['is_valid'] else 'FAIL'}")
    if not result["is_valid"]:
        print(f"Errors: {result['errors']}")
    assert result["is_valid"] is True
    assert 120 <= result["word_count"] <= 160
    assert result["parsed_verdict"] == "STRONG BUY"
    assert result["parsed_conviction"] == "High"
    assert result["parsed_horizon"] == "3+ years"

def test_invalid_word_count_too_short():
    short_text = "Tata Motors is a great stock to buy. Final Verdict: BUY | Conviction: High | Time Horizon: 3+ years."
    result = Slide6Validator.validate_slide_6(short_text)
    assert result["is_valid"] is False
    assert any("too low" in err for err in result["errors"])

def test_auto_repair_cycle():
    repaired = Slide6Validator.auto_repair_slide_6(
        raw_paragraph="",
        ticker="DIXON",
        company_name="Dixon Technologies",
        strongest_reason="market dominance with 35% smartphone manufacturing share and PLI export tailwinds",
        biggest_risk="customer concentration among top 3 OEM clients",
        is_long_term=True,
        suitability_justification="it allows multi-year export volume ramp-up and backward component JV margins to compound",
        verdict="BUY",
        conviction="High",
        horizon="3+ years",
        review_trigger="monthly production volumes drop >15% YoY"
    )
    res = Slide6Validator.validate_slide_6(repaired, {"ticker": "DIXON"})
    print(f"Repaired Dixon Word Count: {res['word_count']} words")
    assert res["is_valid"] is True
    assert 120 <= res["word_count"] <= 160
    assert res["parsed_verdict"] == "BUY"

if __name__ == "__main__":
    print("--- Running Slide 6 Validator Tests ---")
    test_valid_slide_6()
    test_invalid_word_count_too_short()
    test_auto_repair_cycle()
    print("✅ All Slide 6 Validator Tests Passed Successfully!")
