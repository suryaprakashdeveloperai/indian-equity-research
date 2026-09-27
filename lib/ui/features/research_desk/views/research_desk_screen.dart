import 'package:flutter/material.dart';
import '../../../core/theme/stark_theme.dart';
import '../view_models/research_desk_view_model.dart';
import 'part_a_verbal_briefing_view.dart';
import 'part_b_institutional_report_view.dart';

class ResearchDeskScreen extends StatefulWidget {
  final ResearchDeskViewModel viewModel;

  const ResearchDeskScreen({super.key, required this.viewModel});

  @override
  State<ResearchDeskScreen> createState() => _ResearchDeskScreenState();
}

class _ResearchDeskScreenState extends State<ResearchDeskScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _searchController.text = widget.viewModel.activeSymbol;

    // Trigger initial analysis
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.viewModel.report == null) {
        widget.viewModel.analyzeTicker(widget.viewModel.activeSymbol);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.viewModel,
      builder: (context, _) {
        final vm = widget.viewModel;

        return Scaffold(
          backgroundColor: StarkColors.background,
          appBar: AppBar(
            backgroundColor: StarkColors.surface,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6.0),
                  decoration: BoxDecoration(
                    color: StarkColors.cyan.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: StarkColors.cyan),
                  ),
                  child: const Icon(Icons.hub, color: StarkColors.cyan, size: 20),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'F.R.I.D.A.Y. // 8-AGENT RESEARCH DESK',
                      style: TextStyle(
                        color: StarkColors.cyan,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                    Text(
                      'Institutional Indian Equity Intelligence (NSE/BSE)',
                      style: TextStyle(color: StarkColors.textSecondary, fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(104.0),
              child: Column(
                children: [
                  // Ticker Search & Presets
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: StarkColors.surfaceElevated,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: StarkColors.border),
                            ),
                            child: TextField(
                              controller: _searchController,
                              style: const TextStyle(color: StarkColors.textPrimary, fontSize: 13, fontFamily: 'monospace'),
                              textCapitalization: TextCapitalization.characters,
                              decoration: const InputDecoration(
                                hintText: 'Enter NSE/BSE Symbol (e.g. DIXON, TATAMOTORS, HAL)...',
                                hintStyle: TextStyle(color: StarkColors.textMuted, fontSize: 12),
                                prefixIcon: Icon(Icons.search, color: StarkColors.cyan, size: 18),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                              ),
                              onSubmitted: (val) => vm.analyzeTicker(val),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: vm.isLoading ? null : () => vm.analyzeTicker(_searchController.text),
                          icon: const Icon(Icons.play_arrow, size: 16),
                          label: const Text('Analyze'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: StarkColors.cyan,
                            foregroundColor: Colors.black,
                            textStyle: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 8),
                        _buildPresetChip('DIXON', vm),
                        const SizedBox(width: 4),
                        _buildPresetChip('TATAMOTORS', vm),
                        const SizedBox(width: 4),
                        _buildPresetChip('HAL', vm),
                      ],
                    ),
                  ),

                  // Pipeline Execution Status HUD
                  Container(
                    height: 24,
                    width: double.infinity,
                    color: Colors.black.withOpacity(0.5),
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        if (vm.isLoading) ...[
                          const SizedBox(
                            width: 12,
                            height: 12,
                            child: CircularProgressIndicator(strokeWidth: 2.0, color: StarkColors.cyan),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          'STAGE: ${vm.currentStage.toUpperCase()}',
                          style: TextStyle(
                            color: vm.isLoading ? StarkColors.cyan : StarkColors.emerald,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tabs
                  TabBar(
                    controller: _tabController,
                    indicatorColor: StarkColors.cyan,
                    labelColor: StarkColors.cyan,
                    unselectedLabelColor: StarkColors.textMuted,
                    tabs: const [
                      Tab(text: 'PART A: VERBAL BRIEFING'),
                      Tab(text: 'PART B: INSTITUTIONAL REPORT (8-AGENT)'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          body: vm.isLoading
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: StarkColors.cyan),
                      const SizedBox(height: 16),
                      Text(
                        vm.currentStage,
                        style: const TextStyle(color: StarkColors.cyan, fontFamily: 'monospace', fontSize: 13),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Auditing official filings, concalls, and forensic statements...',
                        style: TextStyle(color: StarkColors.textMuted, fontSize: 11),
                      ),
                    ],
                  ),
                )
              : vm.errorMessage != null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: StarkColors.crimson, size: 40),
                          const SizedBox(height: 12),
                          Text(
                            vm.errorMessage!,
                            style: const TextStyle(color: StarkColors.crimson),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => vm.analyzeTicker(vm.activeSymbol),
                            child: const Text('Retry Analysis'),
                          ),
                        ],
                      ),
                    )
                  : vm.report == null
                      ? const Center(child: Text('Enter a ticker to begin research.'))
                      : TabBarView(
                          controller: _tabController,
                          children: [
                            PartAVerbalBriefingView(briefing: vm.report!.briefing),
                            PartBInstitutionalReportView(report: vm.report!),
                          ],
                        ),
        );
      },
    );
  }

  Widget _buildPresetChip(String ticker, ResearchDeskViewModel vm) {
    final isSelected = vm.activeSymbol == ticker;
    return InkWell(
      onTap: () {
        _searchController.text = ticker;
        vm.analyzeTicker(ticker);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: isSelected ? StarkColors.cyan.withOpacity(0.2) : StarkColors.surfaceElevated,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: isSelected ? StarkColors.cyan : StarkColors.border),
        ),
        child: Text(
          ticker,
          style: TextStyle(
            color: isSelected ? StarkColors.cyan : StarkColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}
