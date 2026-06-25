import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common/app_routes.dart';
import '../../core/providers/questionnaire_provider.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<QuestionnaireProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFEBF4FF),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF8EC5FC), Color(0xFFA8DADC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    'Análise de Risco',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Responda com segurança. Suas respostas ajudam a identificar sinais de vulnerabilidade e encontrar o apoio certo.',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Text(
                          'Calmo, seguro e acolhedor',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          const BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 16,
                            offset: Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bem-vinda',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Escolha o modo que traz mais conforto para você e siga o fluxo passo a passo.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 24),
                          _buildStepItem(
                            context,
                            icon: Icons.lock_outline,
                            title: 'Modo anônimo',
                            description:
                                'Responda sem precisar se identificar.',
                          ),
                          const SizedBox(height: 12),
                          _buildStepItem(
                            context,
                            icon: Icons.person_outline,
                            title: 'Modo identificado',
                            description:
                                'Preencha seus dados para um acolhimento mais personalizado.',
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            onPressed: () {
                              provider.startAnonymous();
                              Navigator.pushReplacementNamed(
                                  context, AppRoutes.questionnaire);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8EC5FC),
                              foregroundColor: const Color(0xFF343A40),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Responder anonimamente'),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.identify);
                            },
                            style: OutlinedButton.styleFrom(
                              foregroundColor: const Color(0xFF343A40),
                              side: const BorderSide(color: Color(0xFF8EC5FC)),
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child:
                                const Text('Me identificar antes de iniciar'),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.help),
                            child: const Text('Ajuda'),
                          ),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, AppRoutes.about),
                            child: const Text('Sobre'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepItem(BuildContext context,
      {required IconData icon,
      required String title,
      required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFE6F2FF),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(12),
          child: Icon(icon, color: const Color(0xFF2C7BE5), size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(description, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
      ],
    );
  }
}
