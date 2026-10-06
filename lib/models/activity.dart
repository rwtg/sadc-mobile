
import 'package:flutter/material.dart';

enum ActivityKind { newAnalysis, licenseRenewed, deviceAdded, syncDone }

class Activity {
  final ActivityKind kind;
  final String title;
  final String subtitle;
  final String time;
  final String? sampleId;

  const Activity({
    required this.kind,
    required this.title,
    required this.subtitle,
    required this.time,
    this.sampleId,
  });

  IconData get icon {
    switch (kind) {
      case ActivityKind.newAnalysis: return Icons.biotech_outlined;
      case ActivityKind.licenseRenewed: return Icons.verified_user_outlined;
      case ActivityKind.deviceAdded: return Icons.devices_other;
      case ActivityKind.syncDone: return Icons.sync;
    }
  }
}

const mockActivities = [
  Activity(
    kind: ActivityKind.newAnalysis,
    title: 'Nova análise · #0231',
    subtitle: 'Tumor (adenocarcinoma) · risco Alto',
    time: 'Hoje, 18:53',
    sampleId: '#0231',
  ),
  Activity(
    kind: ActivityKind.newAnalysis,
    title: 'Nova análise · #0230',
    subtitle: 'Estroma · risco Médio',
    time: 'Ontem, 15:12',
    sampleId: '#0230',
  ),
  Activity(
    kind: ActivityKind.deviceAdded,
    title: 'Novo dispositivo autorizado',
    subtitle: 'Notebook · Dr. Silva',
    time: 'Há 2 dias',
  ),
  Activity(
    kind: ActivityKind.licenseRenewed,
    title: 'Licença renovada',
    subtitle: 'Plano Trial estendido',
    time: 'Há 5 dias',
  ),
  Activity(
    kind: ActivityKind.syncDone,
    title: 'Sincronização concluída',
    subtitle: '12 análises sincronizadas',
    time: 'Há 5 dias',
  ),
];