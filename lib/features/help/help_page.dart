import 'package:flutter/material.dart';
import '../../shared/widgets/section_card.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ajuda')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              SectionCard(
                title: 'Como usar',
                subtitle: 'Orientações para seguir o fluxo com tranquilidade.',
                child: const Text(
                  'Responda ao questionário com calma. Você pode encerrar a qualquer momento e seus dados são armazenados localmente no dispositivo.',
                ),
              ),
              const SizedBox(height: 20),
              SectionCard(
                title: 'Perguntas frequentes',
                subtitle: 'Dúvidas rápidas sobre privacidade e uso.',
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('1. Posso responder anonimamente?'),
                    SizedBox(height: 6),
                    Text(
                        'Sim, basta escolher a opção “Responder anonimamente”.'),
                    SizedBox(height: 12),
                    Text('2. Meus dados são enviados para a internet?'),
                    SizedBox(height: 6),
                    Text(
                        'Não. As informações ficam apenas no seu dispositivo.'),
                    SizedBox(height: 12),
                    Text('3. Como funciona o resultado?'),
                    SizedBox(height: 6),
                    Text(
                        'A pontuação indica nível de risco e serve como orientação inicial.'),
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
