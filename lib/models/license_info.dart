class LicenseInfo {
  final String plan;
  final String keyMasked;
  final DateTime validUntil;
  final int maxDevices;
  final int analysesThisMonth;
  final List<DeviceInfo> devices;

  const LicenseInfo({
    required this.plan,
    required this.keyMasked,
    required this.validUntil,
    required this.maxDevices,
    required this.analysesThisMonth,
    required this.devices,
  });

  // ─── Derivados usados pelas telas ────────────────
  int get daysLeft {
    final d = validUntil.difference(DateTime.now()).inDays;
    return d < 0 ? 0 : d;
  }

  bool get expired => DateTime.now().isAfter(validUntil);

  bool get expiringSoon {
    final d = validUntil.difference(DateTime.now()).inDays;
    return !expired && d <= 30;
  }

  String get statusLabel {
    if (expired) return 'Expirada';
    if (expiringSoon) return 'Expira em breve';
    return 'Ativa';
  }

  String get validUntilText {
    final d = validUntil;
    final dd = d.day.toString().padLeft(2, '0');
    final mm = d.month.toString().padLeft(2, '0');
    return '$dd/$mm/${d.year}';
  }
}

class DeviceInfo {
  final String name;
  final String platform; // 'desktop' | 'mobile' | 'tablet'
  final DateTime lastAccess;
  final bool isThisDevice;

  const DeviceInfo({
    required this.name,
    required this.platform,
    required this.lastAccess,
    this.isThisDevice = false,
  });

  bool get isMobile => platform == 'mobile' || platform == 'tablet';

  String get lastAccessText {
    final h = lastAccess.hour.toString().padLeft(2, '0');
    final m = lastAccess.minute.toString().padLeft(2, '0');
    final d = lastAccess.day.toString().padLeft(2, '0');
    final mo = lastAccess.month.toString().padLeft(2, '0');
    return '$d/$mo/${lastAccess.year} · $h:$m';
  }

  // alias caso alguma tela use `lastAccess` como String
  String get lastAccessString => lastAccessText;
}

// ─── Mock de demonstração ──────────────────────────
final mockLicense = LicenseInfo(
  plan: 'Clínica · Anual',
  keyMasked: 'SADC-••••-A1B2',
  validUntil: DateTime.now().add(const Duration(days: 365)),
  maxDevices: 5,
  analysesThisMonth: 42,
  devices: [
    DeviceInfo(
      name: 'Desktop · Recepção',
      platform: 'desktop',
      lastAccess: DateTime.now(),
      isThisDevice: true,
    ),
    DeviceInfo(
      name: 'Notebook · Consultório 2',
      platform: 'desktop',
      lastAccess: DateTime.now().subtract(const Duration(days: 1)),
    ),
    DeviceInfo(
      name: 'iPhone · Dr. João',
      platform: 'mobile',
      lastAccess: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ],
);
