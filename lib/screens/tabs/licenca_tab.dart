import 'package:flutter/material.dart';
import '../../models/license_info.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../../widgets/alert_banner.dart';
import '../../widgets/info_row.dart';
import '../../widgets/outline_button_green.dart';
import '../../widgets/section_card.dart';
import '../../widgets/status_chip.dart';

class LicencaTab extends StatelessWidget {
  const LicencaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final lic = mockLicense;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                        color: AppColors.greenLight, shape: BoxShape.circle),
                    child:
                        const Icon(Icons.verified_user, color: AppColors.green),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text('Plano ${lic.plan}',
                        style: AppTextStyles.sectionTitle),
                  ),
                  StatusChip(
                    label: lic.statusLabel,
                    bg: lic.expired ? AppColors.redBg : AppColors.greenLight,
                    fg: lic.expired ? AppColors.red : AppColors.green,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              InfoRow(label: 'Válida até', value: lic.validUntilText),
              InfoRow(
                label: 'Dias restantes',
                value: lic.expired ? '0' : '${lic.daysLeft}',
              ),
              InfoRow(label: 'Chave de acesso', value: lic.keyMasked),
              InfoRow(
                  label: 'Análises no mês', value: '${lic.analysesThisMonth}'),
              if (lic.expired)
                const AlertBanner(
                  text: 'Sua licença expirou. Fale com o administrador '
                      'para renovar.',
                  icon: Icons.error_outline,
                  bg: AppColors.redBg,
                  fg: AppColors.red,
                )
              else if (lic.expiringSoon)
                AlertBanner(
                  text: 'Sua licença vence em ${lic.daysLeft} dia(s). '
                      'Providencie a renovação.',
                  icon: Icons.schedule,
                  bg: AppColors.yellowBg,
                  fg: AppColors.yellow,
                )
              else
                const AlertBanner(
                  text: 'Licença ativa. Novas análises podem ser feitas no '
                      'computador da clínica.',
                  icon: Icons.check_circle_outline,
                  bg: AppColors.greenLight,
                  fg: AppColors.green,
                ),
            ],
          ),
        ),
        SectionCard(
          title: 'Dispositivos autorizados '
              '(${lic.devices.length} de ${lic.maxDevices})',
          child: Column(
            children: [
              for (final d in lic.devices)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Icon(
                        d.isMobile
                            ? Icons.smartphone
                            : Icons.desktop_windows_outlined,
                        color: AppColors.gray,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(d.name,
                                style: AppTextStyles.input
                                    .copyWith(fontWeight: FontWeight.w600)),
                            Text('Último acesso: ${d.lastAccess}',
                                style: AppTextStyles.small),
                          ],
                        ),
                      ),
                      if (d.isThisDevice)
                        const StatusChip(
                          label: 'Este aparelho',
                          bg: AppColors.greenLight,
                          fg: AppColors.green,
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        OutlineButtonGreen(
          text: 'Solicitar renovação',
          onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text('Em breve: renovação pelo aplicativo.')),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
