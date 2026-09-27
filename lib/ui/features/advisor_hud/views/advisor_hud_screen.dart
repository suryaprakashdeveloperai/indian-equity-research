import 'package:flutter/material.dart';
import '../../../core/theme/stark_theme.dart';
import '../view_models/advisor_hud_view_model.dart';
import 'chat_bubble.dart';

class AdvisorHudScreen extends StatefulWidget {
  final AdvisorHudViewModel viewModel;
  final String activeSymbol;

  const AdvisorHudScreen({
    super.key,
    required this.viewModel,
    required this.activeSymbol,
  });

  @override
  State<AdvisorHudScreen> createState() => _AdvisorHudScreenState();
}

class _AdvisorHudScreenState extends State<AdvisorHudScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final vm = widget.viewModel;
        _scrollToBottom();

        return Scaffold(
          backgroundColor: StarkColors.background,
          appBar: AppBar(
            backgroundColor: StarkColors.surface,
            elevation: 0,
            title: Row(
              children: [
                const Icon(Icons.psychology, color: StarkColors.cyan, size: 22),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'PART C: INTERACTIVE ADVISOR MODE // ${widget.activeSymbol}',
                      style: const TextStyle(
                        color: StarkColors.cyan,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const Text(
                      'Voice & Tactical Console to F.R.I.D.A.Y. & Sub-Agents',
                      style: TextStyle(color: StarkColors.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh, color: StarkColors.textMuted),
                tooltip: 'Reset Dialogue',
                onPressed: () => vm.clearChat(),
              ),
            ],
          ),
          body: Column(
            children: [
              // Quick Sub-Agent Dispatch Chips
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                color: StarkColors.surfaceElevated,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const Text(
                        'DIRECT ORDERS: ',
                        style: TextStyle(color: StarkColors.textMuted, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 6),
                      _buildActionChip(
                        label: 'Agent 5: Stress-Test RPTs',
                        color: StarkColors.crimson,
                        onTap: () => vm.sendUserPrompt(
                          'F.R.I.D.A.Y., tell Agent 5 to stress-test their related-party transactions.',
                          widget.activeSymbol,
                        ),
                      ),
                      const SizedBox(width: 6),
                      _buildActionChip(
                        label: 'Agent 7: Draft 3 Concall Questions',
                        color: StarkColors.amber,
                        onTap: () => vm.sendUserPrompt(
                          'Have Agent 7 draft 3 challenging questions for the management in the upcoming earnings concall.',
                          widget.activeSymbol,
                        ),
                      ),
                      const SizedBox(width: 6),
                      _buildActionChip(
                        label: 'Agent 6: Simulate -200 bps Margin',
                        color: StarkColors.emerald,
                        onTap: () => vm.runMarginSimulation(widget.activeSymbol, 200.0),
                      ),
                    ],
                  ),
                ),
              ),

              // Chat Message List
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16.0),
                  itemCount: vm.messages.length,
                  itemBuilder: (context, index) {
                    final msg = vm.messages[index];
                    return ChatBubble(message: msg);
                  },
                ),
              ),

              if (vm.isProcessing)
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  color: StarkColors.surfaceElevated,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2, color: StarkColors.cyan)),
                      SizedBox(width: 8),
                      Text(
                        'F.R.I.D.A.Y. is coordinating with the desk workers...',
                        style: TextStyle(color: StarkColors.cyan, fontSize: 11, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),

              // Input Bar
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: const BoxDecoration(
                  color: StarkColors.surface,
                  border: Border(top: BorderSide(color: StarkColors.border)),
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14.0),
                          decoration: BoxDecoration(
                            color: StarkColors.surfaceElevated,
                            borderRadius: BorderRadius.circular(24.0),
                            border: Border.all(color: StarkColors.border),
                          ),
                          child: TextField(
                            controller: _inputController,
                            style: const TextStyle(color: StarkColors.textPrimary, fontSize: 13),
                            decoration: const InputDecoration(
                              hintText: 'Address F.R.I.D.A.Y. directly (e.g. "Simulate 200 bps drop", "Audit promoter pledging")...',
                              hintStyle: TextStyle(color: StarkColors.textMuted, fontSize: 12),
                              border: InputBorder.none,
                            ),
                            onSubmitted: (val) {
                              if (val.trim().isNotEmpty) {
                                vm.sendUserPrompt(val, widget.activeSymbol);
                                _inputController.clear();
                              }
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: () {
                          if (_inputController.text.trim().isNotEmpty) {
                            vm.sendUserPrompt(_inputController.text, widget.activeSymbol);
                            _inputController.clear();
                          }
                        },
                        icon: const Icon(Icons.send, color: StarkColors.cyan),
                        style: IconButton.styleFrom(
                          backgroundColor: StarkColors.cyan.withOpacity(0.15),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildActionChip({required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Text(
          label,
          style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
