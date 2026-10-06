import 'package:flutter/material.dart';
import '../../models/user_info.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../../widgets/info_row.dart';
import '../../widgets/outline_button_green.dart';
import '../../widgets/section_card.dart';
import '../../widgets/status_chip.dart';
import '../login_screen.dart';

class ContaTab extends StatefulWidget {
  const ContaTab({super.key});

  @override
  State<ContaTab> createState() => _ContaTabState();
}

class _ContaTabState extends State<ContaTab> {
  bool _alertHighRisk = true;
  bool _alertLicense = true;

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final u = mockUser;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionCard(
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.greenLight,
                child: Text(u.initials,
                    style: const TextStyle(
                        color: AppColors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w800)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(u.name, style: AppTextStyles.sectionTitle),
                    const SizedBox(height: 4),
                    StatusChip(
                      label: u.role,
                      bg: AppColors.greenLight,
                      fg: AppColors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Meus dados',
          child: Column(
            children: [
              InfoRow(label: 'Clínica', value: u.clinic),
              InfoRow(label: 'E-mail', value: u.email),
              InfoRow(label: 'CRM', value: u.crm),
            ],
          ),
        ),
        SectionCard(
          title: 'Notificações',
          child: Column(
            children: [
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.green,
                title: const Text('Alertar sobre risco alto',
                    style: AppTextStyles.input),
                value: _alertHighRisk,
                onChanged: (v) => setState(() => _alertHighRisk = v),
              ),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                activeColor: AppColors.green,
                title: const Text('Avisar sobre vencimento da licença',
                    style: AppTextStyles.input),
                value: _alertLicense,
                onChanged: (v) => setState(() => _alertLicense = v),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Sincronização',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoRow(label: 'Status', value: 'Sincronizado'),
              const InfoRow(
                  label: 'Última sincronização', value: 'Hoje, 08:54'),
              const SizedBox(height: 8),
              OutlineButtonGreen(
                text: 'Sincronizar agora',
                onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Dados atualizados.')),
                ),
              ),
            ],
          ),
        ),
        SectionCard(
          title: 'Sobre o app',
          child: const Column(
            children: [
              InfoRow(label: 'Versão', value: '1.0.0'),
              InfoRow(label: 'Acesso', value: 'Profissionais de saúde'),
              InfoRow(label: 'Função', value: 'Consulta e acompanhamento'),
            ],
          ),
        ),
        SectionCard(
          title: 'Como funciona',
          child: const Text(
            'As análises são processadas no computador da clínica. '
            'Este aplicativo serve para você consultar resultados, '
            'acompanhar a licença, gerenciar dispositivos autorizados '
            'e receber alertas — de qualquer lugar.',
            style: AppTextStyles.body,
          ),
        ),
        OutlinedButton.icon(
          onPressed: _logout,
          icon: const Icon(Icons.logout),
          label: const Text('Sair da conta', style: AppTextStyles.button),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.red,
            side: const BorderSide(color: AppColors.red),
            minimumSize: const Size.fromHeight(52),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
