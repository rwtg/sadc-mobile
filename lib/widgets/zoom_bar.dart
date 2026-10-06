import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class ZoomBar extends StatelessWidget {
  const ZoomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: AppColors.field,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            icon: const Icon(Icons.remove, color: AppColors.gray),
            onPressed: () {},
          ),
          IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 18,
            icon: const Icon(Icons.add, color: AppColors.gray),
            onPressed: () {},
          ),
          const Text('100%', style: AppTextStyles.body),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {},
            child: const Text('Ajustar',
                style: TextStyle(color: AppColors.text, fontSize: 13)),
          ),
        ],
      ),
    );
  }
}
