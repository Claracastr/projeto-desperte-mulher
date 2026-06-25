/*
Nome: QuizPage
Descrição: classe responsavel por modelar um widget para aprsentar na tela com diversas questões
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'package:flutter/material.dart';
import '../../Models/question.dart';
import '../../common/app_routes.dart';
import 'question_widget.dart';
import 'quiz_server.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizServer _server = QuizServer();
  final ScrollController _scrollController = ScrollController();

  bool _isLoading = true;
  bool _isLoadingNextPage = false;

  int _currentPage = 1;
  int _lastPage = 1;

  final List<Question> _questions = [];

  int get _totalScore =>
      _questions.fold(0, (sum, question) => sum + question.score);

  bool get _hasUnansweredQuestions =>
      _questions.any((question) => !question.isAnswered);

  int get _answeredCount =>
      _questions.where((question) => question.isAnswered).length;

  @override
  void initState() {
    super.initState();

    _loadFirstPage();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // =========================
  // FIRST PAGE
  // =========================
  Future<void> _loadFirstPage() async {
    final result = await _server.fetchQuestions(1);

    if (!mounted) return;

    setState(() {
      _currentPage = result.page;
      _lastPage = result.lastPage;

      _questions
        ..clear()
        ..addAll(result.questions);

      _isLoading = false;
    });
  }

  // =========================
  // SCROLL
  // =========================
  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_isLoadingNextPage) return;

    final position = _scrollController.position;

    const threshold = 250.0;

    if (position.pixels >= position.maxScrollExtent - threshold) {
      _loadNextPage();
    }
  }

  // =========================
  // NEXT PAGE
  // =========================
  Future<void> _loadNextPage() async {
    if (_isLoadingNextPage) return;
    if (_currentPage >= _lastPage) return;

    setState(() {
      _isLoadingNextPage = true;
    });

    try {
      final nextPage = _currentPage + 1;

      final result = await _server.fetchQuestions(nextPage);

      if (!mounted) return;

      setState(() {
        _currentPage = result.page;
        _lastPage = result.lastPage;

        _questions.addAll(result.questions);
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingNextPage = false;
        });
      }
    }
  }

  // =========================
  // NAV RESULT
  // =========================
  void _onShowResult() {
    if (_hasUnansweredQuestions) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Por favor, responda todas as perguntas antes de finalizar.'),
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.result,
      arguments: _totalScore,
    );
  }

  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Contato Delegacia da Mulher'),
          content: const Text(
            'Em caso de emergência ou necessidade de orientação, procure a Delegacia da Mulher mais próxima ou ligue para os serviços de apoio locais.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  // =========================
  // BUILD
  // =========================
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isLastPage = _currentPage == _lastPage;

    return Scaffold(
      appBar: AppBar(
        title: Text('Página $_currentPage de $_lastPage'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFCCE5FF),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Text(
              'Atenção: esta análise tem caráter informativo e não substitui a avaliação da rede de proteção à mulher. Em casos de violência familiar, é indispensável procurar os serviços especializados. Mesmo que o Risco seja Baixo, ele Existe!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: const Color(0xFF0B3D91),
                  ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              itemCount: _questions.length + (_isLoadingNextPage ? 1 : 0),
              itemBuilder: (context, index) {
                if (_isLoadingNextPage && index == _questions.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final question = _questions[index];
                return QuestionWidget(
                  question: question,
                  onChanged: (_) => setState(() {}),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Progresso da avaliação',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Página $_currentPage de $_lastPage · '
                  '$_answeredCount de ${_questions.length} respondidas',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Responda todas as perguntas visíveis para liberar o botão Finalizar.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black54,
                      ),
                ),
              ],
            ),
          ),
          if (isLastPage)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Pontuação atual: $_totalScore',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 44,
                        child: ElevatedButton.icon(
                          onPressed: _showContactDialog,
                          icon: const Icon(Icons.phone),
                          label: const Text('Contatar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E88E5),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        height: 44,
                        child: OutlinedButton.icon(
                          onPressed: _onShowResult,
                          icon: const Icon(Icons.check_circle_outline),
                          label: const Text('Finalizar'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1E88E5),
                            side: const BorderSide(color: Color(0xFF1E88E5)),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
