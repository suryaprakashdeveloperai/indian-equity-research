class ScorecardItem {
  final String category;
  final double weightPercent; // e.g. 20.0
  final double score; // 1.0 to 5.0
  final String primaryEvidence;
  final String responsibleAgent;

  const ScorecardItem({
    required this.category,
    required this.weightPercent,
    required this.score,
    required this.primaryEvidence,
    required this.responsibleAgent,
  });

  double get weightedContribution => (score * weightPercent) / 100.0;
}

class DecisionScorecard {
  final List<ScorecardItem> items;
  final String finalVerdictSignedByAgent1;
  final String cisCapitalAllocationSize;

  const DecisionScorecard({
    required this.items,
    required this.finalVerdictSignedByAgent1,
    required this.cisCapitalAllocationSize,
  });

  /// Calculates total weighted score on 5.0 scale
  double get totalWeightedScore {
    double total = 0.0;
    for (final item in items) {
      total += item.weightedContribution;
    }
    return total;
  }

  /// Calculates weighted score as a percentage (0 to 100%)
  double get totalScorePercentage => (totalWeightedScore / 5.0) * 100.0;
}
