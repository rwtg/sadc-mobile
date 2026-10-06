import 'package:flutter/material.dart';
import '../models/user_info.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import 'history_screen.dart';
import 'tabs/conta_tab.dart';
import 'tabs/home_tab.dart';
import 'tabs/licenca_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _index = 0;

  static const _titles = ['Visão geral', 'Histórico', 'Licença', 'Conta'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.field,
        surfaceTintColor: AppColors.field,
        elevation: 0,
        toolbarHeight: 64,
        titleSpacing: 16,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(mockUser.clinic, style: AppTextStyles.appBarTitle),
            const SizedBox(height: 2),
            const Row(
              children: [
                Icon(Icons.circle, size: 8, color: AppColors.green),
                SizedBox(width: 6),
                Text('Conectado ao Servidor',
                    style: TextStyle(fontSize: 12, color: AppColors.green)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          if (_index != 0)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(_titles[_index],
                    style: AppTextStyles.title.copyWith(fontSize: 22)),
              ),
            ),
          Expanded(
            child: IndexedStack(
              index: _index,
              children: const [
                HomeTab(),
                HistoryList(),
                LicencaTab(),
                ContaTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        backgroundColor: Colors.white,
        indicatorColor: AppColors.greenLight,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.green),
              label: 'Início'),
          NavigationDestination(
              icon: Icon(Icons.history),
              selectedIcon: Icon(Icons.history, color: AppColors.green),
              label: 'Histórico'),
          NavigationDestination(
              icon: Icon(Icons.verified_user_outlined),
              selectedIcon: Icon(Icons.verified_user, color: AppColors.green),
              label: 'Licença'),
          NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.green),
              label: 'Conta'),
        ],
      ),
    );
  }
}
