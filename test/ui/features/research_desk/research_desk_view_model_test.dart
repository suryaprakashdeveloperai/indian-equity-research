import 'package:flutter_test/flutter_test.dart';
import '../../lib/ui/features/research_desk/view_models/research_desk_view_model.dart';
import '../../lib/domain/use_cases/run_multi_agent_research_use_case.dart';
import '../../lib/data/services/nse_bse_service.dart';
import '../../lib/data/services/filing_scraper_service.dart';
import '../../lib/data/services/agent_inference_service.dart';
import '../../lib/data/repositories/equity_research_repository_impl.dart';

void main() {
  late ResearchDeskViewModel viewModel;

  setUp(() {
    final repo = EquityResearchRepositoryImpl(
      marketDataService: MockNseBseServiceImpl(),
      filingScraperService: MockFilingScraperServiceImpl(),
      agentInferenceService: MockAgentInferenceServiceImpl(),
    );
    final useCase = RunMultiAgentResearchUseCase(repository: repo);
    viewModel = ResearchDeskViewModel(researchUseCase: useCase);
  });

  group('ResearchDeskViewModel Tests', () {
    test('Initial state is idle and not loading', () {
      expect(viewModel.isLoading, isFalse);
      expect(viewModel.report, isNull);
      expect(viewModel.errorMessage, isNull);
    });

    test('analyzeTicker transitions loading state and loads complete report', () async {
      int notifyCount = 0;
      viewModel.addListener(() {
        notifyCount++;
      });

      await viewModel.analyzeTicker('DIXON');

      expect(viewModel.isLoading, isFalse);
      expect(viewModel.report, isNotNull);
      expect(viewModel.report!.company.symbol, equals('DIXON'));
      expect(viewModel.errorMessage, isNull);
      expect(notifyCount, greaterThan(0));
    });
  });
}
