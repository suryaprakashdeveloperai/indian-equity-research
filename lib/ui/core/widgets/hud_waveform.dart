import 'package:flutter/material.dart';
import '../../core/theme/stark_theme.dart';

class HudWaveform extends StatefulWidget {
  final bool isPlaying;

  const HudWaveform({super.key, required this.isPlaying});

  @override
  State<HudWaveform> createState() => _HudWaveformState();
}

class _HudWaveformState extends State<HudWaveform> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isPlaying) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          12,
          (index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            width: 3.0,
            height: 6.0,
            decoration: BoxDecoration(
              color: StarkColors.textMuted,
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(12, (index) {
            final sinVal = (index / 12.0) * 3.14159;
            final dynamicHeight = 6.0 + 18.0 * (_controller.value * (1.0 - (index % 3) * 0.2)).clamp(0.2, 1.0);
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.0),
              width: 3.0,
              height: dynamicHeight,
              decoration: BoxDecoration(
                color: index % 2 == 0 ? StarkColors.cyan : StarkColors.amber,
                borderRadius: BorderRadius.circular(2.0),
              ),
            );
          }),
        );
      },
    );
  }
}
