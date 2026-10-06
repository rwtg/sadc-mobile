import 'package:flutter/material.dart';
import '../models/sample.dart';
import '../themes/app_colors.dart';

class RiskBadge extends StatelessWidget {
  final Risk risk;
  const RiskBadge({super.key, required this.risk});

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;

    switch (risk) {
      case Risk.alto:
        bg = AppColors.redBg;
        fg = AppColors.red;
        break;
      case Risk.medio:
        bg = AppColors.yellowBg;
        fg = AppColors.yellow;
        break;
      case Risk.baixo:
        bg = AppColors.greenLight;
        fg = AppColors.green;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        risk.label,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: fg),
      ),
    );
  }
}
