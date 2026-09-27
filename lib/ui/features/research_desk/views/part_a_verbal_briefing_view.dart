import 'package:flutter/material.dart';
import '../../../../domain/models/verbal_briefing.dart';
import '../../../core/theme/stark_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/hud_waveform.dart';

class PartAVerbalBriefingView extends StatefulWidget {
  final VerbalBriefing briefing;

  const PartAVerbalBriefingView({super.key, required this.briefing});

  @override
  State<PartAVerbalBriefingView> createState() => _PartAVerbalBriefingViewState();
}

class _PartAVerbalBriefingViewState extends State<PartAVerbalBriefingView> {
  bool _isPlayingVoice = false;

  @override
  Widget build(BuildContext context) {
    final b = widget.briefing;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Executive Audio Header HUD
          GlassCard(
            borderColor: StarkColors.cyan,
            backgroundColor: StarkColors.surfaceElevated,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: StarkColors.cyan.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.record_voice_over, color: StarkColors.cyan, size: 24),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PART A: F.R.I.D.A.Y. VERBAL BRIEFING',
                        style: TextStyle(
                          color: StarkColors.cyan,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Direct Liaison to the Principal | ${b.companyName}',
                        style: const TextStyle(
                          color: StarkColors.textPrimary,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                HudWaveform(isPlaying: _isPlayingVoice),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _isPlayingVoice = !_isPlayingVoice;
                    });
                  },
                  icon: Icon(_isPlayingVoice ? Icons.pause : Icons.volume_up, size: 16),
                  label: Text(_isPlayingVoice ? 'Pause' : 'Brief Boss'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: StarkColors.cyan,
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // 1. The Setup
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderBadge('THE SETUP', Icons.shield, StarkColors.cyan),
                const SizedBox(height: 8),
                Text(
                  b.setup,
                  style: const TextStyle(
                    color: StarkColors.textPrimary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 2. The Alpha Catalyst
          GlassCard(
            borderColor: StarkColors.emerald.withOpacity(0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderBadge('THE ALPHA CATALYST (ASYMMETRIC UPSIDE)', Icons.trending_up, StarkColors.emerald),
                const SizedBox(height: 8),
                Text(
                  b.alphaCatalyst,
                  style: const TextStyle(
                    color: StarkColors.textPrimary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 3. The Landmine
          GlassCard(
            borderColor: StarkColors.crimson.withOpacity(0.4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderBadge('THE LANDMINE (CRITICAL THESIS RISK)', Icons.warning_amber_rounded, StarkColors.crimson),
                const SizedBox(height: 8),
                Text(
                  b.landmine,
                  style: const TextStyle(
                    color: StarkColors.textPrimary,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // 4. The Chief's Verdict (Agent 1)
          GlassCard(
            borderColor: StarkColors.amber,
            backgroundColor: StarkColors.surfaceElevated,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildHeaderBadge('THE CHIEF\'S VERDICT [AGENT 1: CIS]', Icons.gavel, StarkColors.amber),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                      decoration: BoxDecoration(
                        color: StarkColors.emerald.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: StarkColors.emerald),
                      ),
                      child: Text(
                        b.verdict.label.toUpperCase(),
                        style: const TextStyle(
                          color: StarkColors.emerald,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.not_interested, color: StarkColors.crimson, size: 16),
                    const SizedBox(width: 6),
                    const Text(
                      'Exact Invalidation Trigger: ',
                      style: TextStyle(color: StarkColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    Expanded(
                      child: Text(
                        '${b.invalidationTrigger} (Stop: ₹ ${b.invalidationPrice})',
                        style: const TextStyle(
                          color: StarkColors.crimson,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // 5. Audio Sign-Off Dialogue
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.4),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: StarkColors.border),
            ),
            child: Row(
              children: [
                const Icon(Icons.format_quote, color: StarkColors.cyan, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '"${b.audioSignOff}"',
                    style: const TextStyle(
                      color: StarkColors.cyan,
                      fontStyle: FontStyle.italic,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderBadge(String label, IconData icon, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}
