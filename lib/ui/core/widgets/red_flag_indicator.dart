import 'package:flutter/material.dart';
import '../../core/theme/stark_theme.dart';

class RedFlagIndicator extends StatelessWidget {
  final String label;
  final bool isFlagged;
  final String detail;

  const RedFlagIndicator({
    super.key,
    required this.label,
    required this.isFlagged,
    required this.detail,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isFlagged ? StarkColors.crimson : StarkColors.emerald;
    final statusText = isFlagged ? 'RED FLAG' : 'CLEAN';

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: StarkColors.surfaceElevated,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: isFlagged ? StarkColors.crimson.withOpacity(0.5) : StarkColors.border,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: statusColor),
            ),
            child: Text(
              statusText,
              style: TextStyle(
                color: statusColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: StarkColors.textPrimary,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  style: const TextStyle(
                    color: StarkColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
