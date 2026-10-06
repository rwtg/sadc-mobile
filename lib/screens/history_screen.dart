import 'package:flutter/material.dart';
import '../models/sample.dart';
import '../themes/app_colors.dart';
import '../themes/app_text_styles.dart';
import '../widgets/sample_card.dart';

/// Lista com busca e filtro de risco. Usada na aba "Histórico" do
/// dashboard e na tela HistoryScreen.
class HistoryList extends StatefulWidget {
  final bool showSearch;
  final bool showFilters;

  const HistoryList(
      {super.key, this.showSearch = true, this.showFilters = true});

  @override
  State<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  String _query = '';
  Risk? _risk;

  List<Sample> get _filtered {
    final q = _query.toLowerCase();
    return mockSamples.where((s) {
      final okQuery = q.isEmpty ||
          s.id.toLowerCase().contains(q) ||
          s.type.toLowerCase().contains(q);
      final okRisk = _risk == null || s.risk == _risk;
      return okQuery && okRisk;
    }).toList();
  }

  Widget _chip(String label, Risk? value) {
    final selected = _risk == value;
    return ChoiceChip(
      label: Text(label),
      selected: selected,
      selectedColor: AppColors.greenLight,
      labelStyle: TextStyle(
        color: selected ? AppColors.green : AppColors.gray,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _risk = value),
    );
  }

  @override
  Widget build(BuildContext context) {
    final items = _filtered;
    return Column(
      children: [
        if (widget.showSearch)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: TextField(
              onChanged: (v) => setState(() => _query = v),
              decoration: InputDecoration(
                hintText: 'Buscar amostra ou tipo',
                hintStyle: AppTextStyles.hint,
                prefixIcon: const Icon(Icons.search, color: AppColors.gray),
                filled: true,
                fillColor: AppColors.field,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        if (widget.showFilters)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                children: [
                  _chip('Todos', null),
                  _chip('Alto', Risk.alto),
                  _chip('Médio', Risk.medio),
                  _chip('Baixo', Risk.baixo),
                ],
              ),
            ),
          ),
        Expanded(
          child: items.isEmpty
              ? const Center(
                  child: Text('Nenhuma análise encontrada.',
                      style: AppTextStyles.body))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => SampleCard(sample: items[i]),
                ),
        ),
      ],
    );
  }
}

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool _searching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: AppColors.text, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Histórico', style: AppTextStyles.appBarTitle),
        actions: [
          IconButton(
            icon: Icon(_searching ? Icons.close : Icons.search,
                color: AppColors.text),
            onPressed: () => setState(() => _searching = !_searching),
          ),
        ],
      ),
      body: HistoryList(
        key: ValueKey(_searching),
        showSearch: _searching,
        showFilters: false,
      ),
    );
  }
}
