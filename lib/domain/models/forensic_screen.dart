enum ForensicRiskLevel {
  clean('Clean / Low Risk'),
  elevated('Elevated Scrutiny Required'),
  severe('Severe Forensic Red Flags');

  final String label;
  const ForensicRiskLevel(this.label);
}

class RedFlagChecklist {
  final bool promoterPledgeAbove10;
  final bool ocfLowerThanPat3Yr;
  final bool receivablesGrowthDivergence;
  final bool pendingNcltOrMaterialLitigation;
  final String detailsPledge;
  final String detailsCashFlow;
  final String detailsReceivables;
  final String detailsLitigation;

  const RedFlagChecklist({
    required this.promoterPledgeAbove10,
    required this.ocfLowerThanPat3Yr,
    required this.receivablesGrowthDivergence,
    required this.pendingNcltOrMaterialLitigation,
    required this.detailsPledge,
    required this.detailsCashFlow,
    required this.detailsReceivables,
    required this.detailsLitigation,
  });

  int get redFlagCount =>
      (promoterPledgeAbove10 ? 1 : 0) +
      (ocfLowerThanPat3Yr ? 1 : 0) +
      (receivablesGrowthDivergence ? 1 : 0) +
      (pendingNcltOrMaterialLitigation ? 1 : 0);
}

class ForensicScreen {
  final double promoterHoldingPercent;
  final double pledgedSharesPercent;
  final String insiderTransactionPattern;
  final String auditorFirm;
  final String auditorStabilityNote;
  final bool hasAuditorQualifications;
  final String relatedPartyTransactionsAudit;
  final RedFlagChecklist checklist;
  final ForensicRiskLevel riskLevel;
  final String agent5ForensicVerdict;

  const ForensicScreen({
    required this.promoterHoldingPercent,
    required this.pledgedSharesPercent,
    required this.insiderTransactionPattern,
    required this.auditorFirm,
    required this.auditorStabilityNote,
    required this.hasAuditorQualifications,
    required this.relatedPartyTransactionsAudit,
    required this.checklist,
    required this.riskLevel,
    required this.agent5ForensicVerdict,
  });
}
