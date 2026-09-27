enum ConvictionVerdict {
  strongConvictionBuy('Strong Conviction Buy'),
  accumulate('Accumulate'),
  hold('Hold'),
  avoid('Avoid');

  final String label;
  const ConvictionVerdict(this.label);
}

class VerbalBriefing {
  final String companyName;
  final String setup;
  final String alphaCatalyst;
  final String landmine;
  final ConvictionVerdict verdict;
  final String invalidationTrigger;
  final double invalidationPrice;
  final String audioSignOff;

  const VerbalBriefing({
    required this.companyName,
    required this.setup,
    required this.alphaCatalyst,
    required this.landmine,
    required this.verdict,
    required this.invalidationTrigger,
    required this.invalidationPrice,
    required this.audioSignOff,
  });

  /// Spoken transcript formatted specifically for F.R.I.D.A.Y.'s voice synthesis
  String get fullSpokenTranscript => '''
Boss, here is your tactical briefing on $companyName.

The Setup: $setup

The Alpha Catalyst: $alphaCatalyst

The Landmine: $landmine

The Chief's Verdict: Agent 1 signs off as ${verdict.label}. Invalidation trigger: $invalidationTrigger at ₹ $invalidationPrice.

$audioSignOff
''';
}
