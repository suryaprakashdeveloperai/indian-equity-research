import 'package:flutter/material.dart';
import '../../../../../domain/models/peer_benchmark.dart';
import '../../../../../core/theme/stark_theme.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/glass_card.dart';

class PeerBenchmarkSection extends StatelessWidget {
  final PeerBenchmarkData benchmark;

  const PeerBenchmarkSection({super.key, required this.benchmark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '6. PEER BENCHMARKING & VALUATION SCENARIOS [AGENT 8 & 4]',
              style: TextStyle(
                color: StarkColors.cyan,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            Text(
              '5-Yr Median P/E: ${benchmark.median5YrPeBand}x',
              style: const TextStyle(color: StarkColors.amber, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          benchmark.valuationBandAssessment,
          style: const TextStyle(color: StarkColors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 12),

        // Peers Comparison Table
        GlassCard(
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(StarkColors.surfaceElevated),
              columnSpacing: 16.0,
              horizontalMargin: 12.0,
              columns: const [
                DataColumn(label: Text('Company', style: TextStyle(color: StarkColors.cyan, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Mkt Cap (₹ Cr)', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('P/E (TTM)', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('EV/EBITDA', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('P/B', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('ROCE %', style: TextStyle(color: StarkColors.emerald, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('3Y Sales CAGR', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('3Y PAT CAGR', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Debt/Equity', style: TextStyle(color: StarkColors.textSecondary, fontWeight: FontWeight.bold))),
              ],
              rows: benchmark.peers.map((p) {
                final isTarget = p.peerName.contains('Target');
                final style = TextStyle(
                  color: isTarget ? StarkColors.cyan : StarkColors.textPrimary,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: isTarget ? FontWeight.bold : FontWeight.normal,
                );

                return DataRow(
                  cells: [
                    DataCell(Text(p.peerName, style: style.copyWith(fontWeight: FontWeight.bold))),
                    DataCell(Text(IndianCurrencyFormatter.formatCrore(p.marketCapCr, fractionDigits: 0), style: style)),
                    DataCell(Text('${p.peTtm}x', style: style)),
                    DataCell(Text('${p.evEbitda}x', style: style)),
                    DataCell(Text('${p.pbRatio}x', style: style)),
                    DataCell(Text('${p.rocePercent}%', style: style.copyWith(color: StarkColors.emerald))),
                    DataCell(Text('${p.salesCagr3Yr}%', style: style)),
                    DataCell(Text('${p.patCagr3Yr}%', style: style)),
                    DataCell(Text('${p.debtToEquity}x', style: style)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Bull / Base / Bear Valuation Scenarios
        const Text(
          'VALUATION SCENARIOS & ASYMMETRIC PAYOFF MATRIX',
          style: TextStyle(color: StarkColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildScenarioCard(benchmark.bullCase, StarkColors.emerald, Icons.rocket_launch)),
            const SizedBox(width: 8),
            Expanded(child: _buildScenarioCard(benchmark.baseCase, StarkColors.cyan, Icons.balance)),
            const SizedBox(width: 8),
            Expanded(child: _buildScenarioCard(benchmark.bearCase, StarkColors.crimson, Icons.trending_down)),
          ],
        ),
      ],
    );
  }

  Widget _buildScenarioCard(ValuationScenario scenario, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: StarkColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: color.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                scenario.scenarioName.toUpperCase(),
                style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Icon(icon, color: color, size: 16),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Target: ₹ ${scenario.targetPrice.toInt()}',
            style: const TextStyle(
              color: StarkColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
          Text(
            'Payoff: ${IndianCurrencyFormatter.formatPercent(scenario.returnPotentialPercent)}',
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Multiple: ${scenario.targetMultiple}x P/E',
            style: const TextStyle(color: StarkColors.textMuted, fontSize: 11),
          ),
          const SizedBox(height: 6),
          Text(
            scenario.keyAssumption,
            style: const TextStyle(color: StarkColors.textSecondary, fontSize: 11, height: 1.3),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
