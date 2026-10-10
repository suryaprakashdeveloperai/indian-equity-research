"""
Unit Tests for Traceable Financial Data Engine & Calculations
"""

import sys
import os

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from services.financial_data_engine import FinancialDataEngine

def test_traceable_market_data():
    res = FinancialDataEngine.get_traceable_market_data("TATAMOTORS", "NSE")
    assert res["ticker"] == "TATAMOTORS"
    assert res["exchange"] == "NSE"
    assert "retrieval_timestamp" in res
    assert len(res["citations"]) >= 2
    
    # Check citations have mandatory fields
    for cit in res["citations"]:
        assert "claim" in cit
        assert "source_name" in cit
        assert "reporting_period" in cit
        assert "retrieval_timestamp" in cit
        
    print(f"Citations Verified: {len(res['citations'])} traceable sources")

def test_dcf_and_targets_math():
    f = {
        "current_price": 1000.0,
        "ttm_eps": 50.0,
        "pat_cagr_3y": 25.0,
        "roce": 25.0,
        "pe_ttm": 20.0,
        "median_pe_5y": 22.0,
        "debt_to_equity": 0.2,
        "ocf_pat_ratio": 1.4
    }
    calc = FinancialDataEngine.calculate_intrinsic_and_targets(f)
    
    # Verify mathematical sanity
    assert calc["target_price_12m"] > 0
    assert calc["intrinsic_fair_value"] > 0
    assert calc["stop_loss_price"] == round(1000.0 * 0.84)
    assert 0.0 <= calc["alpha_probability_pct"] <= 100.0
    assert len(calc["fcf_trace"]) == 5
    
    print(f"DCF Fair Value: ₹{calc['intrinsic_fair_value']:,}")
    print(f"12M Target: ₹{calc['target_price_12m']:,}")
    print(f"Margin of Safety: {calc['margin_of_safety_pct']}%")

if __name__ == "__main__":
    print("--- Running Financial Data Engine Tests ---")
    test_traceable_market_data()
    test_dcf_and_targets_math()
    print("✅ All Financial Data Engine Tests Passed Successfully!")
