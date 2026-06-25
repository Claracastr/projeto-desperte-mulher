import '../models/answer.dart';
import '../models/question.dart';

class QuestionnaireData {
  static final questions = <Question>[
    Question(
      id: '1',
      stage: QuestionnaireStage.history,
      text:
          'O(A) agressor(a) já ameaçou você ou algum familiar com a finalidade de atingi-la?',
      answers: const [
        Answer(label: 'Sim, utilizando arma de fogo', score: 3),
        Answer(label: 'Sim, utilizando faca', score: 3),
        Answer(label: 'Sim, de outra forma', score: 2),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '2',
      stage: QuestionnaireStage.history,
      text:
          'O(A) agressor(a) já praticou alguma dessas agressões físicas contra você?',
      answers: const [
        Answer(label: 'Queimadura', score: 2),
        Answer(label: 'Enforcamento', score: 2),
        Answer(label: 'Sufocamento', score: 2),
        Answer(label: 'Estrangulamento', score: 2),
        Answer(label: 'Tiro', score: 3),
        Answer(label: 'Afogamento', score: 2),
        Answer(label: 'Facada', score: 3),
        Answer(label: 'Paulada', score: 1),
        Answer(label: 'Soco', score: 1),
        Answer(label: 'Chute', score: 1),
        Answer(label: 'Tapa', score: 1),
        Answer(label: 'Empurrão', score: 1),
        Answer(label: 'Puxão de cabelo', score: 1),
        Answer(label: 'Outra', score: 1),
        Answer(label: 'Nenhuma agressão física', score: 0),
      ],
    ),
    Question(
      id: '3',
      stage: QuestionnaireStage.history,
      text:
          'Você necessitou de atendimento médico ou internação após algumas dessas agressões?',
      answers: const [
        Answer(label: 'Atendimento médico', score: 2),
        Answer(label: 'Internação', score: 3),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '4',
      stage: QuestionnaireStage.history,
      text:
          'O(A) agressor(a) já obrigou você a ter relações sexuais ou praticar atos sexuais contra sua vontade?',
      answers: const [
        Answer(label: 'Sim', score: 3),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '5',
      stage: QuestionnaireStage.history,
      text:
          'O(A) agressor(a) persegue você, demonstra ciúme excessivo ou tenta controlar sua vida?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '6',
      stage: QuestionnaireStage.history,
      text: 'O(A) agressor(a) já teve algum destes comportamentos?',
      answers: const [
        Answer(label: '"Se não for minha, não será de mais ninguém"', score: 2),
        Answer(label: 'Perseguiu ou vigiou você', score: 2),
        Answer(label: 'Proibiu contato com familiares', score: 2),
        Answer(label: 'Proibiu trabalhar ou estudar', score: 2),
        Answer(label: 'Ligações ou mensagens insistentes', score: 1),
        Answer(label: 'Controle financeiro', score: 2),
        Answer(label: 'Outros comportamentos controladores', score: 2),
        Answer(label: 'Nenhum', score: 0),
      ],
    ),
    Question(
      id: '7A',
      stage: QuestionnaireStage.history,
      text:
          'Você já registrou ocorrência policial ou pediu medida protetiva envolvendo esse agressor?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 1),
      ],
    ),
    Question(
      id: '7B',
      stage: QuestionnaireStage.history,
      text: 'O(A) agressor(a) já descumpriu medida protetiva?',
      answers: const [
        Answer(label: 'Sim', score: 3),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '8',
      stage: QuestionnaireStage.history,
      text:
          'As agressões ou ameaças se tornaram mais frequentes ou mais graves?',
      answers: const [
        Answer(label: 'Sim', score: 3),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '9',
      stage: QuestionnaireStage.aggressor,
      text: 'O(A) agressor(a) faz uso abusivo de:',
      answers: const [
        Answer(label: 'Álcool', score: 2),
        Answer(label: 'Drogas', score: 3),
        Answer(label: 'Medicamentos', score: 2),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '10',
      stage: QuestionnaireStage.aggressor,
      text: 'Possui doença mental comprovada?',
      answers: const [
        Answer(label: 'Sim e usa medicação', score: 2),
        Answer(label: 'Sim e não usa medicação', score: 3),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '11',
      stage: QuestionnaireStage.aggressor,
      text: 'Já tentou suicídio ou falou em suicidar-se?',
      answers: const [
        Answer(label: 'Sim', score: 3),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '12',
      stage: QuestionnaireStage.aggressor,
      text: 'Possui dificuldades financeiras ou desemprego?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '13',
      stage: QuestionnaireStage.aggressor,
      text: 'Possui arma ou acesso fácil a arma?',
      answers: const [
        Answer(label: 'Usou arma', score: 3),
        Answer(label: 'Ameaçou usar', score: 3),
        Answer(label: 'Tem fácil acesso', score: 2),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '14',
      stage: QuestionnaireStage.aggressor,
      text: 'Já ameaçou ou agrediu:',
      answers: const [
        Answer(label: 'Filhos', score: 3),
        Answer(label: 'Familiares', score: 2),
        Answer(label: 'Amigos', score: 2),
        Answer(label: 'Colegas de trabalho', score: 2),
        Answer(label: 'Outras pessoas', score: 2),
        Answer(label: 'Animais', score: 2),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '15',
      stage: QuestionnaireStage.aboutYou,
      text:
          'Você se separou recentemente ou manifestou intenção de se separar?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '16',
      stage: QuestionnaireStage.aboutYou,
      text: 'Você tem filhos?',
      answers: const [
        Answer(label: 'Sim com o agressor', score: 2),
        Answer(label: 'Sim de outro relacionamento', score: 1),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '17',
      stage: QuestionnaireStage.aboutYou,
      text: 'Existe conflito relacionado à guarda, visitas ou pensão?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '18',
      stage: QuestionnaireStage.aboutYou,
      text: 'Seus filhos já presenciaram violência?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '19',
      stage: QuestionnaireStage.aboutYou,
      text: 'Você sofreu violência durante a gravidez ou após o parto?',
      answers: const [
        Answer(label: 'Sim', score: 3),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '20',
      stage: QuestionnaireStage.aboutYou,
      text: 'Está grávida ou teve bebê nos últimos 18 meses?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '21',
      stage: QuestionnaireStage.aboutYou,
      text: 'As ameaças aumentaram por causa de um novo relacionamento?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '22',
      stage: QuestionnaireStage.aboutYou,
      text: 'Possui deficiência ou doença degenerativa?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '23',
      stage: QuestionnaireStage.aboutYou,
      text: 'Cor/Raça:',
      answers: const [
        Answer(label: 'Branca', score: 0),
        Answer(label: 'Preta', score: 0),
        Answer(label: 'Parda', score: 0),
        Answer(label: 'Amarela/Oriental', score: 0),
        Answer(label: 'Indígena', score: 0),
      ],
    ),
    Question(
      id: '24',
      stage: QuestionnaireStage.other,
      text: 'Você mora em local considerado de risco?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
        Answer(label: 'Não sei', score: 1),
      ],
    ),
    Question(
      id: '25',
      stage: QuestionnaireStage.other,
      text: 'Qual sua situação de moradia?',
      answers: const [
        Answer(label: 'Própria', score: 0),
        Answer(label: 'Alugada', score: 1),
        Answer(label: 'Cedida', score: 1),
      ],
    ),
    Question(
      id: '26',
      stage: QuestionnaireStage.other,
      text: 'Você é financeiramente dependente do agressor?',
      answers: const [
        Answer(label: 'Sim', score: 2),
        Answer(label: 'Não', score: 0),
      ],
    ),
    Question(
      id: '27',
      stage: QuestionnaireStage.other,
      text: 'Você aceita abrigamento temporário?',
      answers: const [
        Answer(label: 'Sim', score: 0),
        Answer(label: 'Não', score: 2),
      ],
    ),
  ];
}
