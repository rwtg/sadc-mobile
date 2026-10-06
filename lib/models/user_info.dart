class UserInfo {
  final String name;
  final String role;
  final String clinic;
  final String email;
  final String crm;

  const UserInfo({
    required this.name,
    required this.role,
    required this.clinic,
    required this.email,
    required this.crm,
  });

  String get initials {
    final parts = name.trim().split(' ').where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }
}

const mockUser = UserInfo(
  name: 'Usuário Demo',
  role: 'administrador',
  clinic: 'CLINICA TEST',
  email: 'demo@clinicatest.com',
  crm: 'PE 123456',
);
