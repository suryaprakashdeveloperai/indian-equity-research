class FinancialPeriodMetric {
  final String period; // e.g. FY22, FY23, FY24, FY25, FY26, Q1FY27 (Latest)
  final double revenueCr;
  final double ebitdaMarginPercent;
  final double patCr;
  final double netMarginPercent;
  final double roePercent;
  final double rocePercent;
  final double assetTurnover;
  final double ocfCr;
  final double capexCr;
  final double fcfCr; // FCF = OCF - Capex
  final double ocfPatRatio;
  final int debtorDays;
  final int inventoryDays;
  final int creditorDays;
  final int cccDays; // Cash Conversion Cycle = Debtor + Inventory - Creditor
  final double totalDebtCr;
  final double netDebtEbitda;
  final double interestCoverage;

  const FinancialPeriodMetric({
    required this.period,
    required this.revenueCr,
    required this.ebitdaMarginPercent,
    required this.patCr,
    required this.netMarginPercent,
    required this.roePercent,
    required this.rocePercent,
    required this.assetTurnover,
    required this.ocfCr,
    required this.capexCr,
    required this.fcfCr,
    required this.ocfPatRatio,
    required this.debtorDays,
    required this.inventoryDays,
    required this.creditorDays,
    required this.cccDays,
    required this.totalDebtCr,
    required this.netDebtEbitda,
    required this.interestCoverage,
  });

  /// Factory constructor computing FCF and CCC to prevent human/LLM arithmetic drift
  factory FinancialPeriodMetric.computed({
    required String period,
    required double revenueCr,
    required double ebitdaMarginPercent,
    required double patCr,
    required double netMarginPercent,
    required double roePercent,
    required double rocePercent,
    required double assetTurnover,
    required double ocfCr,
    required double capexCr,
    required int debtorDays,
    required int inventoryDays,
    required int creditorDays,
    required double totalDebtCr,
    required double netDebtEbitda,
    required double interestCoverage,
  }) {
    final computedFcf = ocfCr - capexCr;
    final computedOcfPat = patCr > 0 ? (ocfCr / patCr) : 0.0;
    final computedCcc = debtorDays + inventoryDays - creditorDays;

    return FinancialPeriodMetric(
      period: period,
      revenueCr: revenueCr,
      ebitdaMarginPercent: ebitdaMarginPercent,
      patCr: patCr,
      netMarginPercent: netMarginPercent,
      roePercent: roePercent,
      rocePercent: rocePercent,
      assetTurnover: assetTurnover,
      ocfCr: ocfCr,
      capexCr: capexCr,
      fcfCr: computedFcf,
      ocfPatRatio: computedOcfPat,
      debtorDays: debtorDays,
      inventoryDays: inventoryDays,
      creditorDays: creditorDays,
      cccDays: computedCcc,
      totalDebtCr: totalDebtCr,
      netDebtEbitda: netDebtEbitda,
      interestCoverage: interestCoverage,
    );
  }
}

class FinancialEngineData {
  final List<FinancialPeriodMetric> periods;
  final double salesCagr3Yr;
  final double patCagr3Yr;
  final String synthesisSummary;

  const FinancialEngineData({
    required this.periods,
    required this.salesCagr3Yr,
    required this.patCagr3Yr,
    required this.synthesisSummary,
  });
}
