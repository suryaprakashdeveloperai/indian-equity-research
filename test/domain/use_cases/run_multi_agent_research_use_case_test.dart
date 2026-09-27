import 'package:flutter_test/flutter_test.dart';
import '../../lib/domain/use_cases/run_multi_agent_research_use_case.dart';
import '../../lib/data/services/nse_bse_service.dart';
import '../../lib/data/services/filing_scraper_service.dart';
import '../../lib/data/services/agent_inference_service.dart';
import '../../lib/data/repositories/equity_research_repository_impl.dart';

void main() {
  late RunMultiAgentResearchUseCase useCase;

  setUp(() {
    final repo = EquityResearchRepositoryImpl(
      marketDataService: MockNseBseServiceImpl(),
      filingScraperService: MockFilingScraperServiceImpl(),
      agentInferenceService: MockAgentInferenceServiceImpl(),
    );
    useCase = RunMultiAgentResearchUseCase(repository: repo);
  });

  group('RunMultiAgentResearchUseCase Tests', () {
    test('Rejects empty symbol with failure', () async {
      final res = await useCase.execute('   ');
      expect(res.isFailure, isTrue);
    });

    test('Executes research pipeline successfully for DIXON with zero-hallucination validation', () async {
      final res = await useCase.execute('DIXON');
      expect(res.isSuccess, isTrue);

      final report = res.dataOrNull!;
      expect(report.company.symbol, equals('DIXON'));
      expect(report.briefing.verdict.label, equals('Strong Conviction Buy'));
      expect(report.financialEngine.periods.length, equals(6));
      expect(report.forensicScreen.checklist.redFlagCount, equals(0));
      expect(report.quarterlyRadarTriggers.length, equals(4));
    });

    test('Executes research pipeline successfully for TATAMOTORS', () async {
      final res = await useCase.execute('TATAMOTORS');
      expect(res.isSuccess, isTrue);

      final report = res.dataOrNull!;
      expect(report.company.symbol, equals('TATAMOTORS'));
      expect(report.scorecard.totalScorePercentage, greaterThan(80.0));
    });
  });
}
