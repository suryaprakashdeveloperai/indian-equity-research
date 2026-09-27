import '../../core/utils/result.dart';
import '../models/agent_chat_message.dart';
import '../../data/repositories/agent_engine_repository.dart';

class MarginSensitivityResult {
  final double originalEbitdaMargin;
  final double stressedEbitdaMargin;
  final double ebitdaImpactCr;
  final double revisedPatCr;
  final double revisedTargetPrice;
  final String impactAnalysis;

  const MarginSensitivityResult({
    required this.originalEbitdaMargin,
    required this.stressedEbitdaMargin,
    required this.ebitdaImpactCr,
    required this.revisedPatCr,
    required this.revisedTargetPrice,
    required this.impactAnalysis,
  });
}

class SimulateMarginSensitivityUseCase {
  final AgentEngineRepository _agentRepository;

  SimulateMarginSensitivityUseCase({
    required AgentEngineRepository agentRepository,
  }) : _agentRepository = agentRepository;

  Future<Result<AgentChatMessage>> execute({
    required String activeSymbol,
    required double bpsDrop, // e.g. 200.0 for 200 bps
  }) async {
    if (bpsDrop <= 0) {
      return Result.failure(Exception('Basis points drop must be greater than zero.'));
    }
    return _agentRepository.simulateMarginDrop(
      activeSymbol: activeSymbol,
      bpsDrop: bpsDrop,
    );
  }
}
