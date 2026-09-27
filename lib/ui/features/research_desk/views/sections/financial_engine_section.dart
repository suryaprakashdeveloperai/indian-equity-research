import 'package:flutter/material.dart';
import '../../../../../domain/models/financial_engine_data.dart';
import '../../../../../core/theme/stark_theme.dart';
import '../../../../../core/utils/currency_formatter.dart';
import '../../../../core/widgets/glass_card.dart';

class FinancialEngineSection extends StatelessWidget {
  final FinancialEngineData data;

  const FinancialEngineSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '3. COMPREHENSIVE FINANCIAL ENGINE [AGENT 6]',
              style: TextStyle(
                color: StarkColors.cyan,
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
              ),
            ),
            Row(
              children: [
                _buildTag('Sales 3-Yr CAGR: ${data.salesCagr3Yr}%', StarkColors.emerald),
                const SizedBox(width: 8),
                _buildTag('PAT 3-Yr CAGR: ${data.patCagr3Yr}%', StarkColors.cyan),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          data.synthesisSummary,
          style: const TextStyle(color: StarkColors.textSecondary, fontSize: 13),
        ),
        const SizedBox(height: 14),

        // Scrollable Institutional Markdown-Style Table
        GlassCard(
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: MaterialStateProperty.all(StarkColors.surfaceElevated),
              dataRowColor: MaterialStateProperty.all(Colors.transparent),
              columnSpacing: 18.0,
              horizontalMargin: 12.0,
              columns: const [
                DataColumn(label: Text('Period', style: TextStyle(color: StarkColors.cyan, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Rev (₹ Cr)', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('EBITDA %', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('PAT (₹ Cr)', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Net %', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('ROCE %', style: TextStyle(color: StarkColors.emerald, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Asset Turn', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('OCF (₹ Cr)', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Capex (₹ Cr)', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('FCF (₹ Cr)', style: TextStyle(color: StarkColors.cyan, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('OCF/PAT', style: TextStyle(color: StarkColors.amber, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Debtor D', style: TextStyle(color: StarkColors.textSecondary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('CCC Days', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Debt (₹ Cr)', style: TextStyle(color: StarkColors.crimson, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Net Debt/EBITDA', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
                DataColumn(label: Text('Int Coverage', style: TextStyle(color: StarkColors.textPrimary, fontWeight: FontWeight.bold))),
              ],
              rows: data.periods.map((p) {
                final isLatest = p.period.contains('Latest') || p.period.contains('TTM');
                final textStyle = TextStyle(
                  color: isLatest ? StarkColors.cyan : StarkColors.textPrimary,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: isLatest ? FontWeight.bold : FontWeight.normal,
                );

                return DataRow(
                  cells: [
                    DataCell(Text(p.period, style: textStyle.copyWith(fontWeight: FontWeight.bold))),
                    DataCell(Text(IndianCurrencyFormatter.formatCrore(p.revenueCr, fractionDigits: 0), style: textStyle)),
                    DataCell(Text('${p.ebitdaMarginPercent}%', style: textStyle)),
                    DataCell(Text(IndianCurrencyFormatter.formatCrore(p.patCr, fractionDigits: 0), style: textStyle)),
                    DataCell(Text('${p.netMarginPercent}%', style: textStyle)),
                    DataCell(Text('${p.rocePercent}%', style: textStyle.copyWith(color: StarkColors.emerald))),
                    DataCell(Text('${p.assetTurnover}x', style: textStyle)),
                    DataCell(Text('${p.ocfCr.toInt()}', style: textStyle)),
                    DataCell(Text('${p.capexCr.toInt()}', style: textStyle)),
                    DataCell(Text('${p.fcfCr.toInt()}', style: textStyle.copyWith(color: StarkColors.cyan, fontWeight: FontWeight.bold))),
                    DataCell(Text('${p.ocfPatRatio.toStringAsFixed(1)}x', style: textStyle.copyWith(color: StarkColors.amber))),
                    DataCell(Text('${p.debtorDays}', style: textStyle)),
                    DataCell(Text('${p.cccDays}', style: textStyle)),
                    DataCell(Text('${p.totalDebtCr.toInt()}', style: textStyle.copyWith(color: StarkColors.crimson))),
                    DataCell(Text('${p.netDebtEbitda}x', style: textStyle)),
                    DataCell(Text('${p.interestCoverage}x', style: textStyle)),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: color.withOpacity(0.6)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
