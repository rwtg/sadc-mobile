import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

/// Botão cinza claro (ações secundárias). onPressed null = desabilitado.
class SoftButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const SoftButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 46,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.field,
          foregroundColor: AppColors.text,
          disabledBackgroundColor: AppColors.field,
          disabledForegroundColor: AppColors.grayLight,
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(text, style: AppTextStyles.softButton),
      ),
    );
  }
}
