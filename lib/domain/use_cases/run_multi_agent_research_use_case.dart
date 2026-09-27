import '../../core/utils/result.dart';
import '../models/research_report.dart';
import '../../data/repositories/equity_research_repository.dart';

class RunMultiAgentResearchUseCase {
  final EquityResearchRepository _repository;

  RunMultiAgentResearchUseCase({required EquityResearchRepository repository})
      : _repository = repository;

  Future<Result<ResearchReport>> execute(String symbol) async {
    if (symbol.trim().isEmpty) {
      return Result.failure(Exception('NSE/BSE symbol cannot be empty.'));
    }

    final result = await _repository.getInstitutionalReport(symbol);

    return result.fold(
      onSuccess: (report) {
        // Zero-Hallucination Integrity Check
        // Enforce Rule 1 & 2: Cash flow integrity and forensic check validation
        for (final period in report.financialEngine.periods) {
          final expectedFcf = period.ocfCr - period.capexCr;
          if ((expectedFcf - period.fcfCr).abs() > 0.01) {
            return Result.failure(
              Exception(
                'Data Integrity Violation: FCF mismatch in ${period.period} (OCF: ${period.ocfCr}, Capex: ${period.capexCr}, Reported FCF: ${period.fcfCr}).',
              ),
            );
          }
        }
        return Result.success(report);
      },
      onFailure: (error) => Result.failure(error),
    );
  }
}
