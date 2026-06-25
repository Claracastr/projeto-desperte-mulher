import 'package:flutter/material.dart';
import '../data/local_database.dart';
import '../data/questionnaire_data.dart';
import '../models/answer.dart';
import '../models/evaluation_record.dart';
import '../models/question.dart';
import '../models/respondent.dart';

class QuestionnaireProvider extends ChangeNotifier {
  bool anonymous = false;
  Respondent respondent = Respondent.empty();
  List<Question> questions = [];
  int currentIndex = 0;
  bool isSavingDraft = false;
  bool isLoading = true;
  List<EvaluationRecord> history = [];
  final int pageSize = 4;
  int currentPageIndex = 0;

  QuestionnaireProvider() {
    questions = QuestionnaireData.questions
        .map((question) => Question(
              id: question.id,
              stage: question.stage,
              text: question.text,
              answers: question.answers,
            ))
        .toList();
  }

  void startAnonymous() {
    anonymous = true;
    respondent = Respondent.empty();
    _resetAnswers();
    currentIndex = 0;
    notifyListeners();
  }

  void startIdentified(Respondent updatedRespondent) {
    anonymous = false;
    respondent = updatedRespondent;
    _resetAnswers();
    currentIndex = 0;
    notifyListeners();
  }

  void _resetAnswers() {
    questions = QuestionnaireData.questions
        .map((question) => Question(
              id: question.id,
              stage: question.stage,
              text: question.text,
              answers: question.answers,
            ))
        .toList();
  }

  Question get currentQuestion => questions[currentIndex];

  List<Question> get questionsForCurrentPage {
    final start = currentPageIndex * pageSize;
    final end = (start + pageSize).clamp(0, questions.length);
    return questions.sublist(start, end);
  }

  int get pageCount => (totalQuestions / pageSize).ceil();

  bool get canContinuePage => questionsForCurrentPage.every((q) => q.hasAnswer);

  Future<void> goNextPage() async {
    if (currentPageIndex < pageCount - 1) {
      currentPageIndex += 1;
      await saveProgress();
      notifyListeners();
    }
  }

  Future<void> clearProgress() async {
    _resetAnswers();
    currentPageIndex = 0;
    currentIndex = 0;
    await saveProgress();
    notifyListeners();
  }

  void goPrevPage() {
    if (currentPageIndex > 0) {
      currentPageIndex -= 1;
      notifyListeners();
    }
  }

  int get totalQuestions => questions.length;

  int get answeredQuestions =>
      questions.where((question) => question.hasAnswer).length;

  int get remainingQuestions => totalQuestions - answeredQuestions;

  int get totalScore => questions.fold(0, (sum, q) => sum + q.score);

  int get maximumScore => questions.fold(0, (sum, q) => sum + q.maximumScore);

  double get riskPercent => maximumScore == 0 ? 0 : totalScore / maximumScore;

  String get riskLevel {
    final percent = riskPercent;
    if (percent >= 0.75) {
      return 'Crítico';
    }
    if (percent >= 0.5) {
      return 'Alto';
    }
    if (percent >= 0.3) {
      return 'Moderado';
    }
    return 'Baixo';
  }

  String get riskTitle {
    switch (riskLevel) {
      case 'Crítico':
        return 'Alerta Máximo';
      case 'Alto':
        return 'Atenção necessária';
      case 'Moderado':
        return 'Monitore de perto';
      default:
        return 'Situação controlada';
    }
  }

  Color get riskColor {
    switch (riskLevel) {
      case 'Crítico':
        return const Color(0xFFEF476F);
      case 'Alto':
        return const Color(0xFFFFA726);
      case 'Moderado':
        return const Color(0xFFFFE082);
      default:
        return const Color(0xFF4DD0E1);
    }
  }

  IconData get riskIcon {
    switch (riskLevel) {
      case 'Crítico':
        return Icons.warning_amber_rounded;
      case 'Alto':
        return Icons.error_outline;
      case 'Moderado':
        return Icons.remove_circle_outline;
      default:
        return Icons.emoji_emotions_outlined;
    }
  }

  QuestionnaireStage get currentStage => currentQuestion.stage;

  int get currentStageIndex => currentStage.step;

  int get stageCount {
    final stageQuestions =
        questions.where((question) => question.stage == currentStage);
    return stageQuestions.length;
  }

  void selectAnswer(Answer answer) {
    currentQuestion.selectedAnswer = answer;
    notifyListeners();
  }

  void selectAnswerFor(Question question, Answer answer) {
    final idx = questions.indexWhere((q) => q.id == question.id);
    if (idx != -1) {
      questions[idx].selectedAnswer = answer;
      notifyListeners();
    }
  }

  bool canContinue() {
    return currentQuestion.hasAnswer;
  }

  void goNext() {
    if (currentIndex < questions.length - 1) {
      currentIndex += 1;
      notifyListeners();
    }
  }

  void goBack() {
    if (currentIndex > 0) {
      currentIndex -= 1;
      notifyListeners();
    }
  }

  Future<void> saveProgress() async {
    isSavingDraft = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));
    isSavingDraft = false;
    notifyListeners();
  }

  Future<void> submitEvaluation() async {
    final record = EvaluationRecord(
      anonymous: anonymous,
      respondentName: anonymous ? 'Anônimo' : respondent.name,
      completedAt: DateTime.now(),
      score: totalScore,
      riskLevel: riskLevel,
      answeredQuestions: answeredQuestions,
      summary: _selectedAnswersSummary(),
    );

    await LocalDatabase.instance.insertEvaluation(record);
    await loadHistory();
  }

  Future<void> loadHistory() async {
    history = await LocalDatabase.instance.fetchEvaluations();
    isLoading = false;
    notifyListeners();
  }

  String _selectedAnswersSummary() {
    final selected = questions
        .where((question) => question.hasAnswer)
        .map((question) =>
            '${question.id}. ${question.text} — ${question.selectedAnswer!.label}')
        .join('\n');
    return selected;
  }

  /// Returns top N contributing questions with their weighted contribution
  List<Map<String, dynamic>> topContributors([int n = 3]) {
    final items = questions
        .where((q) => q.hasAnswer)
        .map((q) => {
              'question': q,
              'contribution': (q.selectedAnswer?.score ?? 0) * q.weight,
            })
        .toList();

    items.sort((a, b) =>
        (b['contribution'] as int).compareTo(a['contribution'] as int));
    return items.take(n).toList();
  }
}
