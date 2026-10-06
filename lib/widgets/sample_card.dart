import 'package:flutter/material.dart';
import '../models/sample.dart';
import '../screens/analysis_detail_screen.dart';
import '../services/review_store.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import 'risk_badge.dart';

class SampleCard extends StatelessWidget {
  final Sample sample;
  const SampleCard({super.key, required this.sample});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: ReviewStore.instance,
      builder: (context, _) {
        final reviewed = ReviewStore.instance.isReviewed(sample);

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => AnalysisDetailScreen(sample: sample)),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Amostra ${sample.id}',
                                style: AppTextStyles.cardTitle),
                            const SizedBox(width: 8),
                            Text('· ${sample.date}',
                                style: AppTextStyles.small),
                            const SizedBox(width: 8),
                            RiskBadge(risk: sample.risk),
                            const Spacer(),
                            if (!reviewed)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppColors.yellowBg,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text('Novo',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.yellow)),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text.rich(
                          TextSpan(
                            style: AppTextStyles.body,
                            children: [
                              TextSpan(text: '${sample.type} · '),
                              TextSpan(
                                  text: '${sample.score}',
                                  style: AppTextStyles.score),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: AppColors.grayLight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
