import '../../core/utils/result.dart';
import '../../domain/models/agent_chat_message.dart';
import '../services/agent_inference_service.dart';

abstract class AgentEngineRepository {
  Future<Result<AgentChatMessage>> sendAdvisorQuery({
    required String query,
    required String activeSymbol,
  });

  Future<Result<AgentChatMessage>> simulateMarginDrop({
    required String activeSymbol,
    required double bpsDrop,
  });
}

class AgentEngineRepositoryImpl implements AgentEngineRepository {
  final AgentInferenceService _inferenceService;

  AgentEngineRepositoryImpl({
    required AgentInferenceService inferenceService,
  }) : _inferenceService = inferenceService;

  @override
  Future<Result<AgentChatMessage>> sendAdvisorQuery({
    required String query,
    required String activeSymbol,
  }) async {
    try {
      final response = await _inferenceService.processAdvisorQuery(
        query: query,
        activeSymbol: activeSymbol,
      );
      return Result.success(response);
    } catch (e, st) {
      return Result.failure(Exception('Advisor processing failed: $e'), st);
    }
  }

  @override
  Future<Result<AgentChatMessage>> simulateMarginDrop({
    required String activeSymbol,
    required double bpsDrop,
  }) async {
    try {
      final response = await _inferenceService.processAdvisorQuery(
        query: 'Simulate an operating margin drop of ${bpsDrop.toInt()} bps due to raw material inflation.',
        activeSymbol: activeSymbol,
      );
      return Result.success(response);
    } catch (e, st) {
      return Result.failure(Exception('Simulation failed: $e'), st);
    }
  }
}
