import 'answer.dart';

enum QuestionnaireStage {
  history,
  aggressor,
  aboutYou,
  other,
}

extension QuestionnaireStageExtension on QuestionnaireStage {
  String get title {
    switch (this) {
      case QuestionnaireStage.history:
        return 'Histórico de Violência';
      case QuestionnaireStage.aggressor:
        return 'Sobre o Agressor';
      case QuestionnaireStage.aboutYou:
        return 'Sobre Você';
      case QuestionnaireStage.other:
        return 'Outras Informações';
    }
  }

  int get step {
    switch (this) {
      case QuestionnaireStage.history:
        return 1;
      case QuestionnaireStage.aggressor:
        return 2;
      case QuestionnaireStage.aboutYou:
        return 3;
      case QuestionnaireStage.other:
        return 4;
    }
  }
}

class Question {
  final String id;
  final QuestionnaireStage stage;
  final String text;
  final List<Answer> answers;
  final int weight;
  Answer? selectedAnswer;

  Question({
    required this.id,
    required this.stage,
    required this.text,
    required this.answers,
    this.weight = 1,
    this.selectedAnswer,
  });

  bool get hasAnswer => selectedAnswer != null;

  int get score => (selectedAnswer?.score ?? 0) * weight;

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as String,
      stage: QuestionnaireStage.values.firstWhere(
        (stage) => stage.name == json['stage'] as String,
        orElse: () => QuestionnaireStage.history,
      ),
      text: json['text'] as String,
      answers: (json['answers'] as List)
          .map((item) => Answer.fromJson(item as Map<String, dynamic>))
          .toList(),
      weight: json['weight'] as int? ?? 1,
      selectedAnswer: null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stage': stage.name,
      'text': text,
      'answers': answers.map((answer) => answer.toJson()).toList(),
      'weight': weight,
      'selectedAnswer': selectedAnswer?.toJson(),
    };
  }

  int get maximumScore =>
      answers.fold(0, (sum, answer) => sum + answer.score) * weight;
}
