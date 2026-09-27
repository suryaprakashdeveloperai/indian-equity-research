import 'package:flutter/material.dart';
import '../../../../../domain/models/decision_scorecard.dart';
import '../../../../../domain/models/research_report.dart';
import '../../../../../core/theme/stark_theme.dart';
import '../../../../core/widgets/glass_card.dart';

class DecisionScorecardSection extends StatelessWidget {
  final DecisionScorecard scorecard;
  final List<QuarterlyRadarTrigger> radarTriggers;

  const DecisionScorecardSection({
    super.key,
    required this.scorecard,
    required this.radarTriggers,
  });

  @override
  Widget build(BuildContext context) {
    final totalPercent = scorecard.totalScorePercentage;
    final scoreColor = totalPercent >= 85.0
        ? StarkColors.emerald
        : totalPercent >= 70.0
            ? StarkColors.cyan
            : totalPercent >= 55.0
                ? StarkColors.amber
                : StarkColors.crimson;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 7. Decision Scorecard
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '7. DECISION SCORECARD & CONVICTION [ALL AGENTS]',
              style: TextStyle(
                color: StarkColors.cyan,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: scoreColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: scoreColor),
              ),
              child: Text(
                'SCORE: ${scorecard.totalWeightedScore.toStringAsFixed(2)} / 5.0 (${totalPercent.toStringAsFixed(1)}%)',
                style: TextStyle(
                  color: scoreColor,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 100% Weighted Scorecard Table
        GlassCard(
          padding: EdgeInsets.zero,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(StarkColors.surfaceElevated),
            columnSpacing: 14.0,
            horizontalMargin: 12.0,
            columns: const [
              DataColumn(label: Text('Category', style: TextStyle(color: StarkColors.cyan, fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Weight', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Score (1–5)', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
              DataColumn(label: Text('Responsible Agent & Evidence', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
            ],
            rows: scorecard.items.map((item) {
              return DataRow(
                cells: [
                  DataCell(Text(item.category, style: const TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 12))),
                  DataCell(Text('${item.weightPercent.toInt()}%', style: const TextStyle(color: StarkColors.amber, fontFamily: 'monospace', fontSize: 12))),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: StarkColors.cyan.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '${item.score} ★',
                        style: const TextStyle(color: StarkColors.cyan, fontWeight: FontWeight.bold, fontSize: 11),
                      ),
                    ),
                  ),
                  DataCell(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(item.responsibleAgent, style: const TextStyle(color: StarkColors.textMuted, fontSize: 10, fontWeight: FontWeight.bold)),
                        Text(item.primaryEvidence, style: const TextStyle(color: StarkColors.textSecondary, fontSize: 11), overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 12),

        // CIS Sign-off Verdict Banner
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: StarkColors.surfaceElevated,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: scoreColor, width: 1.5),
          ),
          child: Row(
            children: [
              Icon(Icons.verified_user, color: scoreColor, size: 28),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AGENT 1 (CIS) FINAL VERDICT & ALLOCATION SIZING:',
                      style: TextStyle(color: StarkColors.textMuted, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      scorecard.finalVerdictSignedByAgent1,
                      style: TextStyle(color: scoreColor, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Recommended Sizing: ${scorecard.cisCapitalAllocationSize}',
                      style: const TextStyle(color: StarkColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),

        // 8. F.R.I.D.A.Y. Quarterly Radar
        const Text(
          '8. F.R.I.D.A.Y. QUARTERLY RADAR: 4 MEASURABLE EARNINGS TRIGGERS',
          style: TextStyle(
            color: StarkColors.cyan,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        ...radarTriggers.map((t) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: StarkColors.surface,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: StarkColors.border),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: StarkColors.cyan.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: StarkColors.cyan),
                  ),
                  child: Text(
                    '${t.index}',
                    style: const TextStyle(color: StarkColors.cyan, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.triggerTitle,
                        style: const TextStyle(color: StarkColors.textPrimary, fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Target: ${t.measurableTarget}',
                        style: const TextStyle(color: StarkColors.emerald, fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        t.rationale,
                        style: const TextStyle(color: StarkColors.textSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
