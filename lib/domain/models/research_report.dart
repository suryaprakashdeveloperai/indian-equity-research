import 'company_profile.dart';
import 'financial_engine_data.dart';
import 'forensic_screen.dart';
import 'capex_concall_data.dart';
import 'peer_benchmark.dart';
import 'decision_scorecard.dart';
import 'verbal_briefing.dart';

class QuarterlyRadarTrigger {
  final int index;
  final String triggerTitle;
  final String measurableTarget;
  final String rationale;

  const QuarterlyRadarTrigger({
    required this.index,
    required this.triggerTitle,
    required this.measurableTarget,
    required this.rationale,
  });
}

class ResearchReport {
  final CompanyProfile company;
  final VerbalBriefing briefing;
  final String executiveSummary;
  final String businessModelAndMoat;
  final FinancialEngineData financialEngine;
  final ForensicScreen forensicScreen;
  final CapexConcallData capexConcall;
  final PeerBenchmarkData peerBenchmark;
  final DecisionScorecard scorecard;
  final List<QuarterlyRadarTrigger> quarterlyRadarTriggers;
  final DateTime generatedTimestamp;

  const ResearchReport({
    required this.company,
    required this.briefing,
    required this.executiveSummary,
    required this.businessModelAndMoat,
    required this.financialEngine,
    required this.forensicScreen,
    required this.capexConcall,
    required this.peerBenchmark,
    required this.scorecard,
    required this.quarterlyRadarTriggers,
    required this.generatedTimestamp,
  });
}
