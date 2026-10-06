import 'package:flutter/material.dart';
import '../themes/app_colors.dart';

class AlertBanner extends StatelessWidget {
  final String? message;
  final String? text; // alias para compatibilidade
  final IconData icon;
  final Color bg;
  final Color fg;

  const AlertBanner({
    super.key,
    this.message,
    this.text,
    this.icon = Icons.warning_amber_rounded,
    this.bg = AppColors.yellowBg,
    this.fg = AppColors.yellow,
  }) : assert(message != null || text != null, 'Informe message ou text');

  String get _content => message ?? text ?? '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: fg, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _content,
              style: TextStyle(fontSize: 13, color: fg),
            ),
          ),
        ],
      ),
    );
  }
}
