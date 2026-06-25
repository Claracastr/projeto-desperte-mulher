class EvaluationRecord {
  final int? id;
  final bool anonymous;
  final String respondentName;
  final DateTime completedAt;
  final int score;
  final String riskLevel;
  final int answeredQuestions;
  final String summary;

  EvaluationRecord({
    this.id,
    required this.anonymous,
    required this.respondentName,
    required this.completedAt,
    required this.score,
    required this.riskLevel,
    required this.answeredQuestions,
    required this.summary,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'anonymous': anonymous ? 1 : 0,
      'respondentName': respondentName,
      'completedAt': completedAt.toIso8601String(),
      'score': score,
      'riskLevel': riskLevel,
      'answeredQuestions': answeredQuestions,
      'summary': summary,
    };
  }

  factory EvaluationRecord.fromMap(Map<String, Object?> map) {
    return EvaluationRecord(
      id: map['id'] as int?,
      anonymous: (map['anonymous'] as int) == 1,
      respondentName: map['respondentName'] as String? ?? '',
      completedAt: DateTime.parse(map['completedAt'] as String),
      score: map['score'] as int? ?? 0,
      riskLevel: map['riskLevel'] as String? ?? 'Desconhecido',
      answeredQuestions: map['answeredQuestions'] as int? ?? 0,
      summary: map['summary'] as String? ?? '',
    );
  }
}
