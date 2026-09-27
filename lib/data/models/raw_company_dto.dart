class RawCompanyDto {
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

  const RawCompanyDto({
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

  factory RawCompanyDto.fromJson(Map<String, dynamic> json) {
    return RawCompanyDto(
      symbol: json['symbol'] as String,
      name: json['name'] as String,
      sector: json['sector'] as String,
      exchange: json['exchange'] as String? ?? 'NSE / BSE',
      currentPrice: (json['currentPrice'] as num).toDouble(),
      marketCapCr: (json['marketCapCr'] as num).toDouble(),
      high52w: (json['high52w'] as num).toDouble(),
      low52w: (json['low52w'] as num).toDouble(),
      operationalMoat: json['operationalMoat'] as String,
      revenueSegmentation: json['revenueSegmentation'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'symbol': symbol,
        'name': name,
        'sector': sector,
        'exchange': exchange,
        'currentPrice': currentPrice,
        'marketCapCr': marketCapCr,
        'high52w': high52w,
        'low52w': low52w,
        'operationalMoat': operationalMoat,
        'revenueSegmentation': revenueSegmentation,
      };
}
