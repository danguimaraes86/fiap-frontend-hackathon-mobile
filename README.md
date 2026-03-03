# FIAP Hackathon - MindEase Mobile

<div align="center">

_Aplicação Mobile desenvolvida com Flutter para gerenciamento de tarefas pessoais_

</div>

### 🎓 FIAP Grupo 39

| Nome                 | GitHub                                               |
| -------------------- | ---------------------------------------------------- |
| **Daniel Guimarães** | [@danguimaraes86](https://github.com/danguimaraes86) |

## 📖 Descrição

Aplicação multiplataforma desenvolvida com **Flutter** para gerenciamento de tarefas pessoais. O sistema oferece uma experiência nativa para **Android** e **Web**, com integração completa ao Firebase para autenticação e banco de dados em tempo real.

### 🏗️ Arquitetura

- **Flutter 3.41.1** com **Dart 3.10.8**, utilizando arquitetura orientada a **Views**, **Providers** e **Services**, promovendo separação clara de responsabilidades
- Gerenciamento de estado realizado com **Provider**, permitendo comunicação reativa entre componentes
- **Firebase** como Backend-as-a-Service:
  - **Authentication** com login e senha, utilizando **token** para controle de sessão
  - **Firestore** como banco de dados NoSQL com escuta em tempo real
- Suporte a **Android** e **Web** com código unificado
- Interface construída com **Material Design**, garantindo consistência visual e responsividade

## ✨ Funcionalidades

### ✅ Gerenciamento de Tarefas

- Criação, edição e exclusão de tarefas
- Controle de status: **Pendente**, **Em andamento** e **Concluída**
- Definição de prazo (data de vencimento) por tarefa
- Atualização em tempo real via Firestore

### 📊 Dashboard

- Visão geral das tarefas com resumo por status
- Modo foco para visualização simplificada
- Detalhes completos de tarefas diretamente no dashboard

### 🔍 Filtros e Visualização

- Listagem de tarefas com filtro por status
- Opção de exibir ou ocultar tarefas concluídas e pendentes
- Visualização detalhada de cada tarefa

### 🎨 Preferências do Usuário

- Tema **claro** e **escuro**
- Ativação/desativação do **modo foco**
- Controle de visibilidade por status de tarefa
- Preferências persistidas no Firestore por usuário

### 🔐 Segurança e Autenticação

- Firebase Authentication com email e senha
- Cadastro de novos usuários
- Sessões persistentes e seguras
- Logout protegido
- Redirecionamento automático com rotas protegidas

## 🛠️ Tecnologias Utilizadas

### 📱 Framework e Linguagem

| Tecnologia | Versão  | Descrição                                 |
| ---------- | ------- | ----------------------------------------- |
| Flutter    | ^3.41.1 | Framework multiplataforma (Android e Web) |
| Dart       | ^3.10.8 | Linguagem principal da aplicação          |

---

### 🎨 UI / UX

| Tecnologia      | Versão  | Descrição                                 |
| --------------- | ------- | ----------------------------------------- |
| Material Design | nativo  | Sistema de design integrado ao Flutter    |
| intl            | ^0.20.2 | Internacionalização e formatação de datas |

---

### 🔥 Backend / Integrações

| Tecnologia      | Versão | Descrição                          |
| --------------- | ------ | ---------------------------------- |
| firebase_core   | ^4.4.0 | Inicialização do Firebase          |
| firebase_auth   | ^6.1.4 | Autenticação de usuários           |
| cloud_firestore | ^6.1.2 | Banco de dados NoSQL em tempo real |
| http            | ^1.6.0 | Requisições HTTP                   |

---

### 🧩 Gerenciamento de Estado

| Tecnologia | Versão   | Descrição                                 |
| ---------- | -------- | ----------------------------------------- |
| provider   | ^6.1.5+1 | Gerenciamento de estado e injeção de deps |

---

### 🧪 Desenvolvimento e Qualidade

| Tecnologia    | Versão  | Descrição                                          |
| ------------- | ------- | -------------------------------------------------- |
| flutter_lints | ^6.0.0  | Análise estática e boas práticas                   |
| flutter_test  | nativo  | Testes de widget e unitários                       |
| mockito       | ^5.6.3  | Geração de mocks para isolamento de dependências   |
| build_runner  | ^2.11.1 | Geração automática de código mock (`*.mocks.dart`) |

## 📥 Como Clonar o Repositório

```bash
# Clone o repositório
git clone https://github.com/danguimaraes86/fiap-frontend-hackathon-mobile.git

# Entre no diretório do projeto
cd fiap-frontend-hackathon-mobile
```

## 🚀 Como Rodar o Projeto

### 📋 Pré-requisitos

Antes de iniciar o projeto, certifique-se de ter instalado:

- **Flutter SDK** (versão ^3.41.1)
- **Dart SDK** (versão ^3.10.8)
- **Android Studio** ou **VS Code** com extensão Flutter
- **JDK 17+** para builds Android

---

### 🔥 Configuração do Firebase

1. **Crie um projeto no Firebase**

   Acesse o [Firebase Console](https://console.firebase.google.com) e crie um novo projeto.

2. **Configure os serviços necessários**
   - **Authentication**: habilite o provedor **Email/Password**
   - **Firestore Database**: crie um banco de dados

3. **Adicione o app Android/Web no Firebase**
   - No painel do Firebase, adicione um **Android App** e/ou **Web App**
   - Baixe o arquivo `google-services.json` e coloque em `android/app/`
   - Baixe o arquivo `firebase.json` e coloque na raiz do projeto
   - Configure o arquivo `lib/configs/firebase_options.dart` com as credenciais do projeto

### 🔧 Instalação e Execução

```bash
# 1. Instale as dependências
flutter pub get

# 2. Execute a aplicação (Android)
flutter run

# 3. Execute a aplicação (Web)
flutter run -d chrome
```

## 🧪 Testes Unitários

A aplicação possui cobertura de testes unitários para todos os **Providers**, utilizando `flutter_test` e `mockito` para mock dos serviços.

### 📂 Estrutura dos Testes

```text
test/
└── providers/
    ├── authentication_provider_test.dart       # Testes do AuthenticationProvider
    ├── authentication_provider_test.mocks.dart # Mocks gerados para autenticação
    ├── task_provider_test.dart                 # Testes do TaskProvider
    ├── task_provider_test.mocks.dart           # Mocks gerados para tarefas
    ├── user_preferences_provider_test.dart     # Testes do UserPreferencesProvider
    └── user_preferences_provider_test.mocks.dart # Mocks gerados para preferências
```

### ✅ Cobertura dos Testes

| Provider                  | Arquivo de Teste                      | Descrição                                                        |
| ------------------------- | ------------------------------------- | ---------------------------------------------------------------- |
| `AuthenticationProvider`  | `authentication_provider_test.dart`   | Testa login, logout, cadastro e controle de sessão do usuário    |
| `TaskProvider`            | `task_provider_test.dart`             | Testa criação, edição, exclusão e listagem de tarefas            |
| `UserPreferencesProvider` | `user_preferences_provider_test.dart` | Testa leitura e atualização das preferências de tema e modo foco |

### 🛠️ Tecnologias de Teste

| Tecnologia   | Versão  | Descrição                                          |
| ------------ | ------- | -------------------------------------------------- |
| flutter_test | nativo  | Framework de testes integrado ao Flutter           |
| mockito      | ^5.6.3  | Geração de mocks para isolamento de dependências   |
| build_runner | ^2.11.1 | Geração automática de código mock (`*.mocks.dart`) |

### ▶️ Como Executar os Testes

```bash
# Executar todos os testes
flutter test

# Executar testes de um provider específico
flutter test test/providers/authentication_provider_test.dart
flutter test test/providers/task_provider_test.dart
flutter test test/providers/user_preferences_provider_test.dart

# Regenerar os arquivos de mock (após alterações nos serviços)
dart run build_runner build --delete-conflicting-outputs
```

## 📦 Scripts Disponíveis

| Comando                 | Descrição                                   |
| ----------------------- | ------------------------------------------- |
| `flutter pub get`       | Instala as dependências do projeto          |
| `flutter run`           | Executa a aplicação no dispositivo/emulador |
| `flutter run -d chrome` | Executa a aplicação no navegador (Web)      |
| `flutter build apk`     | Gera o build de produção para Android       |
| `flutter build web`     | Gera o build de produção para Web           |
| `flutter test`          | Executa os testes unitários e de widget     |

## 📁 Estrutura do Projeto

```text
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── configs/                     # Configurações da aplicação
│   ├── custom_theme.dart        # Definição de temas claro/escuro
│   ├── firebase_options.dart    # Configuração do Firebase
│   └── routes.dart              # Definição de rotas da aplicação
├── models/                      # Modelos de dados
│   ├── authentication_model.dart
│   ├── task_model.dart
│   ├── user_model.dart
│   └── user_preferences_model.dart
├── providers/                   # Gerenciamento de estado (Provider)
│   ├── authentication_provider.dart
│   ├── task_provider.dart
│   └── user_preferences_provider.dart
├── services/                    # Camada de serviços e integrações
│   ├── authentication_service.dart
│   ├── task_service.dart
│   ├── user_preferences_service.dart
│   ├── exceptions/              # Tratamento de exceções
│   └── utils/                   # Utilitários dos serviços
├── shared/                      # Componentes e utilitários compartilhados
│   ├── utils/                   # Funções utilitárias
│   └── widgets/                 # Widgets reutilizáveis
└── views/                       # Telas da aplicação
    ├── auth/                    # Telas de autenticação (login/cadastro)
    ├── dashboard/               # Dashboard com resumo das tarefas
    ├── home/                    # Tela inicial
    ├── task_details/            # Detalhes de uma tarefa
    ├── task_form/               # Formulário de criação/edição de tarefa
    ├── task_list/               # Listagem de tarefas
    └── user_preferences_form/   # Formulário de preferências do usuário

assets/
├── images/
│   ├── hero_banner.png
│   └── not_found.png
└── logos/
    ├── logo_desktop.png
    └── logo_mobile.png
```

## 🔗 Links Úteis

- [Flutter](https://flutter.dev/) - Framework multiplataforma
- [Dart](https://dart.dev/) - Linguagem de programação
- [Provider](https://pub.dev/packages/provider) - Gerenciamento de estado
- [Firebase](https://firebase.google.com/docs) - Backend-as-a-Service
- [Material Design](https://m3.material.io/) - Sistema de design
- [pub.dev](https://pub.dev/) - Repositório de pacotes Dart/Flutter

---

## 📄 Licença

Este projeto está licenciado sob a **[Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0)](https://creativecommons.org/licenses/by-nc/4.0/)**

### Você Pode

- **Compartilhar** — copiar e redistribuir o material
- **Adaptar** — remixar, transformar e criar a partir do material

### Condições

- **Uso não comercial** — o material não pode ser utilizado para fins comerciais
- **Atribuição** — você deve fornecer crédito apropriado e indicar se mudanças foram feitas

---

<div align="center">

### 🎓 Desenvolvido com ❤️ pelo FIAP Grupo 39

**Se este projeto foi útil, considere dar uma ⭐ no repositório!**

</div>
