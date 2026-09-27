class IndianCurrencyFormatter {
  /// Formats value into ₹ Crore (e.g. ₹ 74,520 Cr)
  static String formatCrore(double value, {int fractionDigits = 1}) {
    if (value >= 100000) {
      return '₹ ${(value / 100000).toStringAsFixed(fractionDigits)} Lakh Cr';
    }
    return '₹ ${value.toStringAsFixed(fractionDigits)} Cr';
  }

  /// Formats percentages (e.g. +18.4% or -3.2%)
  static String formatPercent(double value, {bool showSign = true, int fractionDigits = 1}) {
    final sign = showSign && value > 0 ? '+' : '';
    return '$sign${value.toStringAsFixed(fractionDigits)}%';
  }

  /// Formats multiple values like P/E, EV/EBITDA
  static String formatMultiple(double value, {int fractionDigits = 1}) {
    return '${value.toStringAsFixed(fractionDigits)}x';
  }

  /// Formats days (e.g. 42 days)
  static String formatDays(int days) {
    return '$days days';
  }
}
