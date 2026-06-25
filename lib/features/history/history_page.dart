import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/questionnaire_provider.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      context.read<QuestionnaireProvider>().loadHistory();
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionnaireProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Avaliações')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : provider.history.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.history,
                              size: 72, color: Color(0xFF8EC5FC)),
                          SizedBox(height: 18),
                          Text(
                            'Ainda não há avaliações salvas.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: provider.history.length,
                      itemBuilder: (context, index) {
                        final record = provider.history[index];
                        return Card(
                          child: ListTile(
                            title: Text(record.respondentName),
                            subtitle: Text(
                              '${record.riskLevel} • ${record.answeredQuestions} perguntas • ${_formatDate(record.completedAt)}',
                            ),
                            trailing: Text(record.score.toString()),
                          ),
                        );
                      },
                    ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
