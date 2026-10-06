import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/review_store.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../widgets/labeled_field.dart';
import '../widgets/primary_button.dart';
import '../widgets/outline_button_green.dart';
import '../widgets/link_text.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';
import 'acquire_access_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _keyCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _keyCtrl.dispose();
    super.dispose();
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Informe o e-mail';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'E-mail inválido';
  }

  String? _validatePass(String? v) {
    if (v == null || v.isEmpty) return 'Informe a senha';
    if (v.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  String? _validateKey(String? v) {
    if (v == null || v.trim().isEmpty) return 'Informe a chave de acesso';
    final ok = RegExp(r'^SADC-[A-Z0-9]{4}-[A-Z0-9]{4}$')
        .hasMatch(v.trim().toUpperCase());
    return ok ? null : 'Formato esperado: SADC-XXXX-XXXX';
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _loading = true);

    final err = await AuthService.instance.login(
      email: _emailCtrl.text,
      password: _passCtrl.text,
      accessKey: _keyCtrl.text,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }

    await ReviewStore.instance.load();

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(
                    color: AppColors.greenLight,
                    shape: BoxShape.circle,
                  ),
                  child:
                      const Icon(Icons.add, color: AppColors.green, size: 34),
                ),
                const SizedBox(height: 20),
                const Text('SADC', style: AppTextStyles.logo),
                const SizedBox(height: 6),
                const Text(
                  'Acompanhe suas análises\ne a licença da clínica',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitle,
                ),
                const SizedBox(height: 32),
                LabeledField(
                  label: 'E-mail',
                  hint: 'nome@clinica.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailCtrl,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'Senha',
                  hint: '••••••••',
                  obscure: true,
                  controller: _passCtrl,
                  validator: _validatePass,
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'Chave de acesso',
                  hint: 'SADC-XXXX-XXXX',
                  controller: _keyCtrl,
                  validator: _validateKey,
                ),
                const SizedBox(height: 28),
                _loading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(text: 'Entrar', onPressed: _login),
                const SizedBox(height: 12),
                const Text(
                  'As análises são processadas\nno computador da clínica.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.small,
                ),
                const SizedBox(height: 20),
                LinkText(
                  prefix: 'Ainda não tem uma chave?',
                  link: 'Adquirir acesso',
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const AcquireAccessScreen()),
                  ),
                ),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.border)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('ou', style: AppTextStyles.small),
                    ),
                    Expanded(child: Divider(color: AppColors.border)),
                  ],
                ),
                const SizedBox(height: 14),
                OutlineButtonGreen(
                  text: 'Criar conta',
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Acesso exclusivo para profissionais de saúde',
                  style: AppTextStyles.small,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
