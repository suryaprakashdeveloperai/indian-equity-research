class CompanyProfile {
  final String symbol;
  final String name;
  final String sector;
  final String exchange;
  final double currentPrice;
  final double marketCapCr;
  final double high52w;
  final double low52w;
  final String operationalMoat;
  final String revenueSegmentation;

  const CompanyProfile({
    required this.symbol,
    required this.name,
    required this.sector,
    required this.exchange,
    required this.currentPrice,
    required this.marketCapCr,
    required this.high52w,
    required this.low52w,
    required this.operationalMoat,
    required this.revenueSegmentation,
  });
}
