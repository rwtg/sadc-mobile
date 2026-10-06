import 'package:flutter/material.dart';
import 'services/auth_service.dart';
import 'themes/app_theme.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AuthService.instance.debugReset(); // apaga contas E chaves
  debugPrint('>>> RESET FEITO. Contas e chaves apagadas.');
  runApp(const SadcApp());
}

class SadcApp extends StatelessWidget {
  const SadcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SADC',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: const LoginScreen(),
    );
  }
}
