import 'package:flutter/material.dart';
import '../../../../domain/models/research_report.dart';
import '../../../core/theme/stark_theme.dart';
import '../../../core/widgets/glass_card.dart';
import 'sections/financial_engine_section.dart';
import 'sections/forensic_screen_section.dart';
import 'sections/capex_concall_section.dart';
import 'sections/peer_benchmark_section.dart';
import 'sections/decision_scorecard_section.dart';

class PartBInstitutionalReportView extends StatelessWidget {
  final ResearchReport report;

  const PartBInstitutionalReportView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: StarkColors.cyan.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: StarkColors.cyan),
            ),
            child: const Text(
              'PART B: THE 8-AGENT INSTITUTIONAL RESEARCH REPORT',
              style: TextStyle(
                color: StarkColors.cyan,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // 1. Executive Summary
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.description, color: StarkColors.cyan, size: 16),
                    SizedBox(width: 8),
                    Text(
                      '1. EXECUTIVE SUMMARY [CHIEF STRATEGIST SIGN-OFF]',
                      style: TextStyle(color: StarkColors.cyan, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  report.executiveSummary,
                  style: const TextStyle(color: StarkColors.textPrimary, fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 2. Business Model & Competitive Moat [Agent 8]
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.castle, color: StarkColors.amber, size: 16),
                    SizedBox(width: 8),
                    Text(
                      '2. BUSINESS MODEL & COMPETITIVE MOAT [AGENT 8]',
                      style: TextStyle(color: StarkColors.amber, fontSize: 13, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  report.businessModelAndMoat,
                  style: const TextStyle(color: StarkColors.textPrimary, fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 3. Comprehensive Financial Engine [Agent 6]
          FinancialEngineSection(data: report.financialEngine),
          const SizedBox(height: 20),

          // 4. Forensic Accounting & Governance Screen [Agent 5]
          ForensicScreenSection(forensics: report.forensicScreen),
          const SizedBox(height: 20),

          // 5. Capex Horizon, Order Book & Concall Intelligence [Agent 7]
          CapexConcallSection(capex: report.capexConcall),
          const SizedBox(height: 20),

          // 6. Peer Benchmarking & Valuation Scenarios [Agent 8 & 4]
          PeerBenchmarkSection(benchmark: report.peerBenchmark),
          const SizedBox(height: 20),

          // 7 & 8. Decision Scorecard & F.R.I.D.A.Y. Quarterly Radar
          DecisionScorecardSection(
            scorecard: report.scorecard,
            radarTriggers: report.quarterlyRadarTriggers,
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
