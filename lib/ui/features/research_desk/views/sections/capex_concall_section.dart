import 'package:flutter/material.dart';
import '../../../../../domain/models/capex_concall_data.dart';
import '../../../../../core/theme/stark_theme.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/metric_badge.dart';

class CapexConcallSection extends StatelessWidget {
  final CapexConcallData capex;

  const CapexConcallSection({super.key, required this.capex});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '5. CAPEX HORIZON, ORDER BOOK & CONCALL INTELLIGENCE [AGENT 7]',
          style: TextStyle(
            color: StarkColors.cyan,
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 12),

        // Order Book & Run-rate Metrics
        Row(
          children: [
            Expanded(
              child: MetricBadge(
                label: 'Current Order Book',
                value: IndianCurrencyFormatter.formatCrore(capex.currentOrderBookCr, fractionDigits: 0),
                valueColor: StarkColors.cyan,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MetricBadge(
                label: 'Book-to-Bill Ratio',
                value: '${capex.bookToBillRatio}x',
                valueColor: capex.bookToBillRatio > 1.2 ? StarkColors.emerald : StarkColors.amber,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MetricBadge(
                label: 'New Orders Run-Rate',
                value: IndianCurrencyFormatter.formatCrore(capex.newOrdersRunRateCr, fractionDigits: 0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Capex Roadmap
        const Text(
          'CAPEX ROADMAP & EXPANSION TIMELINES',
          style: TextStyle(color: StarkColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ...capex.capexRoadmap.map((m) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: StarkColors.surfaceElevated,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: StarkColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.factory, color: StarkColors.cyan, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        m.facilityName,
                        style: const TextStyle(
                          color: StarkColors.textPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Timeline: ${m.commissioningTimeline} | Capex: ${IndianCurrencyFormatter.formatCrore(m.capexAmountCr, fractionDigits: 0)} | Peak Rev: ${IndianCurrencyFormatter.formatCrore(m.peakRevenuePotentialCr, fractionDigits: 0)}',
                        style: const TextStyle(color: StarkColors.textSecondary, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: StarkColors.amber.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: StarkColors.amber),
                  ),
                  child: Text(
                    m.status,
                    style: const TextStyle(color: StarkColors.amber, fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          );
        }),
        const SizedBox(height: 12),

        // Concall Track Record & Guidance
        GlassCard(
          backgroundColor: StarkColors.surfaceElevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.headset_mic, color: StarkColors.emerald, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Management Concall Tracking: Commitments vs Delivery',
                    style: TextStyle(color: StarkColors.emerald, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ...capex.concallTrackRecord.map((t) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '[${t.quarter}] Commitment: ',
                            style: const TextStyle(color: StarkColors.cyan, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Expanded(
                            child: Text(
                              t.managementCommitment,
                              style: const TextStyle(color: StarkColors.textPrimary, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          const Text(
                            'Actual Delivery: ',
                            style: TextStyle(color: StarkColors.emerald, fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          Expanded(
                            child: Text(
                              t.actualDelivery,
                              style: const TextStyle(color: StarkColors.textSecondary, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '"${t.keyQuote}"',
                        style: const TextStyle(
                          color: StarkColors.textMuted,
                          fontSize: 11,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(color: StarkColors.border),
              const Text(
                'Guidance Next 1–3 Years:',
                style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                capex.guidanceNext1to3Years,
                style: const TextStyle(color: StarkColors.textSecondary, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
