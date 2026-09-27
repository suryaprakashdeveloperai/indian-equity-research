import 'package:flutter_test/flutter_test.dart';
import '../../lib/domain/models/financial_engine_data.dart';

void main() {
  group('FinancialPeriodMetric Computed Formula Verification', () {
    test('Calculates FCF = OCF - Capex and CCC = Debtor + Inventory - Creditor correctly', () {
      final metric = FinancialPeriodMetric.computed(
        period: 'FY25',
        revenueCr: 26800.0,
        ebitdaMarginPercent: 4.1,
        patCr: 610.0,
        netMarginPercent: 2.3,
        roePercent: 28.4,
        rocePercent: 41.2,
        assetTurnover: 5.3,
        ocfCr: 890.0,
        capexCr: 490.0,
        debtorDays: 36,
        inventoryDays: 27,
        creditorDays: 59,
        totalDebtCr: 220.0,
        netDebtEbitda: 0.1,
        interestCoverage: 19.2,
      );

      // FCF = 890 - 490 = 400
      expect(metric.fcfCr, equals(400.0));
      // CCC = 36 + 27 - 59 = 4 days
      expect(metric.cccDays, equals(4));
      // OCF/PAT = 890 / 610 ~= 1.459x
      expect(metric.ocfPatRatio, closeTo(1.459, 0.01));
    });
  });
}
