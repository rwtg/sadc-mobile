import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'history_screen.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardScreen(),
    HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F6),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(
            child: pages[selectedIndex],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 220,
      color: const Color(0xFF176B3A),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            const Text(
              'SADC',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'CLÍNICA TEST',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 11,
              ),
            ),
            const SizedBox(height: 35),
            _menuItem(
              icon: Icons.dashboard_outlined,
              title: 'Painel',
              index: 0,
            ),
            _menuItem(
              icon: Icons.history,
              title: 'Histórico',
              index: 1,
            ),
            _menuItem(
              icon: Icons.badge_outlined,
              title: 'Licença',
              index: 2,
            ),
            _menuItem(
              icon: Icons.people_outline,
              title: 'Usuários',
              index: 3,
            ),
            _menuItem(
              icon: Icons.devices_outlined,
              title: 'Dispositivos',
              index: 4,
            ),
            _menuItem(
              icon: Icons.person_outline,
              title: 'Meu perfil',
              index: 5,
            ),
            const Spacer(),
            _menuItem(
              icon: Icons.logout,
              title: 'Sair',
              index: 6,
              logout: true,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required int index,
    bool logout = false,
  }) {
    final bool selected = selectedIndex == index;

    return InkWell(
      onTap: () {
        if (logout) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const Scaffold(
                body: Center(
                  child: Text('Login'),
                ),
              ),
            ),
          );
          return;
        }

        if (index > 1) {
          return;
        }

        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 2,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 19,
              color: logout ? Colors.redAccent.shade100 : Colors.white,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: logout ? Colors.redAccent.shade100 : Colors.white,
                fontSize: 13,
                fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
