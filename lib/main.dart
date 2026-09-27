import 'package:flutter/material.dart';
import 'core/theme/stark_theme.dart';
import 'core/di/service_locator.dart';
import 'ui/features/research_desk/views/research_desk_screen.dart';
import 'ui/features/advisor_hud/views/advisor_hud_screen.dart';
import 'ui/features/research_desk/view_models/research_desk_view_model.dart';
import 'ui/features/advisor_hud/view_models/advisor_hud_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ServiceLocator.init();
  runApp(const IndianEquityMultiAgentApp());
}

class IndianEquityMultiAgentApp extends StatelessWidget {
  const IndianEquityMultiAgentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'F.R.I.D.A.Y. // Indian Equity Research Multi-Agent Engine',
      debugShowCheckedModeBanner: false,
      theme: StarkTheme.darkTheme,
      home: const MainDeskNavigationContainer(),
    );
  }
}

class MainDeskNavigationContainer extends StatefulWidget {
  const MainDeskNavigationContainer({super.key});

  @override
  State<MainDeskNavigationContainer> createState() => _MainDeskNavigationContainerState();
}

class _MainDeskNavigationContainerState extends State<MainDeskNavigationContainer> {
  int _currentIndex = 0;
  late final ResearchDeskViewModel _researchDeskVm;
  late final AdvisorHudViewModel _advisorHudVm;

  @override
  void initState() {
    super.initState();
    _researchDeskVm = ServiceLocator.createResearchDeskViewModel();
    _advisorHudVm = ServiceLocator.createAdvisorHudViewModel();
  }

  @override
  void dispose() {
    _researchDeskVm.dispose();
    _advisorHudVm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      ResearchDeskScreen(viewModel: _researchDeskVm),
      AdvisorHudScreen(
        viewModel: _advisorHudVm,
        activeSymbol: _researchDeskVm.activeSymbol,
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: StarkColors.surface,
          border: Border(top: BorderSide(color: StarkColors.border)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedItemColor: StarkColors.cyan,
          unselectedItemColor: StarkColors.textMuted,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.analytics),
              label: '8-Agent Research Desk',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.psychology),
              label: 'F.R.I.D.A.Y. Advisor HUD',
            ),
          ],
        ),
      ),
    );
  }
}
