import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_info.dart';

class Account {
  final String name;
  final String clinic;
  final String email;
  final String crm;
  final String passHash;

  const Account({
    required this.name,
    required this.clinic,
    required this.email,
    required this.passHash,
    this.crm = '',
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'clinic': clinic,
        'email': email,
        'crm': crm,
        'passHash': passHash,
      };

  factory Account.fromJson(Map<String, dynamic> j) => Account(
        name: j['name'] as String,
        clinic: j['clinic'] as String,
        email: j['email'] as String,
        crm: (j['crm'] as String?) ?? '',
        passHash: j['passHash'] as String,
      );
}

class AuthService {
  AuthService._();
  static final AuthService instance = AuthService._();

  static const _accountsKey = 'sadc_accounts';
  static const _keysKey = 'sadc_issued_keys';

  Account? currentAccount;
  String? currentKey;

  UserInfo get currentUser {
    final a = currentAccount;
    if (a == null) return mockUser;
    return UserInfo(
      name: a.name,
      role: 'administrador',
      clinic: a.clinic,
      email: a.email,
      crm: a.crm.isEmpty ? 'Não informado' : a.crm,
    );
  }

  String? get maskedKey {
    final k = currentKey;
    if (k == null || k.length < 4) return null;
    return 'SADC-••••-${k.substring(k.length - 4)}';
  }

  String _hash(String email, String pass) => sha256
      .convert(utf8.encode('sadc|${email.trim().toLowerCase()}|$pass'))
      .toString();

  Future<List<Account>> _loadAccounts() async {
    final p = await SharedPreferences.getInstance();
    final raw = p.getStringList(_accountsKey) ?? [];
    return raw
        .map((e) => Account.fromJson(jsonDecode(e) as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveAccounts(List<Account> list) async {
    final p = await SharedPreferences.getInstance();
    await p.setStringList(
        _accountsKey, list.map((a) => jsonEncode(a.toJson())).toList());
  }

  Future<String?> register({
    required String name,
    required String clinic,
    required String email,
    required String password,
    String crm = '',
  }) async {
    final accounts = await _loadAccounts();
    final mail = email.trim().toLowerCase();

    if (accounts.any((a) => a.email == mail)) {
      return 'Já existe uma conta com este e-mail.';
    }

    accounts.add(Account(
      name: name.trim(),
      clinic: clinic.trim(),
      email: mail,
      crm: crm.trim(),
      passHash: _hash(mail, password),
    ));
    await _saveAccounts(accounts);
    return null;
  }

  Future<String?> login({
    required String email,
    required String password,
    required String accessKey,
  }) async {
    final accounts = await _loadAccounts();
    final mail = email.trim().toLowerCase();

    final matches = accounts
        .where((a) => a.email == mail && a.passHash == _hash(mail, password));
    if (matches.isEmpty) return 'E-mail ou senha incorretos.';

    final key = accessKey.trim().toUpperCase();
    final p = await SharedPreferences.getInstance();
    final keys = p.getStringList(_keysKey) ?? [];
    if (!keys.contains(key)) return 'Chave de acesso inválida.';

    currentAccount = matches.first;
    currentKey = key;
    return null;
  }

  void logout() {
    currentAccount = null;
    currentKey = null;
  }

  Future<String> requestKey() async {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rnd = Random.secure();
    String part() =>
        List.generate(4, (_) => chars[rnd.nextInt(chars.length)]).join();
    final key = 'SADC-${part()}-${part()}';

    final p = await SharedPreferences.getInstance();
    final keys = p.getStringList(_keysKey) ?? [];
    keys.add(key);
    await p.setStringList(_keysKey, keys);
    return key;
  }

  /// Só para testes: apaga contas e chaves salvas.
  Future<void> debugReset() async {
    final p = await SharedPreferences.getInstance();
    await p.remove(_accountsKey);
    await p.remove(_keysKey);
    currentAccount = null;
    currentKey = null;
  }
}
