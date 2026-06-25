import 'package:flutter/material.dart';
import '../../shared/widgets/section_card.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sobre o Projeto')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              SectionCard(
                title: 'Nossa missão',
                subtitle:
                    'Uma ferramenta acolhedora para mulheres em situação de violência.',
                child: const Text(
                  'Este aplicativo foi desenvolvido para oferecer uma avaliação de risco acolhedora e segura. Ele fornece um fluxo claro, com etapas fáceis de seguir, e ajuda a identificar sinais de vulnerabilidade para sugerir apoio.',
                ),
              ),
              const SizedBox(height: 20),
              SectionCard(
                title: 'O que traz',
                subtitle:
                    'Principais recursos feitos para conforto e segurança.',
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Modo anônimo ou identificado'),
                    SizedBox(height: 8),
                    Text('• Fluxo por etapas com progresso claro'),
                    SizedBox(height: 8),
                    Text('• Histórico local de avaliações'),
                    SizedBox(height: 8),
                    Text('• Temática azul e visual calmo'),
                    SizedBox(height: 8),
                    Text('• Ajuda rápida e orientações de segurança'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
