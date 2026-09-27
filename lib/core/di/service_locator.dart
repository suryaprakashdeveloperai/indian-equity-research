import '../../data/services/nse_bse_service.dart';
import '../../data/services/filing_scraper_service.dart';
import '../../data/services/agent_inference_service.dart';
import '../../data/repositories/equity_research_repository.dart';
import '../../data/repositories/equity_research_repository_impl.dart';
import '../../data/repositories/agent_engine_repository.dart';
import '../../data/repositories/agent_engine_repository_impl.dart';
import '../../domain/use_cases/run_multi_agent_research_use_case.dart';
import '../../domain/use_cases/simulate_margin_sensitivity_use_case.dart';
import '../../domain/use_cases/execute_advisor_dialogue_use_case.dart';
import '../../ui/features/research_desk/view_models/research_desk_view_model.dart';
import '../../ui/features/advisor_hud/view_models/advisor_hud_view_model.dart';

class ServiceLocator {
  static late final NseBseService nseBseService;
  static late final FilingScraperService filingScraperService;
  static late final AgentInferenceService agentInferenceService;

  static late final EquityResearchRepository equityResearchRepository;
  static late final AgentEngineRepository agentEngineRepository;

  static late final RunMultiAgentResearchUseCase runMultiAgentResearchUseCase;
  static late final SimulateMarginSensitivityUseCase simulateMarginSensitivityUseCase;
  static late final ExecuteAdvisorDialogueUseCase executeAdvisorDialogueUseCase;

  static void init() {
    // 1. Services
    nseBseService = MockNseBseServiceImpl();
    filingScraperService = MockFilingScraperServiceImpl();
    agentInferenceService = MockAgentInferenceServiceImpl();

    // 2. Repositories
    equityResearchRepository = EquityResearchRepositoryImpl(
      marketDataService: nseBseService,
      filingScraperService: filingScraperService,
      agentInferenceService: agentInferenceService,
    );
    agentEngineRepository = AgentEngineRepositoryImpl(
      inferenceService: agentInferenceService,
    );

    // 3. Use Cases
    runMultiAgentResearchUseCase = RunMultiAgentResearchUseCase(
      repository: equityResearchRepository,
    );
    simulateMarginSensitivityUseCase = SimulateMarginSensitivityUseCase(
      agentRepository: agentEngineRepository,
    );
    executeAdvisorDialogueUseCase = ExecuteAdvisorDialogueUseCase(
      agentRepository: agentEngineRepository,
    );
  }

  static ResearchDeskViewModel createResearchDeskViewModel() {
    return ResearchDeskViewModel(
      researchUseCase: runMultiAgentResearchUseCase,
    );
  }

  static AdvisorHudViewModel createAdvisorHudViewModel() {
    return AdvisorHudViewModel(
      dialogueUseCase: executeAdvisorDialogueUseCase,
      marginSensitivityUseCase: simulateMarginSensitivityUseCase,
    );
  }
}
