import 'package:flutter/foundation.dart';
import '../../../../domain/models/research_report.dart';
import '../../../../domain/use_cases/run_multi_agent_research_use_case.dart';

class ResearchDeskViewModel extends ChangeNotifier {
  final RunMultiAgentResearchUseCase _researchUseCase;

  ResearchDeskViewModel({
    required RunMultiAgentResearchUseCase researchUseCase,
  }) : _researchUseCase = researchUseCase;

  ResearchReport? _report;
  ResearchReport? get report => _report;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String _currentStage = 'Awaiting Instructions';
  String get currentStage => _currentStage;

  String _activeSymbol = 'DIXON';
  String get activeSymbol => _activeSymbol;

  Future<void> analyzeTicker(String symbol) async {
    final cleanSymbol = symbol.trim().toUpperCase();
    if (cleanSymbol.isEmpty) return;

    _activeSymbol = cleanSymbol;
    _isLoading = true;
    _errorMessage = null;
    _currentStage = 'Activating 8-Agent Desk on $cleanSymbol...';
    notifyListeners();

    // Stage 1: Market data and filings
    _currentStage = 'Agents 5 & 6 auditing balance sheets and 5-yr cash flows...';
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));

    // Stage 2: Concall and capex
    _currentStage = 'Agent 7 analyzing concalls, order books & guidance...';
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));

    // Stage 3: Peer comps and valuation
    _currentStage = 'Agents 4 & 8 benchmarking peers and valuation scenarios...';
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));

    // Stage 4: CIS sign-off & F.R.I.D.A.Y. verbal briefing
    _currentStage = 'Agent 1 (CIS) signing off verdict; F.R.I.D.A.Y. synthesizing briefing...';
    notifyListeners();

    final result = await _researchUseCase.execute(cleanSymbol);

    result.fold(
      onSuccess: (data) {
        _report = data;
        _isLoading = false;
        _currentStage = 'Desk Briefing Ready';
        _errorMessage = null;
        notifyListeners();
      },
      onFailure: (error) {
        _report = null;
        _isLoading = false;
        _currentStage = 'Analysis Failed';
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
