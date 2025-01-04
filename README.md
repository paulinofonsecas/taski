# Taski

Um aplicativo móvel para gerenciamento de tarefas, construído com uma abordagem de arquitetura limpa.

## Tecnologias Utilizadas

- **Flutter:** 3.27.0
- **Dart:** 3.6.0
- **bloc:** 8.1.4
- **either_dart:** 1.0.0
- **equatable:** 2.0.7
- **flutter_svg:** 2.0.16
- **get_it:** 8.0.3
- **google_fonts:** 6.2.1
- **mocktail:** 1.0.4
- **path:** 1.9.0
- **path_provider:** 2.1.5
- **provider:** 6.1.2
- **sqflite:** 2.4.1

## Primeiros Passos

### Pré-requisitos

Antes de começar, certifique-se de que você tem o seguinte instalado:

- **Flutter SDK:**  [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)
- **Dart SDK:** Incluído no Flutter SDK


### Executando a Aplicação

Para executar a aplicação, siga estes passos:

1. **Clone o repositório:**

    ```bash
    git clone https://github.com/paulinofonsecas/taski
    cd taski
    ```

2. **Instale as dependências:**

    ```bash
    flutter pub get

3. **Executando Testes:**

    ```bash
    flutter test
    ```

4. **Execute a aplicação:**

    ```bash
    flutter run -t lib/main_development.dart
    ```

    Este comando irá compilar a aplicação e iniciá-la no dispositivo ou emulador escolhido.

### Executando em Diferentes Ambientes

O projeto inclui arquivos main diferentes para os diversos ambientes. Se você deseja utilizar um ambiente específico, execute com:

```bash
flutter run --flavor development -t lib/main_development.dart
```

```bash
flutter run --flavor staging -t lib/main_staging.dart
```

```bash
flutter run --flavor production -t lib/main_production.dart
```

**Observação:** Para iOS, é necessário abrir o projeto usando o `.xcworkspace` e, em seguida, escolher o esquema que você deseja executar, sendo eles: development, staging e production.

### Flavors do Projeto

Este projeto está configurado com três "build flavors", cada um representando um ambiente diferente:

- **development:** Para desenvolvimento e depuração, geralmente utiliza uma URL/API diferente.
- **staging:** Para testes e homologação, geralmente utiliza uma API de staging.
- **production:** Para a versão final de produção, utiliza a API de produção.
