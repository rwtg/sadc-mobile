import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../themes/app_colors.dart';
import '../widgets/labeled_field.dart';
import '../widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _clinicCtrl = TextEditingController();
  final _crmCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _pass2Ctrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _clinicCtrl.dispose();
    _crmCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _pass2Ctrl.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null;

  String? _email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Informe o e-mail';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'E-mail inválido';
  }

  String? _pass(String? v) {
    if (v == null || v.isEmpty) return 'Informe a senha';
    if (v.length < 6) return 'Mínimo de 6 caracteres';
    return null;
  }

  String? _pass2(String? v) {
    if (v != _passCtrl.text) return 'As senhas não coincidem';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final err = await AuthService.instance.register(
      name: _nameCtrl.text,
      clinic: _clinicCtrl.text,
      email: _emailCtrl.text,
      password: _passCtrl.text,
      crm: _crmCtrl.text,
    );

    if (!mounted) return;
    setState(() => _loading = false);

    if (err != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(err)));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Conta criada! Faça login.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar conta'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                LabeledField(
                  label: 'Nome completo',
                  hint: 'Dr. João Silva',
                  controller: _nameCtrl,
                  validator: _required,
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'Clínica',
                  hint: 'Clínica Exemplo',
                  controller: _clinicCtrl,
                  validator: _required,
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'CRM / Registro profissional',
                  hint: 'PE 123456',
                  controller: _crmCtrl,
                  validator: _required,
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'E-mail',
                  hint: 'nome@clinica.com',
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailCtrl,
                  validator: _email,
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'Senha',
                  hint: '••••••••',
                  obscure: true,
                  controller: _passCtrl,
                  validator: _pass,
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'Confirmar senha',
                  hint: '••••••••',
                  obscure: true,
                  controller: _pass2Ctrl,
                  validator: _pass2,
                ),
                const SizedBox(height: 28),
                _loading
                    ? const CircularProgressIndicator()
                    : PrimaryButton(text: 'Criar conta', onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
