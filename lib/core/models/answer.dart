class Answer {
  final String label;
  final int score;

  const Answer({
    required this.label,
    required this.score,
  });

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      label: json['label'] as String,
      score: json['score'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'score': score,
    };
  }
}
