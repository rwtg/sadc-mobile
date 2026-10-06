import 'package:flutter/material.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import 'primary_button.dart';

Future<void> showSettingsDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (_) => const _SettingsDialog(),
  );
}

class _SettingsDialog extends StatefulWidget {
  const _SettingsDialog();

  @override
  State<_SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<_SettingsDialog> {
  final _controller = TextEditingController(text: '1000');

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      scrollable: true,
      title: const Text('Configurações', style: AppTextStyles.appBarTitle),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Backup local de imagens',
              style: AppTextStyles.sectionTitle),
          const SizedBox(height: 8),
          const Text(
            'As imagens das análises feitas NESTA máquina ficam salvas '
            'localmente para poderem ser visualizadas na aba Histórico. '
            'Análises feitas em outros dispositivos da clínica não têm '
            'imagem disponível aqui.',
            style: AppTextStyles.small,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Text('Manter no máximo:', style: AppTextStyles.body),
              const SizedBox(width: 8),
              SizedBox(
                width: 72,
                child: TextField(
                  controller: _controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              const Flexible(
                child: Text('imagens salvas', style: AppTextStyles.body),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Ao ultrapassar o limite, as imagens mais antigas são removidas '
            'automaticamente do disco (isso não apaga o laudo, que continua '
            'no servidor — só a imagem local).',
            style: AppTextStyles.small,
          ),
          const Divider(height: 28, color: AppColors.border),
          const Text(
            'Atualmente: 14 análise(s) com imagem salva localmente, '
            'ocupando aproximadamente 1.0 MB em disco.',
            style: AppTextStyles.small,
          ),
          const Divider(height: 28, color: AppColors.border),
          const Text('Este dispositivo', style: AppTextStyles.sectionTitle),
          const SizedBox(height: 8),
          const Text(
            'Desativar este aparelho o remove da lista de dispositivos '
            'autorizados da clínica. Na próxima vez que o SADC for aberto '
            'aqui, será preciso informar a chave de licença de novo para '
            'reativá-lo. Use isso ao formatar, vender ou aposentar este '
            'aparelho, ou para liberar uma vaga para outro.',
            style: AppTextStyles.small,
          ),
          const SizedBox(height: 12),
          PrimaryButton(
              text: 'Desativar este dispositivo...', onPressed: () {}),
          const SizedBox(height: 8),
          PrimaryButton(text: 'Limpar backup local agora', onPressed: () {}),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child:
              const Text('Cancelar', style: TextStyle(color: AppColors.green)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            foregroundColor: Colors.white,
          ),
          child: const Text('Salvar'),
        ),
      ],
    );
  }
}
