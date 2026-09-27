import 'package:flutter/material.dart';
import '../../../../domain/models/agent_chat_message.dart';
import '../../../core/theme/stark_theme.dart';

class ChatBubble extends StatelessWidget {
  final AgentChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isBoss = message.sender == AgentSender.boss;
    final senderColor = _getSenderColor(message.sender);

    return Align(
      alignment: isBoss ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isBoss ? StarkColors.surfaceElevated : StarkColors.surface,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isBoss ? StarkColors.border : senderColor.withOpacity(0.5),
            width: isBoss ? 1.0 : 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isBoss ? Icons.person : Icons.memory,
                  color: senderColor,
                  size: 14,
                ),
                const SizedBox(width: 6),
                Text(
                  message.sender.displayName.toUpperCase(),
                  style: TextStyle(
                    color: senderColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${message.timestamp.hour.toString().padLeft(2, '0')}:${message.timestamp.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: StarkColors.textMuted, fontSize: 10),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              message.message,
              style: TextStyle(
                color: isBoss ? StarkColors.textPrimary : StarkColors.textPrimary,
                fontSize: 13,
                height: 1.4,
                fontFamily: isBoss ? null : 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getSenderColor(AgentSender sender) {
    return switch (sender) {
      AgentSender.boss => StarkColors.textPrimary,
      AgentSender.friday => StarkColors.cyan,
      AgentSender.cis => StarkColors.amber,
      AgentSender.forensicLead || AgentSender.forensicAuditor => StarkColors.crimson,
      AgentSender.quantLead || AgentSender.peerAnalyst => StarkColors.purple,
      AgentSender.financialModeler => StarkColors.emerald,
      AgentSender.concallScraper => StarkColors.amber,
    };
  }
}
