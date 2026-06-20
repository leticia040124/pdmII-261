# PDM II - Consumo de API e ListView Dinâmica (Flutter)

Aplicativo Flutter que consome a API pública [JSONPlaceholder](https://jsonplaceholder.typicode.com/users)
(`/users`) via `HTTP GET`, converte o JSON em uma lista de objetos `Usuario` e exibe os dados em uma
`ListView.builder` com cards estilizados.

## Funcionalidades

- Requisição HTTP GET com o pacote `http`
- Timeout de 10s e tratamento de erros (sem internet, erro de servidor, JSON inválido)
- Parsing do JSON para o modelo `Usuario` (`fromJson`)
- Indicador de carregamento (`CircularProgressIndicator`)
- Tela de erro amigável com botão "Tentar novamente"
- `ListView.builder` performático (renderiza só os itens visíveis)
- Pull-to-refresh (`RefreshIndicator`)
- Gerenciamento de estado com `setState` + `FutureBuilder`

## Estrutura do projeto

```
lib/
  main.dart                       # ponto de entrada do app
  models/
    usuario.dart                  # modelo + fromJson
  services/
    usuario_service.dart          # requisição HTTP e tratamento de erros
  screens/
    usuario_list_screen.dart      # tela com ListView, loading, erro e refresh
  widgets/
    usuario_card.dart             # card de exibição de cada usuário
```

## Como rodar

```bash
flutter pub get
flutter run
```

## Como subir este projeto para o repositório

Como este projeto foi gerado fora do GitHub, suba os arquivos para o seu repositório com:

```bash
cd pdmII-261
git init
git add .
git commit -m "Trabalho: consumo de API REST e ListView dinâmica em Flutter"
git branch -M main
git remote add origin https://github.com/leticia040124/pdmII-261.git
git push -u origin main
```

Se o repositório já tiver conteúdo (ex.: um README inicial), use antes:

```bash
git pull origin main --allow-unrelated-histories
```

## Evidências (prints)

Depois de rodar `flutter run` em um emulador/dispositivo, capture pelo menos 3 telas:
1. Tela de carregamento (loading)
2. Lista de usuários carregada com sucesso
3. Tela de erro (pode ser simulada desligando o Wi-Fi/dados antes de abrir o app)

Salve os prints em uma pasta `screenshots/` no repositório e referencie-os aqui no README, por exemplo:

```markdown
![Loading](screenshots/loading.png)
![Lista](screenshots/lista.png)
![Erro](screenshots/erro.png)
```
