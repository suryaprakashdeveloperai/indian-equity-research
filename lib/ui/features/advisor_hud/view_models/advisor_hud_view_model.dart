import 'package:flutter/foundation.dart';
import '../../../../domain/models/agent_chat_message.dart';
import '../../../../domain/use_cases/execute_advisor_dialogue_use_case.dart';
import '../../../../domain/use_cases/simulate_margin_sensitivity_use_case.dart';

class AdvisorHudViewModel extends ChangeNotifier {
  final ExecuteAdvisorDialogueUseCase _dialogueUseCase;
  final SimulateMarginSensitivityUseCase _marginSensitivityUseCase;

  AdvisorHudViewModel({
    required ExecuteAdvisorDialogueUseCase dialogueUseCase,
    required SimulateMarginSensitivityUseCase marginSensitivityUseCase,
  })  : _dialogueUseCase = dialogueUseCase,
        _marginSensitivityUseCase = marginSensitivityUseCase {
    _initializeGreeting();
  }

  final List<AgentChatMessage> _messages = [];
  List<AgentChatMessage> get messages => List.unmodifiable(_messages);

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  double _simulatedBps = 200.0;
  double get simulatedBps => _simulatedBps;

  void _initializeGreeting() {
    _messages.add(
      AgentChatMessage(
        id: 'msg_init',
        sender: AgentSender.friday,
        message:
            'All systems green, Boss. The 8-Agent Desk is at your command. Select any Indian equity above or tell me what to audit—stress-testing related-party items with Agent 5, drafting concall questions with Agent 7, or running margin simulations with Agent 6.',
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<void> sendUserPrompt(String text, String activeSymbol) async {
    final clean = text.trim();
    if (clean.isEmpty) return;

    // 1. Add user message
    _messages.add(
      AgentChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        sender: AgentSender.boss,
        message: clean,
        timestamp: DateTime.now(),
      ),
    );
    _isProcessing = true;
    notifyListeners();

    // 2. Execute dialogue use case
    final result = await _dialogueUseCase.execute(
      query: clean,
      activeSymbol: activeSymbol,
    );

    result.fold(
      onSuccess: (agentReply) {
        _messages.add(agentReply);
        _isProcessing = false;
        notifyListeners();
      },
      onFailure: (err) {
        _messages.add(
          AgentChatMessage(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            sender: AgentSender.friday,
            message: 'Apologies Boss, encounter a telemetry error: ${err.toString()}',
            timestamp: DateTime.now(),
          ),
        );
        _isProcessing = false;
        notifyListeners();
      },
    );
  }

  Future<void> runMarginSimulation(String activeSymbol, double bps) async {
    _simulatedBps = bps;
    await sendUserPrompt(
      'Simulate an operating margin drop of ${bps.toInt()} bps due to raw material inflation.',
      activeSymbol,
    );
  }

  void clearChat() {
    _messages.clear();
    _initializeGreeting();
    notifyListeners();
  }
}
