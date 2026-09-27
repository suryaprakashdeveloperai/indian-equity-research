import '../../core/utils/result.dart';
import '../models/agent_chat_message.dart';
import '../../data/repositories/agent_engine_repository.dart';

class ExecuteAdvisorDialogueUseCase {
  final AgentEngineRepository _agentRepository;

  ExecuteAdvisorDialogueUseCase({
    required AgentEngineRepository agentRepository,
  }) : _agentRepository = agentRepository;

  Future<Result<AgentChatMessage>> execute({
    required String query,
    required String activeSymbol,
  }) async {
    if (query.trim().isEmpty) {
      return Result.failure(Exception('Query cannot be empty.'));
    }
    return _agentRepository.sendAdvisorQuery(
      query: query,
      activeSymbol: activeSymbol,
    );
  }
}
