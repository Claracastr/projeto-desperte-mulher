# Desperte Mulher - Questionário de Risco de Violência Doméstica

## 📋 Descrição Geral

**Desperte Mulher** é um aplicativo mobile desenvolvido em Flutter que implementa um questionário detalhado para avaliar o risco de violência doméstica. O aplicativo foi criado com foco em segurança, usabilidade e confidencialidade, permitindo que mulheres em situação de risco possam realizar uma auto-avaliação confidencial.

O aplicativo fornece um score de risco baseado nas respostas e oferece recursos de suporte, histórico de avaliações e informações de ajuda.

---

## 🎯 Objetivos Principais

1. **Avaliar Riscos**: Identificar e quantificar o nível de risco de violência doméstica através de um questionário estruturado
2. **Proteger Privacidade**: Permitir avaliações anônimas ou identificadas conforme preferência do usuário
3. **Oferecer Suporte**: Fornecer informações de ajuda e contatos de instituições de apoio
4. **Registrar Histórico**: Manter registro das avaliações realizadas para acompanhamento temporal
5. **Interface Intuitiva**: Garantir uma experiência amigável e segura

---

## 🏗️ Arquitetura e Estrutura do Projeto

### Estrutura de Diretórios

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── common/
│   ├── app_routes.dart          # Definição de rotas da aplicação
│   ├── route_manager.dart       # Gerenciador de navegação
│   └── storage_keys.dart        # Chaves para armazenamento local
│
├── core/
│   ├── app_routes.dart          # Rotas da aplicação
│   ├── app_theme.dart           # Temas da aplicação (claro/escuro)
│   ├── design_system.dart       # Sistema de design (cores, tipografia)
│   ├── data/
│   │   ├── local_database.dart  # Gerenciamento de banco de dados SQLite
│   │   └── questionnaire_data.dart # Dados estruturados do questionário
│   ├── models/
│   │   ├── answer.dart          # Modelo de resposta
│   │   ├── question.dart        # Modelo de pergunta
│   │   ├── evaluation_record.dart # Registro de avaliação
│   │   └── respondent.dart      # Dados do respondente
│   ├── providers/
│   │   └── questionnaire_provider.dart # State management com Provider
│   └── utils/
│
├── features/                     # Funcionalidades principais
│   ├── onboarding/              # Tela de boas-vindas
│   ├── questionnaire/           # Fluxo do questionário
│   ├── results/                 # Exibição de resultados
│   ├── history/                 # Histórico de avaliações
│   ├── help/                    # Informações de ajuda
│   ├── about/                   # Sobre o aplicativo
│   └── admin/                   # Dashboard administrativo
│
└── shared/
    └── widgets/                 # Componentes reutilizáveis
```

---

## 🔑 Componentes Principais

### 1. **Modelo de Dados** (`lib/core/models/`)

#### **Answer.dart**
- Representa uma opção de resposta
- Contém: `title` (texto da resposta) e `score` (pontuação associada)
- Implementa serialização JSON para persistência

#### **Question.dart**
- Representa uma pergunta do questionário
- Atributos: `id`, `stage` (fase do questionário), `text`, `answers`, `weight`, `selectedAnswer`
- Implementa cálculo de score ponderado
- Suporta serialização/desserialização JSON

#### **Questionnaire Stages**
O questionário é dividido em 4 etapas:
1. **Histórico de Violência** - Avalia agressões físicas, ameaças, abuso sexual
2. **Sobre o Agressor** - Analisa comportamento do agressor (drogas, saúde mental)
3. **Sobre Você** - Coleta informações demográficas
4. **Outras Informações** - Contexto adicional e circunstâncias

#### **Respondent.dart**
- Armazena dados pessoais do respondente
- Campos: nome, age, relacionamento com agressor, filhos
- Pode ser criado como anônimo

#### **EvaluationRecord.dart**
- Registra cada avaliação realizada
- Armazena: data, score final, respondent data, lista de respostas
- Persiste no banco de dados local

### 2. **Gerenciamento de Estado** (`QuestionnaireProvider`)

```dart
// Provider responsável por:
- Gerenciar perguntas e respostas
- Controlar navegação entre páginas
- Calcular scores
- Persistir progresso
- Manter histórico de avaliações
- Alternar modo anônimo/identificado
```

**Funcionalidades principais:**
- `startAnonymous()` - Inicia avaliação anônima
- `startIdentified()` - Inicia com identificação
- `goNextPage()` / `goPrevPage()` - Navegação entre páginas
- `totalScore` - Calcula score total
- `saveProgress()` - Salva progresso
- `clearProgress()` - Limpa avaliação

### 3. **Banco de Dados Local** (`LocalDatabase`)

- **Tecnologia**: SQLite com `sqflite`
- **Funcionalidades**:
  - Armazena histórico de avaliações
  - Persiste dados do respondente
  - Suporta sincronização
  - Permite busca e filtragem de registros históricos

### 4. **Dados do Questionário** (`questionnaire_data.dart`)

O questionário contém **30+ perguntas** estruturadas abordando:

#### **Etapa 1: Histórico de Violência**
- Ameaças com armas
- Agressões físicas específicas (queimadura, enforcamento, tiro, facada, etc.)
- Abuso sexual
- Controle coercitivo
- Medidas protetivas
- Escalação de violência

#### **Etapa 2: Sobre o Agressor**
- Abuso de álcool/drogas
- Problemas de saúde mental
- Histórico de suicídio
- Comportamentos de risco

#### **Etapa 3: Sobre Você**
- Dados demográficos
- Relacionamento com agressor
- Situação de moradia
- Suporte social

#### **Etapa 4: Outras Informações**
- Circunstâncias adicionais
- Contexto social

### 5. **Sistema de Pontuação**

Cada resposta possui um score:
- **0**: Sem risco
- **1**: Risco baixo
- **2**: Risco médio
- **3**: Risco alto

**Cálculo final:**
```
Score Total = Σ(resposta_score × resposta_weight) / max_score * 100
```

---

## 🎨 Interface e Navegação

### **Telas Principais**

#### 1. **Onboarding (`onboarding_page.dart`)**
- Primeira tela do aplicativo
- Apresenta o objetivo do questionário
- Botões: "Continuar Anônimo" e "Fazer Login"

#### 2. **Identificação (`identify_form_page.dart`)**
- Coleta dados pessoais do respondente
- Campos: Nome, Idade, Relacionamento, Filhos
- Validação de entrada
- Botão para prosseguir

#### 3. **Questionário (`questionnaire_page.dart`)**
- Exibe perguntas em páginas (4 perguntas por página)
- Seleção única de resposta por pergunta
- Indicador de progresso
- Botões: "Anterior" e "Próximo"
- Barra de progresso visual

#### 4. **Resultados (`result_page.dart`)**
- Exibe score final em escala visual
- Interpretação do risco
- Recomendações baseadas no score
- Botões de ação: "Salvar", "Compartilhar", "Voltar ao Início"

#### 5. **Histórico (`history_page.dart`)**
- Lista todas as avaliações anteriores
- Mostra data e score de cada avaliação
- Permite visualizar detalhes de avaliação anterior
- Opção de deletar registros

#### 6. **Ajuda (`help_page.dart`)**
- Informações sobre violência doméstica
- Sinais de alerta
- Dicas de segurança
- Números de contato de apoio

#### 7. **Sobre (`about_page.dart`)**
- Informações sobre o aplicativo
- Versão
- Créditos de desenvolvimento
- Política de privacidade

#### 8. **Admin Dashboard (`admin_dashboard_page.dart`)**
- Visualização de estatísticas
- Gerenciamento de questionários
- Acesso restrito com autenticação

---

## 🔄 Fluxo de Uso

```
┌─────────────────────────────────┐
│   Iniciar Aplicativo (main.dart)│
└────────────┬────────────────────┘
             │
             ▼
┌─────────────────────────────────┐
│   Onboarding Page               │
│  (Bem-vindo / Apresentação)     │
└────────────┬────────────────────┘
             │
        ┌────┴────┐
        │          │
        ▼          ▼
    ┌────────┐ ┌──────────────┐
    │Anônimo │ │Identificado  │
    └───┬────┘ └──────┬───────┘
        │             │
        └─────┬───────┘
              │
              ▼
   ┌──────────────────────────────┐
   │ Identificação Form           │
   │ (Nome, Idade, Dados Pessoais)│
   └────────────┬─────────────────┘
                │
                ▼
   ┌──────────────────────────────┐
   │ Questionário (4 etapas)      │
   │ - Histórico de Violência     │
   │ - Sobre o Agressor           │
   │ - Sobre Você                 │
   │ - Outras Informações         │
   └────────────┬─────────────────┘
                │
                ▼
   ┌──────────────────────────────┐
   │ Página de Resultados         │
   │ - Score Final                │
   │ - Interpretação de Risco     │
   │ - Recomendações              │
   └────────────┬─────────────────┘
                │
        ┌───────┴───────┐
        │               │
        ▼               ▼
   ┌────────┐    ┌──────────────┐
   │Histórico│    │Menu Principal│
   │         │    │              │
   └────────┘    └──────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
   ┌────────┐    ┌────────┐    ┌────────┐
   │ Ajuda  │    │ Sobre  │    │ Novo Q │
   └────────┘    └────────┘    └────────┘
```

---

## 🛠️ Tecnologias Utilizadas

### **Framework e Linguagem**
- **Flutter**: Framework mobile multiplataforma
- **Dart**: Linguagem de programação

### **Dependências Principais**

| Dependência | Versão | Propósito |
|---|---|---|
| `provider` | 6.0.5 | Gerenciamento de estado |
| `sqflite` | 2.2.8+1 | Banco de dados SQLite |
| `path_provider` | 2.0.17 | Acesso a caminhos de arquivo |
| `shared_preferences` | 2.2.3 | Armazenamento de preferências |
| `image_picker` | 1.1.2 | Seleção de imagens |
| `url_launcher` | 6.1.10 | Abrir URLs e fazer chamadas |
| `cupertino_icons` | 1.0.8 | Ícones iOS |

### **Requisitos**
- Flutter >= 3.6.0
- Dart >= 3.6.0
- Android API 21+
- iOS 11.0+

---

## 💾 Persistência de Dados

### **Armazenamento Local**

1. **SQLite Database**
   - Armazena histórico de avaliações
   - Dados do respondente
   - Respostas do questionário
   - Sincronização automática

2. **Shared Preferences**
   - Preferências do usuário
   - Tema (claro/escuro)
   - Último respondente utilizado
   - Configurações locais

3. **Segurança**
   - Dados armazenados localmente no dispositivo
   - Nenhuma transmissão de dados para servidor externo (por padrão)
   - Opção de limpeza de dados

---

## 🎨 Design System

### **Paleta de Cores**

```dart
Cores Primárias:
- Roxo Principal: #7B2CBF
- Roxo Escuro: #5A189A
- Rosa: #C7157F

Cores Secundárias:
- Cinza Claro: #F5F5F5
- Cinza Médio: #E0E0E0
- Cinza Escuro: #424242

Cores de Feedback:
- Sucesso: #4CAF50
- Aviso: #FFC107
- Erro: #F44336
```

### **Tipografia**

- **Fonte Principal**: Roboto (padrão Material Design)
- **Tamanhos**:
  - Títulos: 32sp - 24sp
  - Subtítulos: 20sp - 18sp
  - Corpo: 16sp - 14sp
  - Pequeno: 12sp

### **Tema**

- **Tema Claro**: Fundo branco, texto escuro
- **Tema Escuro**: Fundo escuro (#121212), texto claro
- **Modo Sistema**: Respeita preferência do dispositivo

---

## 📊 Estatísticas de Risco

### **Interpretação de Scores**

| Intervalo | Classificação | Ação Recomendada |
|---|---|---|
| 0-20 | Risco Baixo | Vigilância |
| 21-40 | Risco Moderado | Procurar apoio |
| 41-60 | Risco Intermediário | Buscar ajuda profissional |
| 61-80 | Risco Alto | Contato imediato com instituições |
| 81-100 | Risco Muito Alto | Ação urgente necessária |

---

## 🔐 Segurança e Privacidade

### **Medidas de Segurança Implementadas**

1. **Modo Anônimo**
   - Avaliações sem identificação
   - Não conecta a nenhum nome ou dados pessoais
   - Historicamente separado do modo identificado

2. **Criptografia Local**
   - Dados sensíveis armazenados de forma segura
   - Banco de dados local protegido

3. **Sem Transmissão Externa**
   - Nenhuma conexão com servidores por padrão
   - Dados permanecem no dispositivo

4. **Limpeza de Dados**
   - Opção para deletar histórico
   - Resetar aplicativo completamente

---

## 🚀 Como Executar

### **Pré-requisitos**
- Flutter SDK instalado
- Android Studio ou Xcode configurados
- Um emulador ou dispositivo físico

### **Passo 1: Clonar o Repositório**
```bash
git clone <repository-url>
cd quiz_flutter
```

### **Passo 2: Instalar Dependências**
```bash
flutter pub get
```

### **Passo 3: Executar Aplicativo**

**No Emulador/Dispositivo Android:**
```bash
flutter run
```

**No iOS:**
```bash
flutter run -d ios
```

**Na Web:**
```bash
flutter run -d chrome
```

### **Passo 4: Build para Produção**

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

---

## 📁 Dados Mock

O projeto inclui dados mock em `assets/Mock/`:

```
assets/Mock/
├── page1.json     # Perguntas - Etapa 1
├── page2.json     # Perguntas - Etapa 2
└── page3.json     # Perguntas - Etapa 3
```

Estes arquivos contêm as estruturas de perguntas e respostas para testes.

---

## 🧪 Testes e Validação

### **Componentes Testáveis**

1. **Modelos de Dados**
   - Serialização/Desserialização JSON
   - Cálculo de scores

2. **Provider (State Management)**
   - Transição entre páginas
   - Cálculo de progresso
   - Persistência de dados

3. **Database**
   - Inserção e recuperação de registros
   - Filtragem de histórico

### **Como Executar Testes**
```bash
flutter test
```

---

## 📱 Platforms Suportadas

- ✅ **Android** (API 21+)
- ✅ **iOS** (11.0+)
- ✅ **Web** (Chrome, Firefox, Safari)
- ✅ **Windows**
- ✅ **macOS**
- ✅ **Linux**

---

## 🤝 Recursos e Contatos de Ajuda

O aplicativo inclui uma seção "Ajuda" com informações sobre:

- **Números de Emergência**: 190 (Polícia)
- **Denúncia**: Delegacias especializadas
- **Apoio Psicológico**: Centros de referência
- **Informações Legais**: Direitos e proteções
- **Redes de Apoio**: Organizações parceiras

---

## 📝 Estrutura do Questionário Detalhada

### **Pergunta 1-8: Histórico de Violência**
- Ameaças com armas (pontuação 3)
- Agressões físicas específicas (1-3 pontos cada)
- Necessidade de atendimento médico (2-3 pontos)
- Abuso sexual (3 pontos)
- Controle coercitivo (2 pontos)
- Comportamentos controladores (1-2 pontos)
- Medidas protetivas (2-3 pontos)
- Escalação de violência (3 pontos)

### **Pergunta 9-15: Sobre o Agressor**
- Abuso de substâncias (2-3 pontos)
- Saúde mental (2-3 pontos)
- Ideação suicida (3 pontos)
- Comportamento violento anterior
- Acesso a armas
- Histórico de prisões

### **Pergunta 16-25: Sobre Você**
- Idade (fator de risco)
- Relacionamento com agressor
- Situação de moradia
- Dependência financeira
- Suporte social
- Acesso a recursos
- Situação de saúde
- Responsabilidades (filhos)

### **Pergunta 26+: Outras Informações**
- Conhecimento do agressor sobre locais frequentados
- Capacidade de fuga
- Recursos disponíveis
- Risco imediato

---

## 🔄 Fluxo de Desenvolvimento

### **Etapas Implementadas**

1. ✅ **Estrutura Base**
   - Configuração inicial do Flutter
   - Criação de rotas e navegação

2. ✅ **Modelos de Dados**
   - Answer, Question, Respondent
   - EvaluationRecord, QuestionnaireStage

3. ✅ **State Management**
   - QuestionnaireProvider com Provider
   - Gerenciamento de perguntas e respostas

4. ✅ **Interface de Usuário**
   - 8 telas principais (Onboarding, Questionário, Resultados, etc.)
   - Design System implementado

5. ✅ **Persistência de Dados**
   - SQLite integrado
   - SharedPreferences para configurações

6. ✅ **Questionário Completo**
   - 30+ perguntas estruturadas
   - 4 etapas temáticas

7. ✅ **Histórico e Análise**
   - Armazenamento de avaliações
   - Visualização de histórico

8. ✅ **Dashboard Admin**
   - Visualização de estatísticas

---

## 📊 Diagrama de Classes (Principais)

```
Question
├── id: String
├── stage: QuestionnaireStage
├── text: String
├── answers: List<Answer>
├── weight: int
├── selectedAnswer: Answer?
└── score: int (calculado)

Answer
├── title: String
└── score: int

Respondent
├── name: String
├── age: int
├── relationship: String
├── children: int
└── anonymous: bool

EvaluationRecord
├── id: String
├── date: DateTime
├── score: int
├── respondent: Respondent
└── answers: List<Answer>

QuestionnaireProvider (ChangeNotifier)
├── questions: List<Question>
├── respondent: Respondent
├── anonymous: bool
├── currentIndex: int
├── totalScore: int
└── methods: goNextPage(), startAnonymous(), etc.
```

---

## 🎓 Aprendizados e Boas Práticas

### **Padrões Utilizados**

1. **Provider Pattern**: Gerenciamento de estado eficiente
2. **Model-View-ViewModel**: Separação de responsabilidades
3. **Factory Pattern**: Serialização de dados (fromJson, toJson)
4. **Singleton**: Banco de dados

### **Boas Práticas**

- ✅ Comentários em português explicando cada classe
- ✅ Nomes descritivos em variáveis e funções
- ✅ Separação de responsabilidades
- ✅ Reutilização de componentes
- ✅ Validação de entrada de dados
- ✅ Tratamento de exceções

---

## 🔮 Possíveis Melhorias Futuras

1. **Backend Integration**
   - Sincronização com servidor
   - Autenticação segura
   - Análise centralizada

2. **Features Avançadas**
   - Gráficos de tendências
   - Exportação de relatórios (PDF)
   - Notificações de apoio
   - Chat com assistentes

3. **Segurança**
   - Biometria (fingerprint, face)
   - Criptografia ponta a ponta
   - Modo "Emergência" discreto

4. **Localização**
   - Tradução para múltiplos idiomas
   - Adaptação regional

5. **Performance**
   - Offline-first
   - Sincronização inteligente
   - Cache otimizado

---

## 📧 Suporte e Contato

Para dúvidas ou sugestões sobre o desenvolvimento:

- **Email**: desenvolvimento@despertermulher.com
- **Issues**: Reportar bugs via GitHub
- **Documentação**: [Wiki do Projeto]

---

## ✅ Checklist de Apresentação

- [ ] Executar aplicativo no dispositivo/emulador
- [ ] Realizar fluxo completo: Onboarding → Questionário → Resultados
- [ ] Demonstrar modo anônimo vs. identificado
- [ ] Mostrar histórico de avaliações
- [ ] Exibir seção de Ajuda
- [ ] Demonstrar tema claro/escuro
- [ ] Explicar sistema de pontuação
- [ ] Mostrar código-fonte principal (Provider, Models)
- [ ] Discutir medidas de segurança e privacidade
- [ ] Apresentar possíveis melhorias futuras

---

## 📄 Licença

Este projeto é desenvolvido com propósito educacional e de apoio social.

---

**Versão**: 1.0.0  
**Última Atualização**: Junho 2026  
**Desenvolvedor**: Silvano Malfatti
