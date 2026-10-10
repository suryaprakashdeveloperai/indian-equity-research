"""
Unit Tests for Telephony Safety Policy & Milestone Gating
"""

import sys
import os

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from services.telephony_manager import TelephonyManager

def test_safety_flag_default_disabled():
    # By default, CALLS_ENABLED is false
    os.environ["CALLS_ENABLED"] = "false"
    assert TelephonyManager.is_calls_enabled() is False
    
    should_call, reason = TelephonyManager.should_trigger_call("report_completed")
    assert should_call is False
    assert "CALLS_BLOCKED" in reason
    print(f"Safety Check PASS: Outbound calls blocked by default ({reason})")

def test_milestone_filtering():
    os.environ["CALLS_ENABLED"] = "true"
    assert TelephonyManager.is_calls_enabled() is True
    
    # Milestone not in user enabled list
    should_call, reason = TelephonyManager.should_trigger_call(
        milestone="unimportant_ping",
        user_enabled_milestones=["report_completed", "critical_failure"]
    )
    assert should_call is False
    assert "CALL_SUPPRESSED" in reason
    print(f"Milestone Filter PASS: Unimportant ping correctly suppressed")

    # Milestone in enabled list
    should_call, reason = TelephonyManager.should_trigger_call(
        milestone="report_completed",
        user_enabled_milestones=["report_completed", "critical_failure"]
    )
    assert should_call is True
    print(f"Milestone Authorization PASS: report_completed authorized")

def test_dry_run_dispatch():
    os.environ["CALLS_ENABLED"] = "false"
    res = TelephonyManager.dispatch_milestone_call(
        milestone="report_completed",
        ticker="TATAMOTORS",
        company_name="Tata Motors",
        phone_number="+916382480091"
    )
    assert res["status"] == "DRY_RUN_LOGGED"
    assert "spoken_script" in res
    assert len(res["spoken_script"]) > 20
    print(f"Dry Run Dispatch PASS: Generated spoken script '{res['spoken_script'][:50]}...'")

if __name__ == "__main__":
    print("--- Running Telephony Policy Tests ---")
    test_safety_flag_default_disabled()
    test_milestone_filtering()
    test_dry_run_dispatch()
    print("✅ All Telephony Policy Tests Passed Successfully!")
