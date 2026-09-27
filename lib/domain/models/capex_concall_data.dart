class CapexMilestone {
  final String facilityName;
  final double capexAmountCr;
  final String commissioningTimeline;
  final double peakRevenuePotentialCr;
  final String status;

  const CapexMilestone({
    required this.facilityName,
    required this.capexAmountCr,
    required this.commissioningTimeline,
    required this.peakRevenuePotentialCr,
    required this.status,
  });
}

class ConcallGuidanceTracking {
  final String quarter;
  final String managementCommitment;
  final String actualDelivery;
  final bool isDelivered;
  final String keyQuote;

  const ConcallGuidanceTracking({
    required this.quarter,
    required this.managementCommitment,
    required this.actualDelivery,
    required this.isDelivered,
    required this.keyQuote,
  });
}

class CapexConcallData {
  final double currentOrderBookCr;
  final double bookToBillRatio;
  final double newOrdersRunRateCr;
  final List<CapexMilestone> capexRoadmap;
  final List<ConcallGuidanceTracking> concallTrackRecord;
  final String guidanceNext1to3Years;
  final String agent7IntelligenceSummary;

  const CapexConcallData({
    required this.currentOrderBookCr,
    required this.bookToBillRatio,
    required this.newOrdersRunRateCr,
    required this.capexRoadmap,
    required this.concallTrackRecord,
    required this.guidanceNext1to3Years,
    required this.agent7IntelligenceSummary,
  });
}
