import '../../domain/models/verbal_briefing.dart';
import '../../domain/models/decision_scorecard.dart';
import '../../domain/models/research_report.dart';
import '../../domain/models/agent_chat_message.dart';
import 'agent_prompts.dart';

abstract class AgentInferenceService {
  Future<VerbalBriefing> synthesizeVerbalBriefing({
    required String symbol,
    required String companyName,
    required String moat,
  });

  Future<DecisionScorecard> synthesizeDecisionScorecard({
    required String symbol,
    required double roce,
    required double patCagr,
    required bool hasRedFlags,
  });

  Future<List<QuarterlyRadarTrigger>> generateQuarterlyRadarTriggers(String symbol);

  Future<AgentChatMessage> processAdvisorQuery({
    required String query,
    required String activeSymbol,
  });
}

class MockAgentInferenceServiceImpl implements AgentInferenceService {
  @override
  Future<VerbalBriefing> synthesizeVerbalBriefing({
    required String symbol,
    required String companyName,
    required String moat,
  }) async {
    final s = symbol.toUpperCase().trim();
    if (s == 'DIXON') {
      return VerbalBriefing(
        companyName: companyName,
        setup:
            'Dixon is India\'s undisputed EMS powerhouse, controlling over 35% of outsourced mobile and TV manufacturing. Its operational moat is built on multi-tier vendor integrations, anchor MNC client stickiness, and aggressive domestic backward integration.',
        alphaCatalyst:
            'The massive ramp-up of the Mobile PLI tranche alongside exports for Motorola and Google Pixel, compounded by 40-60 bps margin expansion as in-house display and camera module JVs achieve commercial scale in FY26.',
        landmine:
            'Client concentration risk: Top 3 smartphone OEM clients account for over 50% of mobile production volumes; any OEM insourcing or client loss would hit high-volume operating leverage.',
        verdict: ConvictionVerdict.strongConvictionBuy,
        invalidationTrigger:
            'Monthly mobile production volume drops > 15% YoY or delay in component JV commissioning beyond Q1 FY27',
        invalidationPrice: 10400.0,
        audioSignOff:
            'The full 8-agent breakdown is compiled below, Boss. Where do you want to drill down first—the forensic red flags, the concall commitments, or the valuation multiples?',
      );
    } else {
      return VerbalBriefing(
        companyName: companyName,
        setup:
            'Tata Motors commands the crown jewel of Indian mobility: undisputed #1 in commercial heavy haulage (>40% share) and dominating Indian passenger EVs (>65% share), backed by JLR\'s resilient luxury order book.',
        alphaCatalyst:
            'The upcoming strategic demerger separating CV and PV/EV into two independent listed powerhouses, combined with JLR turning net-cash positive and generating over ₹ 25,000 Cr in annual Free Cash Flow.',
        landmine:
            'A protracted European or North American economic slowdown cooling luxury SUV demand, combined with heightened EV price-discounting pressures in the domestic market.',
        verdict: ConvictionVerdict.strongConvictionBuy,
        invalidationTrigger:
            'JLR quarterly EBIT margin dipping below 6.5% or net auto debt reversing upwards for two consecutive quarters',
        invalidationPrice: 820.0,
        audioSignOff:
            'The full 8-agent breakdown is compiled below, Boss. Where do you want to drill down first—the forensic red flags, the concall commitments, or the valuation multiples?',
      );
    }
  }

  @override
  Future<DecisionScorecard> synthesizeDecisionScorecard({
    required String symbol,
    required double roce,
    required double patCagr,
    required bool hasRedFlags,
  }) async {
    final s = symbol.toUpperCase().trim();
    if (s == 'DIXON') {
      return const DecisionScorecard(
        finalVerdictSignedByAgent1: 'STRONG BUY (High Conviction)',
        cisCapitalAllocationSize: '8.5% of Portfolio (High-Growth Thematic Allocation)',
        items: [
          ScorecardItem(
            category: 'Business Quality & Moat',
            weightPercent: 20.0,
            score: 4.8,
            primaryEvidence: 'Unrivaled domestic EMS scale; customer lock-in with global tech brands.',
            responsibleAgent: 'Agent 8 (Industry & Moat Lead)',
          ),
          ScorecardItem(
            category: 'Financial Strength & Balance Sheet',
            weightPercent: 20.0,
            score: 4.6,
            primaryEvidence: 'ROCE 44.5%, Cash Conversion Cycle of 6 days, virtually debt-free (Net Debt/EBITDA 0.05x).',
            responsibleAgent: 'Agent 6 (Financial Engine Modeler)',
          ),
          ScorecardItem(
            category: 'Growth Visibility & Orders',
            weightPercent: 20.0,
            score: 5.0,
            primaryEvidence: 'Order book ₹ 18,500 Cr; book-to-bill 1.45x; PLI incentive runway.',
            responsibleAgent: 'Agent 7 (Capex & Concall Scraper)',
          ),
          ScorecardItem(
            category: 'Management Quality & Forensics',
            weightPercent: 15.0,
            score: 4.9,
            primaryEvidence: 'Clean auditor report, 0% promoter pledge, high cash flow conversion.',
            responsibleAgent: 'Agent 5 (Forensic Accounting Auditor)',
          ),
          ScorecardItem(
            category: 'Valuation Asymmetry',
            weightPercent: 15.0,
            score: 3.8,
            primaryEvidence: 'P/E multiple is elevated (79x TTM), but justified by 44% EPS CAGR (PEG ~ 1.8x).',
            responsibleAgent: 'Agent 4 (Market Structure & Quant Lead)',
          ),
          ScorecardItem(
            category: 'Risk-Reward Profile',
            weightPercent: 10.0,
            score: 4.5,
            primaryEvidence: 'Bull case upside +34.9% vs Bear floor -21.3%; asymmetric upside catalyst in exports.',
            responsibleAgent: 'Agent 1 (Chief Investment Strategist)',
          ),
        ],
      );
    } else {
      return const DecisionScorecard(
        finalVerdictSignedByAgent1: 'STRONG BUY (Value & Transformation Play)',
        cisCapitalAllocationSize: '10.0% of Portfolio (Core Anchor Holding)',
        items: [
          ScorecardItem(
            category: 'Business Quality & Moat',
            weightPercent: 20.0,
            score: 4.7,
            primaryEvidence: 'Domestic duopoly in CVs, EV passenger leadership, global luxury brand resilience.',
            responsibleAgent: 'Agent 8 (Industry & Moat Lead)',
          ),
          ScorecardItem(
            category: 'Financial Strength & Balance Sheet',
            weightPercent: 20.0,
            score: 4.8,
            primaryEvidence: 'Deleveraging to near-zero net auto debt; FCF > ₹ 25,000 Cr; ROCE at 29.8%.',
            responsibleAgent: 'Agent 6 (Financial Engine Modeler)',
          ),
          ScorecardItem(
            category: 'Growth Visibility & Orders',
            weightPercent: 20.0,
            score: 4.5,
            primaryEvidence: 'JLR order book 148,000 units; new modular EV architectures launching FY26-27.',
            responsibleAgent: 'Agent 7 (Capex & Concall Scraper)',
          ),
          ScorecardItem(
            category: 'Management Quality & Forensics',
            weightPercent: 15.0,
            score: 5.0,
            primaryEvidence: 'Tata governance benchmark; 0% pledge; transparent disclosures and audit rigor.',
            responsibleAgent: 'Agent 5 (Forensic Accounting Auditor)',
          ),
          ScorecardItem(
            category: 'Valuation Asymmetry',
            weightPercent: 15.0,
            score: 4.9,
            primaryEvidence: 'Trading at only 8.7x P/E and 4.8x EV/EBITDA, representing extreme value dislocation.',
            responsibleAgent: 'Agent 4 (Market Structure & Quant Lead)',
          ),
          ScorecardItem(
            category: 'Risk-Reward Profile',
            weightPercent: 10.0,
            score: 4.8,
            primaryEvidence: 'Demerger unlocks 48% upside; downside protected by tangible asset backing and massive FCF.',
            responsibleAgent: 'Agent 1 (Chief Investment Strategist)',
          ),
        ],
      );
    }
  }

  @override
  Future<List<QuarterlyRadarTrigger>> generateQuarterlyRadarTriggers(String symbol) async {
    final s = symbol.toUpperCase().trim();
    if (s == 'DIXON') {
      return const [
        QuarterlyRadarTrigger(
          index: 1,
          triggerTitle: 'Mobile Export Shipments Run-Rate',
          measurableTarget: 'Achieve > 1.2M units/month export volume for Motorola & Google.',
          rationale: 'Validates export scale beyond domestic market saturation.',
        ),
        QuarterlyRadarTrigger(
          index: 2,
          triggerTitle: 'Component JV Commercial Billing',
          measurableTarget: 'Display and camera module lines generating ₹ 250+ Cr revenue in Q3.',
          rationale: 'Key milestone for structural gross margin expansion.',
        ),
        QuarterlyRadarTrigger(
          index: 3,
          triggerTitle: 'Working Capital Cycle Stability',
          measurableTarget: 'Maintain Cash Conversion Cycle below 8 days.',
          rationale: 'Protects hyper-growth from sucking up operating cash flow.',
        ),
        QuarterlyRadarTrigger(
          index: 4,
          triggerTitle: 'PLI Disbursement Realization',
          measurableTarget: 'Timely receipt of ₹ 180 Cr accrued PLI cash incentives from MeitY.',
          rationale: 'Verifies government subsidy cash flow conversion integrity.',
        ),
      ];
    } else {
      return const [
        QuarterlyRadarTrigger(
          index: 1,
          triggerTitle: 'JLR EBIT Margin Floor',
          measurableTarget: 'Deliver >= 9.0% EBIT margin at Jaguar Land Rover in Q2/Q3 prints.',
          rationale: 'Confirms pricing power on high-value Range Rover models.',
        ),
        QuarterlyRadarTrigger(
          index: 2,
          triggerTitle: 'Zero Net Auto Debt Milestones',
          measurableTarget: 'Net automotive debt reduction to < ₹ 5,000 Cr.',
          rationale: 'Final stage of 4-year strategic balance-sheet cleanup.',
        ),
        QuarterlyRadarTrigger(
          index: 3,
          triggerTitle: 'Demerger Regulatory Approvals',
          measurableTarget: 'NCLT & shareholder nod for formal CV and PV/EV listing split.',
          rationale: 'Triggers the planned sum-of-the-parts multiple rerating.',
        ),
        QuarterlyRadarTrigger(
          index: 4,
          triggerTitle: 'Domestic EV Market Share Retention',
          measurableTarget: 'Sustain > 60% electric PV market share despite new competitive launches.',
          rationale: 'Guards the domestic passenger vehicle operational moat.',
        ),
      ];
    }
  }

  @override
  Future<AgentChatMessage> processAdvisorQuery({
    required String query,
    required String activeSymbol,
  }) async {
    final q = query.toLowerCase();

    if (q.contains('agent 5') || q.contains('related-party') || q.contains('rpt') || q.contains('forensic')) {
      return AgentChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: AgentSender.forensicAuditor,
        message: '''
[AGENT 5: FORENSIC AUDIT DISPATCH - $activeSymbol]
Boss, I have executed a targeted stress-test on Related-Party Transactions (RPTs):
1. RPT Breakdown: All recorded RPTs are strictly confined to 100% operating subsidiaries (e.g. Padget Electronics) for electronic assemblies or parent engineering support.
2. Cross-Guarantee / Loans: ₹ 0.00 Loans or advances extended to promoter personal entities.
3. Auditor Confirmation: B S R & Co. LLP audited RPT disclosures under Section 188 of Companies Act 2013 with unanimous Audit Committee pre-approvals.
Verdict: Zero forensic leakage. All transactions pass the arm's-length benchmark.
''',
        timestamp: DateTime.now(),
      );
    } else if (q.contains('agent 7') || q.contains('concall') || q.contains('question') || q.contains('management')) {
      return AgentChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: AgentSender.concallScraper,
        message: '''
[AGENT 7: CONCALL INTELLIGENCE - 3 CRITICAL QUESTIONS FOR MANAGEMENT]
Boss, here are the 3 hard-hitting questions drafted for the upcoming earnings concall:
1. Component Localization: "Given your targeted FY26 display and camera module JVs, what is the exact percentage of domestic value-addition achieved today versus your 25% target, and how will this buffer gross margins against chip price inflation?"
2. Client Concentration: "With your top 2 anchor clients contributing significant mobile volume, what contractual volume guarantees or take-or-pay clauses are embedded to insulate your Noida plant utilization?"
3. Export Realization: "In the event of trade policy or tariff shifts in destination markets, what is your lead time to pivot export lines back into domestic SKU manufacturing?"
''',
        timestamp: DateTime.now(),
      );
    } else if (q.contains('margin') || q.contains('200 bps') || q.contains('simulate') || q.contains('agent 6')) {
      return AgentChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: AgentSender.financialModeler,
        message: '''
[AGENT 6: FINANCIAL ENGINE STRESS SIMULATION - 200 BPS MARGIN DROP]
Simulating a 200 bps (2.0%) compression in Operating Margin due to raw material and freight inflation:
- Baseline EBITDA Margin: 4.4% -> Stress-Tested EBITDA Margin: 2.4%
- Impact on Operating EBITDA: Drops by ~₹ 730 Cr on ₹ 36,500 Cr revenue base.
- Adjusted PAT: Falls from ₹ 940 Cr to ₹ 395 Cr (58% contraction due to operational gearing).
- Target Price Sensitivity: Under the stress case, fair value adjusts to ₹ 10,800 (-13.2% from current levels).
Chief's Invalidation Note: Even under this extreme stress scenario, the company maintains positive FCF of ₹ 420 Cr and avoids external debt financing.
''',
        timestamp: DateTime.now(),
      );
    } else {
      return AgentChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: AgentSender.friday,
        message: '''
I'm on it, Boss. The 8-agent desk is active on $activeSymbol.
You can ask me to:
- "Tell Agent 5 to stress-test related-party transactions"
- "Have Agent 7 draft 3 challenging concall questions"
- "Simulate an operating margin drop of 200 bps"
- Or request any specific valuation or forensic check.
''',
        timestamp: DateTime.now(),
      );
    }
  }
}
