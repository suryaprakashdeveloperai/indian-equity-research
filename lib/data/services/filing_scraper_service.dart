import '../../domain/models/financial_engine_data.dart';
import '../../domain/models/forensic_screen.dart';
import '../../domain/models/capex_concall_data.dart';
import '../../domain/models/peer_benchmark.dart';

abstract class FilingScraperService {
  Future<FinancialEngineData> extractFinancialEngine(String symbol);
  Future<ForensicScreen> extractForensicScreen(String symbol);
  Future<CapexConcallData> extractCapexAndConcall(String symbol);
  Future<PeerBenchmarkData> extractPeerBenchmarks(String symbol);
}

class MockFilingScraperServiceImpl implements FilingScraperService {
  @override
  Future<FinancialEngineData> extractFinancialEngine(String symbol) async {
    final s = symbol.toUpperCase().trim();
    if (s == 'DIXON') {
      return FinancialEngineData(
        salesCagr3Yr: 41.2,
        patCagr3Yr: 44.8,
        synthesisSummary:
            'Hyper-growth driven by mobile PLI volumes. Asset turnover exceptionally high (5.2x). Working capital cycle maintained at a lean 6 days due to vendor-financed inventory.',
        periods: [
          FinancialPeriodMetric.computed(
            period: 'FY22',
            revenueCr: 10697.0,
            ebitdaMarginPercent: 3.5,
            patCr: 190.0,
            netMarginPercent: 1.8,
            roePercent: 21.4,
            rocePercent: 28.2,
            assetTurnover: 4.8,
            ocfCr: 284.0,
            capexCr: 210.0,
            debtorDays: 45,
            inventoryDays: 32,
            creditorDays: 68,
            totalDebtCr: 415.0,
            netDebtEbitda: 0.8,
            interestCoverage: 9.2,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY23',
            revenueCr: 12192.0,
            ebitdaMarginPercent: 4.2,
            patCr: 255.0,
            netMarginPercent: 2.1,
            roePercent: 22.8,
            rocePercent: 31.5,
            assetTurnover: 4.9,
            ocfCr: 440.0,
            capexCr: 290.0,
            debtorDays: 42,
            inventoryDays: 30,
            creditorDays: 65,
            totalDebtCr: 380.0,
            netDebtEbitda: 0.5,
            interestCoverage: 11.4,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY24',
            revenueCr: 17690.0,
            ebitdaMarginPercent: 3.9,
            patCr: 375.0,
            netMarginPercent: 2.1,
            roePercent: 25.1,
            rocePercent: 35.8,
            assetTurnover: 5.1,
            ocfCr: 620.0,
            capexCr: 380.0,
            debtorDays: 38,
            inventoryDays: 28,
            creditorDays: 62,
            totalDebtCr: 290.0,
            netDebtEbitda: 0.3,
            interestCoverage: 14.8,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY25',
            revenueCr: 26800.0,
            ebitdaMarginPercent: 4.1,
            patCr: 610.0,
            netMarginPercent: 2.3,
            roePercent: 28.4,
            rocePercent: 41.2,
            assetTurnover: 5.3,
            ocfCr: 890.0,
            capexCr: 490.0,
            debtorDays: 36,
            inventoryDays: 27,
            creditorDays: 59,
            totalDebtCr: 220.0,
            netDebtEbitda: 0.1,
            interestCoverage: 19.2,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY26',
            revenueCr: 36500.0,
            ebitdaMarginPercent: 4.4,
            patCr: 940.0,
            netMarginPercent: 2.6,
            roePercent: 31.0,
            rocePercent: 44.5,
            assetTurnover: 5.4,
            ocfCr: 1350.0,
            capexCr: 580.0,
            debtorDays: 35,
            inventoryDays: 25,
            creditorDays: 56,
            totalDebtCr: 150.0,
            netDebtEbitda: 0.05,
            interestCoverage: 26.5,
          ),
          FinancialPeriodMetric.computed(
            period: 'Q1FY27 (TTM)',
            revenueCr: 10450.0,
            ebitdaMarginPercent: 4.5,
            patCr: 285.0,
            netMarginPercent: 2.7,
            roePercent: 32.2,
            rocePercent: 46.1,
            assetTurnover: 5.5,
            ocfCr: 410.0,
            capexCr: 160.0,
            debtorDays: 34,
            inventoryDays: 24,
            creditorDays: 55,
            totalDebtCr: 120.0,
            netDebtEbitda: 0.02,
            interestCoverage: 31.0,
          ),
        ],
      );
    } else {
      // Default: Tata Motors
      return FinancialEngineData(
        salesCagr3Yr: 23.4,
        patCagr3Yr: 88.5,
        synthesisSummary:
            'Turnaround completed. JLR debt significantly pruned to near-zero net debt targets. FCF generation exceeds ₹ 25,000 Cr annualized with strong margin expansion in CV and EV passenger lines.',
        periods: [
          FinancialPeriodMetric.computed(
            period: 'FY22',
            revenueCr: 278454.0,
            ebitdaMarginPercent: 8.9,
            patCr: -11441.0,
            netMarginPercent: -4.1,
            roePercent: -24.8,
            rocePercent: 4.2,
            assetTurnover: 0.9,
            ocfCr: 14280.0,
            capexCr: 15200.0,
            debtorDays: 24,
            inventoryDays: 51,
            creditorDays: 88,
            totalDebtCr: 139680.0,
            netDebtEbitda: 2.9,
            interestCoverage: 2.6,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY23',
            revenueCr: 345967.0,
            ebitdaMarginPercent: 10.7,
            patCr: 2414.0,
            netMarginPercent: 0.7,
            roePercent: 5.3,
            rocePercent: 11.8,
            assetTurnover: 1.1,
            ocfCr: 35400.0,
            capexCr: 16800.0,
            debtorDays: 21,
            inventoryDays: 48,
            creditorDays: 85,
            totalDebtCr: 127500.0,
            netDebtEbitda: 1.8,
            interestCoverage: 4.1,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY24',
            revenueCr: 437928.0,
            ebitdaMarginPercent: 14.3,
            patCr: 31399.0,
            netMarginPercent: 7.2,
            roePercent: 34.2,
            rocePercent: 24.6,
            assetTurnover: 1.3,
            ocfCr: 58900.0,
            capexCr: 24200.0,
            debtorDays: 18,
            inventoryDays: 44,
            creditorDays: 82,
            totalDebtCr: 94800.0,
            netDebtEbitda: 0.7,
            interestCoverage: 8.8,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY25',
            revenueCr: 472500.0,
            ebitdaMarginPercent: 14.8,
            patCr: 35800.0,
            netMarginPercent: 7.6,
            roePercent: 31.8,
            rocePercent: 27.2,
            assetTurnover: 1.4,
            ocfCr: 64200.0,
            capexCr: 28500.0,
            debtorDays: 17,
            inventoryDays: 42,
            creditorDays: 80,
            totalDebtCr: 62400.0,
            netDebtEbitda: 0.3,
            interestCoverage: 12.4,
          ),
          FinancialPeriodMetric.computed(
            period: 'FY26',
            revenueCr: 512000.0,
            ebitdaMarginPercent: 15.2,
            patCr: 41200.0,
            netMarginPercent: 8.0,
            roePercent: 29.5,
            rocePercent: 29.8,
            assetTurnover: 1.4,
            ocfCr: 72000.0,
            capexCr: 31000.0,
            debtorDays: 16,
            inventoryDays: 40,
            creditorDays: 78,
            totalDebtCr: 38000.0,
            netDebtEbitda: 0.1,
            interestCoverage: 18.2,
          ),
          FinancialPeriodMetric.computed(
            period: 'Q1FY27 (TTM)',
            revenueCr: 134200.0,
            ebitdaMarginPercent: 15.4,
            patCr: 11150.0,
            netMarginPercent: 8.3,
            roePercent: 30.1,
            rocePercent: 30.6,
            assetTurnover: 1.5,
            ocfCr: 19800.0,
            capexCr: 8200.0,
            debtorDays: 16,
            inventoryDays: 39,
            creditorDays: 77,
            totalDebtCr: 28500.0,
            netDebtEbitda: 0.05,
            interestCoverage: 22.0,
          ),
        ],
      );
    }
  }

  @override
  Future<ForensicScreen> extractForensicScreen(String symbol) async {
    final s = symbol.toUpperCase().trim();
    if (s == 'DIXON') {
      return const ForensicScreen(
        promoterHoldingPercent: 33.4,
        pledgedSharesPercent: 0.0,
        insiderTransactionPattern: 'Stable; minor promoter ESOP exercises with no market selling.',
        auditorFirm: 'B S R & Co. LLP (KPMG affiliate)',
        auditorStabilityNote: 'Tenure > 5 years; Unqualified audit opinion with zero notes on going concern or material irregularities.',
        hasAuditorQualifications: false,
        relatedPartyTransactionsAudit:
            'Transactions limited to arm\'s-length subsidiary component sourcing (Padget Electronics, Dixon Electro). No promoter entity cross-lending.',
        checklist: RedFlagChecklist(
          promoterPledgeAbove10: false,
          ocfLowerThanPat3Yr: false,
          receivablesGrowthDivergence: false,
          pendingNcltOrMaterialLitigation: false,
          detailsPledge: '0.0% pledged shares.',
          detailsCashFlow: 'OCF (₹ 890 Cr) comfortably exceeds PAT (₹ 610 Cr) in FY25.',
          detailsReceivables: 'Debtor days reduced from 45 to 35 days.',
          detailsLitigation: 'No pending NCLT, GST disputes under standard appellate thresholds.',
        ),
        riskLevel: ForensicRiskLevel.clean,
        agent5ForensicVerdict: 'Pristine forensic audit. Zero red flags found across MCA filings, auditor qualifications, and cash-flow integrity.',
      );
    } else {
      return const ForensicScreen(
        promoterHoldingPercent: 46.4,
        pledgedSharesPercent: 0.0,
        insiderTransactionPattern: 'Tata Sons bought shares consistently during market dips; zero open market promoter liquidation.',
        auditorFirm: 'B S R & Co. LLP',
        auditorStabilityNote: 'Clean unmodified opinion; high transparency on JLR capitalized R&D expenditure and hedge accounting.',
        hasAuditorQualifications: false,
        relatedPartyTransactionsAudit:
            'All transactions are with Tata Group entities (Tata Technologies for automotive engineering, Tata AutoComp for tier-1 supply) approved via independent audit committee.',
        checklist: RedFlagChecklist(
          promoterPledgeAbove10: false,
          ocfLowerThanPat3Yr: false,
          receivablesGrowthDivergence: false,
          pendingNcltOrMaterialLitigation: false,
          detailsPledge: '0.0% promoter pledge across Tata Sons holdings.',
          detailsCashFlow: 'OCF/PAT ratio stands at 1.8x in FY24 (₹ 58,900 Cr OCF vs ₹ 31,399 Cr PAT). Highly cash generative.',
          detailsReceivables: 'Receivables days down to 16 days.',
          detailsLitigation: 'Singur land dispute settled with WBIDC; zero existential litigations.',
        ),
        riskLevel: ForensicRiskLevel.clean,
        agent5ForensicVerdict: 'Institutional gold standard. Zero promoter pledge, cash flow conversion exceeding 100% of reported PAT, and top-tier audit stability.',
      );
    }
  }

  @override
  Future<CapexConcallData> extractCapexAndConcall(String symbol) async {
    final s = symbol.toUpperCase().trim();
    if (s == 'DIXON') {
      return const CapexConcallData(
        currentOrderBookCr: 18500.0,
        bookToBillRatio: 1.45,
        newOrdersRunRateCr: 4200.0,
        capexRoadmap: [
          CapexMilestone(
            facilityName: 'Noida Component & Display Module Plant',
            capexAmountCr: 350.0,
            commissioningTimeline: 'Q3 FY26',
            peakRevenuePotentialCr: 4800.0,
            status: 'Under Trial Runs',
          ),
          CapexMilestone(
            facilityName: 'South India Telecom & IT Hardware Facility',
            capexAmountCr: 280.0,
            commissioningTimeline: 'Q1 FY27',
            peakRevenuePotentialCr: 3200.0,
            status: 'Civil Works 85% Complete',
          ),
        ],
        concallTrackRecord: [
          ConcallGuidanceTracking(
            quarter: 'Q4 FY24',
            managementCommitment: 'Guide 40% growth in Mobile division via new client onboarding.',
            actualDelivery: 'Delivered +58% YoY growth in Mobile segment; signed Ismartu & Motorola.',
            isDelivered: true,
            keyQuote: 'We have met and exceeded all PLI tranche investment and production thresholds.',
          ),
          ConcallGuidanceTracking(
            quarter: 'Q3 FY25',
            managementCommitment: 'Backward integrate into camera modules and display assemblies.',
            actualDelivery: 'JV signed with HKC Corporation and initial sample approvals received.',
            isDelivered: true,
            keyQuote: 'Backward integration will expand our net margins by 40-60 bps over the next 18 months.',
          ),
        ],
        guidanceNext1to3Years:
            'Targeting ₹ 45,000 Cr revenue milestone by FY27 with sustained ROCE > 35%. Capex of ₹ 600-700 Cr per annum funded entirely via internal cash accruals.',
        agent7IntelligenceSummary:
            'Flawless management execution track record. Guidance consistently met or beaten. Capacity additions pre-sold to Anchor MNC customers.',
      );
    } else {
      return const CapexConcallData(
        currentOrderBookCr: 148000.0,
        bookToBillRatio: 1.82,
        newOrdersRunRateCr: 32000.0,
        capexRoadmap: [
          CapexMilestone(
            facilityName: 'Sanand EV Line-2 & Battery Assembly Expansion',
            capexAmountCr: 4200.0,
            commissioningTimeline: 'Q4 FY26',
            peakRevenuePotentialCr: 18000.0,
            status: 'Machinery Installation',
          ),
          CapexMilestone(
            facilityName: 'JLR Halewood Modular Electrified Platform (EMA)',
            capexAmountCr: 12000.0,
            commissioningTimeline: 'Mid-2026',
            peakRevenuePotentialCr: 45000.0,
            status: 'Final Validation',
          ),
        ],
        concallTrackRecord: [
          ConcallGuidanceTracking(
            quarter: 'Q1 FY24',
            managementCommitment: 'Net zero auto debt by FY25 and achieve double-digit EBIT margins at JLR.',
            actualDelivery: 'JLR EBIT margin reached 9.2% and Net auto debt decreased by 74%.',
            isDelivered: true,
            keyQuote: 'We are on track to achieve zero net debt in the automotive business by early FY26.',
          ),
        ],
        guidanceNext1to3Years:
            'Demerger of Commercial Vehicles and Passenger Vehicles into two separate listed entities to unlock standalone value. Targeting >10% EBIT margin across PV, EV, and JLR.',
        agent7IntelligenceSummary:
            'Deleveraging commitment delivered ahead of schedule. Demerger will provide rerating catalyst for both CV and PV businesses.',
      );
    }
  }

  @override
  Future<PeerBenchmarkData> extractPeerBenchmarks(String symbol) async {
    final s = symbol.toUpperCase().trim();
    if (s == 'DIXON') {
      return const PeerBenchmarkData(
        currentPe: 79.2,
        median5YrPeBand: 68.5,
        valuationBandAssessment: 'Trading at upper half of historical P/E band, supported by earnings CAGR > 40% and ROCE of 44%.',
        peers: [
          PeerMetric(
            peerName: 'Dixon Tech (Target)',
            ticker: 'DIXON',
            marketCapCr: 74520.0,
            peTtm: 79.2,
            evEbitda: 44.5,
            pbRatio: 22.8,
            rocePercent: 44.5,
            salesCagr3Yr: 41.2,
            patCagr3Yr: 44.8,
            debtToEquity: 0.08,
          ),
          PeerMetric(
            peerName: 'Amber Enterprises',
            ticker: 'AMBER',
            marketCapCr: 21450.0,
            peTtm: 88.4,
            evEbitda: 31.2,
            pbRatio: 9.8,
            rocePercent: 14.8,
            salesCagr3Yr: 24.5,
            patCagr3Yr: 18.2,
            debtToEquity: 0.65,
          ),
          PeerMetric(
            peerName: 'Kaynes Technology',
            ticker: 'KAYNES',
            marketCapCr: 32600.0,
            peTtm: 94.2,
            evEbitda: 52.8,
            pbRatio: 16.4,
            rocePercent: 21.2,
            salesCagr3Yr: 56.4,
            patCagr3Yr: 62.1,
            debtToEquity: 0.12,
          ),
          PeerMetric(
            peerName: 'Syrma SGS Technology',
            ticker: 'SYRMA',
            marketCapCr: 9450.0,
            peTtm: 52.0,
            evEbitda: 26.5,
            pbRatio: 5.4,
            rocePercent: 12.8,
            salesCagr3Yr: 31.2,
            patCagr3Yr: 22.4,
            debtToEquity: 0.32,
          ),
        ],
        bullCase: ValuationScenario(
          scenarioName: 'Bull Case',
          keyAssumption: 'Mobile exports surge via Motorola & Google Pixel; component JVs margin expansion (+80 bps).',
          targetMultiple: 85.0,
          targetPrice: 16800.0,
          returnPotentialPercent: 34.9,
        ),
        baseCase: ValuationScenario(
          scenarioName: 'Base Case',
          keyAssumption: 'Steady 35% revenue CAGR; EBITDA margin stabilizes at 4.5%.',
          targetMultiple: 75.0,
          targetPrice: 14200.0,
          returnPotentialPercent: 14.0,
        ),
        bearCase: ValuationScenario(
          scenarioName: 'Bear Case',
          keyAssumption: 'Delay in component JV ramp-up or client volume cutbacks.',
          targetMultiple: 55.0,
          targetPrice: 9800.0,
          returnPotentialPercent: -21.3,
        ),
      );
    } else {
      return const PeerBenchmarkData(
        currentPe: 8.7,
        median5YrPeBand: 14.2,
        valuationBandAssessment: 'Steep discount to historical median and global automotive peers despite peak ROCE and FCF generation.',
        peers: [
          PeerMetric(
            peerName: 'Tata Motors (Target)',
            ticker: 'TATAMOTORS',
            marketCapCr: 358400.0,
            peTtm: 8.7,
            evEbitda: 4.8,
            pbRatio: 3.2,
            rocePercent: 29.8,
            salesCagr3Yr: 23.4,
            patCagr3Yr: 88.5,
            debtToEquity: 0.38,
          ),
          PeerMetric(
            peerName: 'Mahindra & Mahindra',
            ticker: 'M&M',
            marketCapCr: 345000.0,
            peTtm: 32.4,
            evEbitda: 18.2,
            pbRatio: 5.6,
            rocePercent: 21.4,
            salesCagr3Yr: 28.5,
            patCagr3Yr: 38.2,
            debtToEquity: 0.42,
          ),
          PeerMetric(
            peerName: 'Maruti Suzuki',
            ticker: 'MARUTI',
            marketCapCr: 382000.0,
            peTtm: 28.5,
            evEbitda: 16.4,
            pbRatio: 4.8,
            rocePercent: 19.8,
            salesCagr3Yr: 19.2,
            patCagr3Yr: 42.1,
            debtToEquity: 0.01,
          ),
          PeerMetric(
            peerName: 'Ashok Leyland',
            ticker: 'ASHOKLEY',
            marketCapCr: 68500.0,
            peTtm: 24.2,
            evEbitda: 12.8,
            pbRatio: 6.2,
            rocePercent: 22.4,
            salesCagr3Yr: 26.8,
            patCagr3Yr: 61.2,
            debtToEquity: 0.95,
          ),
        ],
        bullCase: ValuationScenario(
          scenarioName: 'Bull Case',
          keyAssumption: 'Demerger unlocks PV+EV standalone rerating to 22x P/E; JLR sustained net cash position.',
          targetMultiple: 14.0,
          targetPrice: 1450.0,
          returnPotentialPercent: 48.7,
        ),
        baseCase: ValuationScenario(
          scenarioName: 'Base Case',
          keyAssumption: 'Normalized CV cycle growth (+6-8%), JLR margins sustained at 8.5%.',
          targetMultiple: 11.0,
          targetPrice: 1180.0,
          returnPotentialPercent: 21.0,
        ),
        bearCase: ValuationScenario(
          scenarioName: 'Bear Case',
          keyAssumption: 'European auto recession slows JLR deliveries; EV price wars compress gross margins.',
          targetMultiple: 7.0,
          targetPrice: 780.0,
          returnPotentialPercent: -20.0,
        ),
      );
    }
  }
}
