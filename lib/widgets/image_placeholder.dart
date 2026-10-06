import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';

class ImagePlaceholder extends StatelessWidget {
  final double height;
  const ImagePlaceholder({super.key, this.height = 160});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      alignment: Alignment.center,
      child:
          const Text('Nenhuma imagem selecionada', style: AppTextStyles.small),
    );
  }
}
