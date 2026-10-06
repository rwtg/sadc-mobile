import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../widgets/labeled_field.dart';
import '../widgets/primary_button.dart';

class AcquireAccessScreen extends StatefulWidget {
  const AcquireAccessScreen({super.key});

  @override
  State<AcquireAccessScreen> createState() => _AcquireAccessScreenState();
}

class _AcquireAccessScreenState extends State<AcquireAccessScreen> {
  final _formKey = GlobalKey<FormState>();
  final _clinicCtrl = TextEditingController();
  final _crmCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  bool _sending = false;
  String? _generatedKey;

  @override
  void dispose() {
    _clinicCtrl.dispose();
    _crmCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    super.dispose();
  }

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null;

  String? _email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Informe o e-mail';
    final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(v.trim());
    return ok ? null : 'E-mail inválido';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _sending = true);

    final key = await AuthService.instance.requestKey();

    if (!mounted) return;
    setState(() {
      _sending = false;
      _generatedKey = key;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adquirir acesso'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.green,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: _generatedKey != null
              ? _buildSuccess(_generatedKey!)
              : _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const Text(
            'Solicite a chave de acesso da sua clínica',
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle,
          ),
          const SizedBox(height: 28),
          LabeledField(
            label: 'Nome da clínica',
            hint: 'Clínica Exemplo',
            controller: _clinicCtrl,
            validator: _required,
          ),
          const SizedBox(height: 20),
          LabeledField(
            label: 'CRM / Registro profissional',
            hint: '000000/PE',
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
            label: 'Telefone / WhatsApp',
            hint: '(81) 90000-0000',
            keyboardType: TextInputType.phone,
            controller: _phoneCtrl,
            validator: _required,
          ),
          const SizedBox(height: 28),
          _sending
              ? const CircularProgressIndicator()
              : PrimaryButton(text: 'Solicitar chave', onPressed: _submit),
        ],
      ),
    );
  }

  Widget _buildSuccess(String key) {
    return Column(
      children: [
        const Icon(Icons.check_circle, color: AppColors.green, size: 64),
        const SizedBox(height: 16),
        const Text(
          'Chave gerada com sucesso',
          style: AppTextStyles.sectionTitle,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          'Guarde esta chave. Você vai usá-la no login.',
          textAlign: TextAlign.center,
          style: AppTextStyles.small,
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.greenLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.green),
          ),
          child: SelectableText(
            key,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              letterSpacing: 2,
              color: AppColors.green,
            ),
          ),
        ),
        const SizedBox(height: 28),
        PrimaryButton(
          text: 'Voltar ao login',
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
