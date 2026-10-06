enum Risk { alto, medio, baixo }

extension RiskLabel on Risk {
  String get label {
    switch (this) {
      case Risk.alto:
        return 'Alto';
      case Risk.medio:
        return 'Médio';
      case Risk.baixo:
        return 'Baixo';
    }
  }
}

class Sample {
  final String id;
  final String date;
  final String dateTime;
  final String type;
  final String code;
  final int score;
  final Risk risk;
  final String fileName;
  final double confidence;
  final int nuclei;
  final String pleomorphism;
  final Map<String, double> probabilities;
  final String originDevice;
  final bool reviewed;

  const Sample({
    required this.id,
    required this.date,
    required this.dateTime,
    required this.type,
    required this.code,
    required this.score,
    required this.risk,
    required this.fileName,
    required this.confidence,
    required this.nuclei,
    required this.pleomorphism,
    required this.probabilities,
    this.originDevice = 'Desktop · Recepção',
    this.reviewed = false,
  });
}

const mockSamples = [
  Sample(
    id: '#0231',
    date: '21 set',
    dateTime: '2026-09-21 18:53:59',
    type: 'Tumor (adenocarcinoma)',
    code: 'TUM',
    score: 78,
    risk: Risk.alto,
    fileName: 'TCGA-13-A5FT-01Z-00-DX1_10240_18432.jpg',
    confidence: 90.6,
    nuclei: 25,
    pleomorphism: 'alto',
    probabilities: {'Tumor (adenocarcinoma)': 90.6, 'Mucosa normal': 9.4},
    reviewed: false,
  ),
  Sample(
    id: '#0230',
    date: '20 set',
    dateTime: '2026-09-20 15:12:08',
    type: 'Estroma',
    code: 'STR',
    score: 45,
    risk: Risk.medio,
    fileName: 'amostra_0230.jpg',
    confidence: 71.2,
    nuclei: 14,
    pleomorphism: 'médio',
    probabilities: {
      'Estroma': 71.2,
      'Tumor (adenocarcinoma)': 20.5,
      'Mucosa normal': 8.3,
    },
    reviewed: false,
  ),
  Sample(
    id: '#0229',
    date: '18 set',
    dateTime: '2026-09-18 10:41:33',
    type: 'Mucosa normal',
    code: 'NORM',
    score: 12,
    risk: Risk.baixo,
    fileName: 'amostra_0229.jpg',
    confidence: 86.4,
    nuclei: 9,
    pleomorphism: 'baixo',
    probabilities: {
      'Mucosa normal': 86.4,
      'Estroma': 9.1,
      'Tumor (adenocarcinoma)': 4.5,
    },
    reviewed: true,
  ),
  Sample(
    id: '#0228',
    date: '15 set',
    dateTime: '2026-09-15 17:25:50',
    type: 'Tumor (adenocarcinoma)',
    code: 'TUM',
    score: 81,
    risk: Risk.alto,
    fileName: 'amostra_0228.jpg',
    confidence: 92.3,
    nuclei: 31,
    pleomorphism: 'alto',
    probabilities: {'Tumor (adenocarcinoma)': 92.3, 'Mucosa normal': 7.7},
    reviewed: true,
  ),
  Sample(
    id: '#0227',
    date: '12 set',
    dateTime: '2026-09-12 09:08:17',
    type: 'Mucosa normal',
    code: 'NORM',
    score: 13,
    risk: Risk.baixo,
    fileName: 'amostra_0227.jpg',
    confidence: 88.0,
    nuclei: 8,
    pleomorphism: 'baixo',
    probabilities: {'Mucosa normal': 88.0, 'Estroma': 12.0},
    reviewed: true,
  ),
  Sample(
    id: '#0226',
    date: '10 set',
    dateTime: '2026-09-10 14:30:42',
    type: 'Tumor (adenocarcinoma)',
    code: 'TUM',
    score: 82,
    risk: Risk.alto,
    fileName: 'amostra_0226.jpg',
    confidence: 90.9,
    nuclei: 27,
    pleomorphism: 'alto',
    probabilities: {'Tumor (adenocarcinoma)': 90.9, 'Mucosa normal': 9.1},
    reviewed: true,
  ),
];
