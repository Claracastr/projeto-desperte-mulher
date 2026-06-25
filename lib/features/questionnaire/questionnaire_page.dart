import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_routes.dart';
import '../../core/models/question.dart';
import '../../core/providers/questionnaire_provider.dart';
import '../../shared/widgets/risk_meter.dart';
import '../../core/design_system.dart';

class QuestionnairePage extends StatelessWidget {
  const QuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionnaireProvider>();
    final stage = provider.currentStage;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionário de Avaliação'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, AppRoutes.history),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFF5F7FA), Color(0xFFE9F5FF)],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildStageHeader(context, stage, provider),
                const SizedBox(height: 18),
                Expanded(
                  child: LayoutBuilder(builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 700;
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      child: SingleChildScrollView(
                        key: ValueKey(provider.currentPageIndex),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: isWide ? 40 : 0, vertical: 8),
                          child: Column(
                            children: provider.questionsForCurrentPage
                                .asMap()
                                .entries
                                .map((entry) {
                              final q = entry.value;
                              return QuestionCard(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 14),
                                color: DSWidgets.questionCardDecoration().color,
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Text(
                                        'Pergunta ${provider.questions.indexOf(q) + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                                    const SizedBox(height: 8),
                                    Text(q.text,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    const SizedBox(height: 12),
                                    ...q.answers.map((answer) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 6),
                                          child: SelectableOption(
                                            selected:
                                                q.selectedAnswer == answer,
                                            onTap: () => provider
                                                .selectAnswerFor(q, answer),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                    child: Text(answer.label,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge)),
                                                const SizedBox(width: 8),
                                                Text('${answer.score}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: provider.currentPageIndex > 0
                            ? provider.goPrevPage
                            : null,
                        child: const Text('Voltar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: provider.canContinuePage
                            ? () async {
                                if (provider.currentPageIndex ==
                                    provider.pageCount - 1) {
                                  await provider.submitEvaluation();
                                  if (!context.mounted) return;
                                  Navigator.pushReplacementNamed(
                                      context, AppRoutes.result);
                                } else {
                                  await provider.goNextPage();
                                }
                              }
                            : null,
                        child: Text(
                            provider.currentPageIndex == provider.pageCount - 1
                                ? 'Finalizar'
                                : 'Avançar'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed:
                      provider.isSavingDraft ? null : provider.saveProgress,
                  child: Text(provider.isSavingDraft
                      ? 'Salvando progresso…'
                      : 'Salvar progresso'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStageHeader(BuildContext context, QuestionnaireStage stage,
      QuestionnaireProvider provider) {
    final progressValue = provider.answeredQuestions / provider.totalQuestions;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 420),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 18),
      decoration: BoxDecoration(
        color: const Color(0xFF081C3A),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(56),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Titles
          Text('Análise de Risco - ARPAX',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text('Formulário Nacional de Avaliação de Risco - FONAR',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white70)),
          const SizedBox(height: 4),
          Text('Violência Doméstica e Familiar Contra a Mulher',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white70)),
          const SizedBox(height: 12),

          // Alert message (centered)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: DSColors.accent.withAlpha(31)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.warning_amber_rounded,
                    color: Colors.amber[300], size: 28),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    'Atenção: esta análise tem caráter informativo e não substitui a avaliação da rede de proteção à mulher. Em casos de violência familiar, é indispensável procurar os serviços especializados. Mesmo que o Risco seja Baixo, ele Existe!',
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Steps (1..5) in white circles with subtle hover/transition
          LayoutBuilder(builder: (context, constraints) {
            final stepCount = 5;
            final current =
                (provider.currentStageIndex).clamp(0, stepCount - 1);
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              children: List.generate(stepCount, (i) {
                final isActive = i == current;
                return MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeOutCubic,
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                  color: DSColors.primary.withAlpha(46),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4))
                            ]
                          : [
                              BoxShadow(
                                  color: Colors.black.withAlpha(20),
                                  blurRadius: 6,
                                  offset: const Offset(0, 3))
                            ],
                      border: isActive
                          ? Border.all(color: DSColors.primary, width: 2)
                          : null,
                    ),
                    child: Center(
                      child: Text('${i + 1}',
                          style: TextStyle(
                            color: isActive
                                ? DSColors.primary
                                : DSColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                  ),
                );
              }),
            );
          }),

          const SizedBox(height: 12),

          // Progress bar with gradient
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: progressValue.clamp(0.0, 1.0)),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, animated, child) {
              return Container(
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(20),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: LayoutBuilder(builder: (context, box) {
                  return Stack(children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      width: box.maxWidth * animated,
                      decoration: BoxDecoration(
                        gradient: DSWidgets.progressGradient,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ]);
                }),
              );
            },
          ),

          const SizedBox(height: 10),

          // Remaining and risk label below progress (centered)
          Column(
            children: [
              Text('${provider.remainingQuestions} perguntas restantes',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.white70)),
              const SizedBox(height: 6),
              Text(provider.riskTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: provider.riskColor, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 12),

          // Small RiskMeter centered
          Center(
            child: RiskMeter(
              percent: provider.riskPercent,
              status: provider.riskLevel,
              label: 'Risco atual',
              color: provider.riskColor,
              icon: provider.riskIcon,
              subtitle: '${(provider.riskPercent * 100).round()}%',
              heroTag: 'risk-meter',
              size: 110,
            ),
          ),
        ],
      ),
    );
  }

  // Chip builder removed — styling handled by design system components.
}
