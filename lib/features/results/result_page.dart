import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../common/app_routes.dart';
import '../../core/providers/questionnaire_provider.dart';
import '../../core/models/question.dart';
import '../../shared/widgets/risk_meter.dart';
import '../../shared/widgets/section_card.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QuestionnaireProvider>();
    final score = provider.totalScore;
    final risk = provider.riskLevel;
    final answered = provider.answeredQuestions;

    return Scaffold(
      appBar: AppBar(title: const Text('Resultado')),
      body: SafeArea(
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: const Duration(milliseconds: 700),
          builder: (context, opacity, child) {
            return Opacity(
              opacity: opacity,
              child: child,
            );
          },
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
                  Text('Resultado final',
                      style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 12),
                  Text(
                    'Esse resultado é uma orientação inicial. Se você estiver em risco, busque ajuda imediata.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: RiskMeter(
                          percent: provider.riskPercent,
                          status: risk,
                          label: provider.riskTitle,
                          color: provider.riskColor,
                          icon: provider.riskIcon,
                          subtitle: '${(provider.riskPercent * 100).round()}%',
                          heroTag: 'risk-meter',
                          size: 170,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        flex: 6,
                        child: SectionCard(
                          title: 'Detalhes da avaliação',
                          subtitle: 'Resumo completo do seu risco atual',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSummaryTile(
                                  'Modo',
                                  provider.anonymous
                                      ? 'Anônimo'
                                      : 'Identificado'),
                              _buildSummaryTile(
                                  'Nome',
                                  provider.anonymous
                                      ? 'Anônimo'
                                      : provider.respondent.name),
                              _buildSummaryTile('Perguntas respondidas',
                                  '$answered / ${provider.totalQuestions}'),
                              _buildSummaryTile('Pontuação', '$score'),
                              _buildSummaryTile('Nível de risco', risk),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  if (risk == 'Baixo')
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.emoji_emotions,
                              color: Color(0xFF4DD0E1)),
                          const SizedBox(width: 10),
                          const Text(
                            'Parabéns! Risco baixo encontrado.',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A374D),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(Icons.celebration,
                              color: Color(0xFF4DD0E1)),
                        ],
                      ),
                    ),
                  SectionCard(
                    title: 'O que fazer agora',
                    subtitle: 'Passos práticos para proteção e apoio.',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            '• Salve estas informações em um lugar seguro.'),
                        const SizedBox(height: 8),
                        const Text(
                            '• Compartilhe com alguém de confiança ou com serviços de apoio.'),
                        const SizedBox(height: 8),
                        const Text(
                            '• Em situação de perigo, procure imediatamente uma autoridade ou serviço de proteção.'),
                        const SizedBox(height: 16),
                        Text(
                          provider.riskLevel == 'Crítico'
                              ? 'Recomendação: Considere entrar em contato com serviços especializados imediatamente.'
                              : 'Recomendação: Mantenha a rede de apoio informada e monitore sua segurança.',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: provider.riskColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  SectionCard(
                    title: 'Fatores que mais contribuíram',
                    subtitle: 'Principais itens que afetaram sua pontuação',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: provider.topContributors(3).map((item) {
                        final Question q = item['question'] as Question;
                        final int contrib = item['contribution'] as int;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(q.text)),
                              const SizedBox(width: 12),
                              Text('$contrib',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.support_agent),
                          label: const Text('Buscar Ajuda'),
                          onPressed: () async {
                            final uri = Uri.parse(
                                'https://www.gov.br/pt-br/servicos/combate-a-violencia-contra-a-mulher');
                            if (!await launchUrl(uri,
                                mode: LaunchMode.externalApplication)) {
                              debugPrint('Não foi possível abrir a URL');
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            await provider.clearProgress();
                            if (!context.mounted) return;
                            Navigator.pushReplacementNamed(
                                context, AppRoutes.home);
                          },
                          child: const Text('Refazer'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.home);
                    },
                    child: const Text('Voltar para início'),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.history);
                    },
                    child: const Text('Ver histórico de avaliações'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          Flexible(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
