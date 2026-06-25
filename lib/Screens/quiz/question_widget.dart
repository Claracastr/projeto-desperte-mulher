/*
Nome: QuestionWidget
Descrição: classe responsavel por modelar um widget para aprsentar uma questão com pergunta e respostas
Autor: Silvano Malfatti
Data: 13/06/2026
 */

import 'package:flutter/material.dart';
import '../../Models/answer.dart';
import '../../Models/question.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;
  final ValueChanged<Question>? onChanged;

  const QuestionWidget({
    super.key,
    required this.question,
    this.onChanged,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  Answer? _selectedAnswer;
  late Set<Answer> _selectedAnswers;

  @override
  void initState() {
    super.initState();
    _selectedAnswer = widget.question.selectedAnswer;
    _selectedAnswers = widget.question.selectedAnswers.toSet();
  }

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.question != widget.question) {
      _selectedAnswer = widget.question.selectedAnswer;
      _selectedAnswers = widget.question.selectedAnswers.toSet();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 12),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildQuestionTitle(),
            const SizedBox(height: 10),
            Text(
              widget.question.multipleSelection
                  ? 'Selecione todas as opções aplicáveis.'
                  : 'Escolha a alternativa que melhor descreve sua situação.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            _buildAnswersList(),
          ],
        ),
      ),
    );
  }

  void _selectAnswer(Answer answer) {
    setState(() {
      _selectedAnswer = answer;
      widget.question.selectedAnswer = answer;
      widget.question.selectedAnswers = [];
    });
    widget.onChanged?.call(widget.question);
  }

  void _toggleAnswer(Answer answer) {
    setState(() {
      if (_selectedAnswers.contains(answer)) {
        _selectedAnswers.remove(answer);
      } else {
        _selectedAnswers.add(answer);
      }
      widget.question.selectedAnswers = _selectedAnswers.toList();
      widget.question.selectedAnswer = null;
    });
    widget.onChanged?.call(widget.question);
  }

  Widget _buildQuestionTitle() {
    return Text(
      widget.question.title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAnswersList() {
    return Column(
      children: widget.question.answers
          .map((answer) => widget.question.multipleSelection
              ? _buildCheckboxItem(answer)
              : _buildRadioItem(answer))
          .toList(),
    );
  }

  Widget _buildRadioItem(Answer answer) {
    return RadioListTile<Answer>(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(answer.title),
      value: answer,
      groupValue: _selectedAnswer,
      onChanged: (value) {
        if (value != null) {
          _selectAnswer(value);
        }
      },
    );
  }

  Widget _buildCheckboxItem(Answer answer) {
    return CheckboxListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(answer.title),
      value: _selectedAnswers.contains(answer),
      onChanged: (_) => _toggleAnswer(answer),
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
