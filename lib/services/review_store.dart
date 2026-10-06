import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sample.dart';

class ReviewStore extends ChangeNotifier {
  ReviewStore._();
  static final ReviewStore instance = ReviewStore._();

  static const _key = 'sadc_reviewed_ids';
  final Set<String> _ids = {};
  bool _loaded = false;

  Future<void> load() async {
    if (_loaded) return;
    final p = await SharedPreferences.getInstance();
    _ids
      ..clear()
      ..addAll(p.getStringList(_key) ?? []);
    _loaded = true;
    notifyListeners();
  }

  bool isReviewed(Sample s) => s.reviewed || _ids.contains(s.id);

  Future<void> markReviewed(Sample s) async {
    _ids.add(s.id);
    final p = await SharedPreferences.getInstance();
    await p.setStringList(_key, _ids.toList());
    notifyListeners();
  }

  Future<void> toggleReviewed(Sample s) async {
    if (_ids.contains(s.id)) {
      _ids.remove(s.id);
    } else {
      _ids.add(s.id);
    }
    final p = await SharedPreferences.getInstance();
    await p.setStringList(_key, _ids.toList());
    notifyListeners();
  }
}
