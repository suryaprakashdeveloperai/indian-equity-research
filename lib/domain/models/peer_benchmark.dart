class PeerMetric {
  final String peerName;
  final String ticker;
  final double marketCapCr;
  final double peTtm;
  final double evEbitda;
  final double pbRatio;
  final double rocePercent;
  final double salesCagr3Yr;
  final double patCagr3Yr;
  final double debtToEquity;

  const PeerMetric({
    required this.peerName,
    required this.ticker,
    required this.marketCapCr,
    required this.peTtm,
    required this.evEbitda,
    required this.pbRatio,
    required this.rocePercent,
    required this.salesCagr3Yr,
    required this.patCagr3Yr,
    required this.debtToEquity,
  });
}

class ValuationScenario {
  final String scenarioName; // Bull, Base, Bear
  final String keyAssumption;
  final double targetMultiple; // P/E or EV/EBITDA
  final double targetPrice;
  final double returnPotentialPercent;

  const ValuationScenario({
    required this.scenarioName,
    required this.keyAssumption,
    required this.targetMultiple,
    required this.targetPrice,
    required this.returnPotentialPercent,
  });
}

class PeerBenchmarkData {
  final List<PeerMetric> peers; // Company + 3 peers
  final double currentPe;
  final double median5YrPeBand;
  final String valuationBandAssessment;
  final ValuationScenario bullCase;
  final ValuationScenario baseCase;
  final ValuationScenario bearCase;

  const PeerBenchmarkData({
    required this.peers,
    required this.currentPe,
    required this.median5YrPeBand,
    required this.valuationBandAssessment,
    required this.bullCase,
    required this.baseCase,
    required this.bearCase,
  });
}
