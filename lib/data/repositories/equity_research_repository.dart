import '../../core/utils/result.dart';
import '../../domain/models/company_profile.dart';
import '../../domain/models/research_report.dart';

abstract class EquityResearchRepository {
  Future<Result<CompanyProfile>> getCompanyProfile(String symbol);
  Future<Result<ResearchReport>> getInstitutionalReport(String symbol);
  Future<List<String>> searchTickers(String query);
  void clearCache();
}
