/*
Nome: Answer
Descrição: clsse responsavel pelo parsing de uma pergunta vinda do backend
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'answer.dart';

class Question {
  final String title;
  final List<Answer> answers;
  final bool multipleSelection;

  Answer? selectedAnswer;
  List<Answer> selectedAnswers;

  Question({
    required this.title,
    required this.answers,
    this.multipleSelection = false,
    this.selectedAnswer,
    List<Answer>? selectedAnswers,
  }) : selectedAnswers = selectedAnswers ?? [];

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      title: json['title'] as String,
      answers: (json['answers'] as List)
          .map((item) => Answer.fromJson(item))
          .toList(),
      multipleSelection: json['multipleSelection'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'answers': answers.map((e) => e.toJson()).toList(),
      'multipleSelection': multipleSelection,
    };
  }

  bool get isAnswered =>
      multipleSelection ? selectedAnswers.isNotEmpty : selectedAnswer != null;

  int get score {
    if (multipleSelection) {
      return selectedAnswers.fold(0, (sum, answer) => sum + answer.score);
    }
    return selectedAnswer?.score ?? 0;
  }
}
