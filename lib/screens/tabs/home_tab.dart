import 'package:flutter/material.dart';
import '../../models/license_info.dart';
import '../../models/sample.dart';
import '../../models/user_info.dart';
import '../../themes/app_colors.dart';
import '../../themes/app_text_styles.dart';
import '../../widgets/alert_banner.dart';
import '../../widgets/sample_card.dart';
import '../../widgets/section_card.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/status_chip.dart';
import '../history_screen.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  int _count(Risk r) => mockSamples.where((s) => s.risk == r).length;
  int get _pending => mockSamples.where((s) => !s.reviewed).length;

  @override
  Widget build(BuildContext context) {
    final lic = mockLicense;
    final recent = mockSamples.take(3).toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Cartão de boas-vindas + status de sync
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF16A34A), Color(0xFF15803D)],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Olá, ${mockUser.name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text('${mockUser.clinic} · ${mockUser.role}',
                  style: const TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 12),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.sync, color: Colors.white, size: 14),
                    SizedBox(width: 6),
                    Text('Sincronizado · Hoje, 08:54',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Pendências
        if (_pending > 0)
          AlertBanner(
            text: 'Você tem $_pending análise(s) aguardando revisão.',
            icon: Icons.pending_actions,
            bg: AppColors.yellowBg,
            fg: AppColors.yellow,
          ),

        // Números do mês
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.biotech_outlined,
                value: '${lic.analysesThisMonth}',
                label: 'Análises no mês',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.warning_amber_rounded,
                value: '${_count(Risk.alto)}',
                label: 'Risco alto',
                color: AppColors.red,
                bg: AppColors.redBg,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: StatCard(
                icon: Icons.history,
                value: '${mockSamples.length}',
                label: 'No histórico',
                color: AppColors.blue,
                bg: const Color(0xFFDBEAFE),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                icon: Icons.devices_outlined,
                value: '${lic.devices.length}/${lic.maxDevices}',
                label: 'Dispositivos',
                color: AppColors.yellow,
                bg: AppColors.yellowBg,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Status da licença
        SectionCard(
          title: 'Licença',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Plano ${lic.plan}',
                        style: AppTextStyles.cardTitle),
                  ),
                  StatusChip(
                    label: lic.statusLabel,
                    bg: lic.expired ? AppColors.redBg : AppColors.greenLight,
                    fg: lic.expired ? AppColors.red : AppColors.green,
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Válida até ${lic.validUntilText}',
                  style: AppTextStyles.body),
              if (lic.expired)
                const AlertBanner(
                  text: 'Sua licença expirou. Fale com o administrador.',
                  icon: Icons.error_outline,
                  bg: AppColors.redBg,
                  fg: AppColors.red,
                )
              else if (lic.expiringSoon)
                AlertBanner(
                  text: 'Sua licença vence em ${lic.daysLeft} dia(s).',
                  icon: Icons.schedule,
                  bg: AppColors.yellowBg,
                  fg: AppColors.yellow,
                ),
            ],
          ),
        ),

        // Aviso fixo sobre o papel do app
        const SectionCard(
          title: 'Como funciona',
          child: Text(
            'As análises são processadas no computador da clínica. '
            'Este aplicativo permite consultar resultados, acompanhar '
            'a licença, ver dispositivos autorizados e receber alertas '
            'de qualquer lugar.',
            style: AppTextStyles.body,
          ),
        ),

        // Últimas análises
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Últimas análises', style: AppTextStyles.sectionTitle),
            TextButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              ),
              child: const Text('Ver todas',
                  style: TextStyle(
                      color: AppColors.green, fontWeight: FontWeight.w700)),
            ),
          ],
        ),
        for (final s in recent) ...[
          SampleCard(sample: s),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}
