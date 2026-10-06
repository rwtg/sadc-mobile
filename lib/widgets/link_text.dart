import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class LinkText extends StatelessWidget {
  final String prefix;
  final String link;
  final VoidCallback? onTap;

  const LinkText({
    super.key,
    required this.prefix,
    required this.link,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$prefix ', style: AppTextStyles.small),
        GestureDetector(
          onTap: onTap,
          child: const Text(
            '',
            style: TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            link,
            style: const TextStyle(
              color: AppColors.green,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
