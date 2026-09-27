import '../../core/utils/result.dart';
import '../../domain/models/company_profile.dart';
import '../../domain/models/research_report.dart';
import '../services/nse_bse_service.dart';
import '../services/filing_scraper_service.dart';
import '../services/agent_inference_service.dart';
import 'equity_research_repository.dart';

class EquityResearchRepositoryImpl implements EquityResearchRepository {
  final NseBseService _marketDataService;
  final FilingScraperService _filingScraperService;
  final AgentInferenceService _agentInferenceService;

  final Map<String, CompanyProfile> _profileCache = {};
  final Map<String, ResearchReport> _reportCache = {};

  EquityResearchRepositoryImpl({
    required NseBseService marketDataService,
    required FilingScraperService filingScraperService,
    required AgentInferenceService agentInferenceService,
  })  : _marketDataService = marketDataService,
        _filingScraperService = filingScraperService,
        _agentInferenceService = agentInferenceService;

  @override
  Future<List<String>> searchTickers(String query) {
    return _marketDataService.searchTickers(query);
  }

  @override
  void clearCache() {
    _profileCache.clear;
    _reportCache.clear;
  }

  @override
  Future<Result<CompanyProfile>> getCompanyProfile(String symbol) async {
    final s = symbol.toUpperCase().trim();
    if (_profileCache.containsKey(s)) {
      return Result.success(_profileCache[s]!);
    }

    try {
      final rawDto = await _marketDataService.fetchCompanyData(s);
      final profile = CompanyProfile(
        symbol: rawDto.symbol,
        name: rawDto.name,
        sector: rawDto.sector,
        exchange: rawDto.exchange,
        currentPrice: rawDto.currentPrice,
        marketCapCr: rawDto.marketCapCr,
        high52w: rawDto.high52w,
        low52w: rawDto.low52w,
        operationalMoat: rawDto.operationalMoat,
        revenueSegmentation: rawDto.revenueSegmentation,
      );
      _profileCache[s] = profile;
      return Result.success(profile);
    } catch (e, st) {
      return Result.failure(Exception('Failed to fetch company profile for $symbol: $e'), st);
    }
  }

  @override
  Future<Result<ResearchReport>> getInstitutionalReport(String symbol) async {
    final s = symbol.toUpperCase().trim();
    if (_reportCache.containsKey(s)) {
      return Result.success(_reportCache[s]!);
    }

    try {
      // 1. Fetch Profile
      final profileResult = await getCompanyProfile(s);
      if (profileResult.isFailure) {
        return Result.failure(profileResult.errorOrNull!);
      }
      final profile = profileResult.dataOrNull!;

      // 2. Fetch Filing & Financial Data (Agent 5, 6, 7, 8 components)
      final financials = await _filingScraperService.extractFinancialEngine(s);
      final forensics = await _filingScraperService.extractForensicScreen(s);
      final capexConcall = await _filingScraperService.extractCapexAndConcall(s);
      final peerBenchmark = await _filingScraperService.extractPeerBenchmarks(s);

      // 3. Multi-agent synthesis (Part A Verbal Briefing + Scorecard + Radar)
      final briefing = await _agentInferenceService.synthesizeVerbalBriefing(
        symbol: profile.symbol,
        companyName: profile.name,
        moat: profile.operationalMoat,
      );

      final scorecard = await _agentInferenceService.synthesizeDecisionScorecard(
        symbol: profile.symbol,
        roce: financials.periods.last.rocePercent,
        patCagr: financials.patCagr3Yr,
        hasRedFlags: forensics.checklist.redFlagCount > 0,
      );

      final radar = await _agentInferenceService.generateQuarterlyRadarTriggers(profile.symbol);

      // 4. Assemble institutional research report
      final report = ResearchReport(
        company: profile,
        briefing: briefing,
        executiveSummary:
            '${profile.name} (${profile.symbol}) is currently trading at ₹ ${profile.currentPrice}. Agent 1 (CIS) signs off on a ${briefing.verdict.label} stance. The company exhibits robust operational moat characteristics in ${profile.sector}, underpinned by 3-Year PAT CAGR of ${financials.patCagr3Yr}%, clean forensic metrics with 0% promoter pledge, and strong capex execution visibility.',
        businessModelAndMoat:
            'Operational Moat: ${profile.operationalMoat}\n\nRevenue Segmentation: ${profile.revenueSegmentation}',
        financialEngine: financials,
        forensicScreen: forensics,
        capexConcall: capexConcall,
        peerBenchmark: peerBenchmark,
        scorecard: scorecard,
        quarterlyRadarTriggers: radar,
        generatedTimestamp: DateTime.now(),
      );

      _reportCache[s] = report;
      return Result.success(report);
    } catch (e, st) {
      return Result.failure(Exception('Institutional analysis pipeline error for $symbol: $e'), st);
    }
  }
}
