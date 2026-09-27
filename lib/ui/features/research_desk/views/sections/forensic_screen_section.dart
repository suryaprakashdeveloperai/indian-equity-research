import 'package:flutter/material.dart';
import '../../../../../domain/models/forensic_screen.dart';
import '../../../../../core/theme/stark_theme.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../core/widgets/metric_badge.dart';
import '../../../../core/widgets/red_flag_indicator.dart';

class ForensicScreenSection extends StatelessWidget {
  final ForensicScreen forensics;

  const ForensicScreenSection({super.key, required this.forensics});

  @override
  Widget build(BuildContext context) {
    final isClean = forensics.checklist.redFlagCount == 0;
    final riskColor = isClean ? StarkColors.emerald : StarkColors.crimson;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              '4. FORENSIC ACCOUNTING & GOVERNANCE SCREEN [AGENT 5]',
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
                color: riskColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: riskColor),
              ),
              child: Row(
                children: [
                  Icon(isClean ? Icons.verified : Icons.warning, color: riskColor, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    forensics.riskLevel.label.toUpperCase(),
                    style: TextStyle(color: riskColor, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Key Forensic Metrics Badges
        Row(
          children: [
            Expanded(
              child: MetricBadge(
                label: 'Promoter Holding',
                value: '${forensics.promoterHoldingPercent}%',
                subtitle: forensics.insiderTransactionPattern,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MetricBadge(
                label: 'Pledged Shares',
                value: '${forensics.pledgedSharesPercent}%',
                valueColor: forensics.pledgedSharesPercent > 10.0 ? StarkColors.crimson : StarkColors.emerald,
                subtitle: forensics.pledgedSharesPercent == 0 ? 'Pristine (Zero Pledge)' : 'Caution',
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: MetricBadge(
                label: 'Auditor Stability',
                value: forensics.auditorFirm,
                subtitle: forensics.hasAuditorQualifications ? 'Qualified Opinion' : 'Unmodified Clean',
                valueColor: forensics.hasAuditorQualifications ? StarkColors.crimson : StarkColors.cyan,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),

        // Red Flag Checklist
        const Text(
          'RED FLAG FORENSIC AUDIT CHECKLIST',
          style: TextStyle(color: StarkColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        RedFlagIndicator(
          label: 'Promoter pledge > 10%?',
          isFlagged: forensics.checklist.promoterPledgeAbove10,
          detail: forensics.checklist.detailsPledge,
        ),
        RedFlagIndicator(
          label: 'OCF significantly lower than PAT over 3 years?',
          isFlagged: forensics.checklist.ocfLowerThanPat3Yr,
          detail: forensics.checklist.detailsCashFlow,
        ),
        RedFlagIndicator(
          label: 'Receivables growing disproportionately to revenue?',
          isFlagged: forensics.checklist.receivablesGrowthDivergence,
          detail: forensics.checklist.detailsReceivables,
        ),
        RedFlagIndicator(
          label: 'Pending NCLT, GST, or material litigation?',
          isFlagged: forensics.checklist.pendingNcltOrMaterialLitigation,
          detail: forensics.checklist.detailsLitigation,
        ),
        const SizedBox(height: 10),

        // RPT Audit Card
        GlassCard(
          backgroundColor: StarkColors.surfaceElevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.account_balance, color: StarkColors.amber, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Related-Party Transactions (RPT) & Subs Lending Audit',
                    style: TextStyle(color: StarkColors.amber, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                forensics.relatedPartyTransactionsAudit,
                style: const TextStyle(color: StarkColors.textPrimary, fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
