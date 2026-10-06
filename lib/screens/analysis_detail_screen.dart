import 'package:flutter/material.dart';
import '../models/sample.dart';
import '../services/review_store.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../widgets/alert_banner.dart';
import '../widgets/info_row.dart';
import '../widgets/risk_badge.dart';
import '../widgets/section_card.dart';

class AnalysisDetailScreen extends StatelessWidget {
  final Sample sample;
  const AnalysisDetailScreen({super.key, required this.sample});

  Color riskColor(Risk risk) {
    switch (risk) {
      case Risk.alto:
        return AppColors.red;
      case Risk.medio:
        return AppColors.yellow;
      case Risk.baixo:
        return AppColors.green;
    }
  }

  Color riskBgColor(Risk risk) {
    switch (risk) {
      case Risk.alto:
        return AppColors.redBg;
      case Risk.medio:
        return AppColors.yellowBg;
      case Risk.baixo:
        return AppColors.greenLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = riskColor(sample.risk);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.text, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Amostra ${sample.id}', style: AppTextStyles.appBarTitle),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionCard(
            title: 'Resumo',
            child: Column(
              children: [
                Row(
                  children: [
                    RiskBadge(risk: sample.risk),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(sample.type, style: AppTextStyles.cardTitle),
                    ),
                    Text('${sample.score}',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: color)),
                  ],
                ),
                const SizedBox(height: 12),
                InfoRow(label: 'Data', value: sample.dateTime),
                InfoRow(label: 'Arquivo', value: sample.fileName),
                InfoRow(label: 'Origem', value: sample.originDevice),
              ],
            ),
          ),
          SectionCard(
            title: 'Confiança do modelo',
            child: Column(
              children: [
                InfoRow(
                    label: 'Confiança',
                    value: '${sample.confidence.toStringAsFixed(1)}%'),
                InfoRow(label: 'Núcleos', value: '${sample.nuclei}'),
                InfoRow(label: 'Pleomorfismo', value: sample.pleomorphism),
              ],
            ),
          ),
          SectionCard(
            title: 'Probabilidades',
            child: Column(
              children: sample.probabilities.entries
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(e.key, style: AppTextStyles.body),
                            ),
                            Text(
                              '${e.value.toStringAsFixed(1)}%',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          SectionCard(
            title: 'Revisão',
            child: _ReviewBox(sample: sample),
          ),
          const SizedBox(height: 12),
          AlertBanner(
            text: ReviewStore.instance.isReviewed(sample)
                ? 'Amostra revisada.'
                : 'Esta amostra ainda não foi revisada.',
            bg: riskBgColor(sample.risk),
            fg: color,
            icon: Icons.info_outline,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class _ReviewBox extends StatelessWidget {
  final Sample sample;
  const _ReviewBox({required this.sample});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ReviewStore.instance,
      builder: (context, _) {
        final reviewed = ReviewStore.instance.isReviewed(sample);
        return Row(
          children: [
            Expanded(
              child: Text(
                reviewed ? 'Marcada como revisada' : 'Pendente de revisão',
                style: AppTextStyles.body,
              ),
            ),
            TextButton(
              onPressed: () => ReviewStore.instance.toggleReviewed(sample),
              child: Text(reviewed ? 'Desmarcar' : 'Marcar revisada'),
            ),
          ],
        );
      },
    );
  }
}
