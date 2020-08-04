# Desafio Github scraper 

# Desenvolvimento

## Pré-requisitos

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Configuração

Primeiro é necessário configurar as variáveis de ambiente:

1. Copie o arquivo de template:
```bash
cp env.tmpl .env
```
2. Abra o arquivo e altere os valores padrões caso julgue necessário:
```bash
vi .env
```
As variáveis disponívels são:

- `POSTGRES_USER`: Usuário do banco de dados postgresql; 
- `POSTGRES_PASSWORD`: Senha do banco de dados postgresql;
- `POSTGRES_HOST`: Enderço do banco de dados postgresql;
- `POSTGRES_PORT`: Porta do banco de dados postgresql;
- `VUE_APP_ROOT_API`: URL base para a API.

## Execução

Para iniciar a aplicação execute na pasta raiz do projeto:

```bash
 docker-compose up
```

Acesse:

- [localhost:8080](localhost:8080): Para o frontend
- [localhost:3000/api/v1](localhost:3000/api/v1): Para a API

# Arquitetura

## Ambiente
A aplicação foi empacotada utilizando o [Docker](https://www.docker.com/), por ser uma ferramenta de uso simples que permite isolar a aplicação e suas dependências em um ambiente virtualizado, facilitando a execução desse sistema em outros ambientes.

## Scraper

O scraper foi implementado no diretório `lib` por ser uma dependência que pode facilmente ser empacotada em uma gema e reutilizada em outros projetos. Foram criadas duas classes:
- `RequestGh`: responsável por fazer a requisição a página do Github e tratar a resposta e exceções, retornando o conteúdo HTML do endereço requisitado. Essa classe pode ser reutilizada para requisitar outras páginas do Github. As chamadas HTTP foram implementadas através da lib [open-uri](https://www.rubydoc.info/stdlib/open-uri/OpenURI).

- `ParseProfile`: responsável por extrair do conteúdo HTML os campos correspondentes ao perfil do Github do usuário em questão. O objeto criado possui um método para cada campo definido, assim como um método que retorna uma Hash com os dados de todos os campos. O conteúdo HTML foi parseado utilizando a lib [Nokogiri](https://nokogiri.org/).

## API

### Controllers

Para garantir o versionamento da API, as controllers foram implementadas sob o namespace API::V1.

### Models

Existe uma model `Profile` para salvar as informações referentes ao perfil do Github dos usuários cadastrados. Como foi necessário implementar uma query de busca em cima de vários campos da model `Profile`, foi implementado um Query Object `SearchProfileQuery` para encapsular essa lógica e garantir uma melhor manutenabilidade.

Na query implementada na classe `SearchProfileQuery` utilizou-se o operador de expressões regulares(`~*`) disponibilizado pelo [banco de dados PostgreSQL](https://www.postgresql.org/docs/9.6/functions-matching.html#FUNCTIONS-POSIX-TABLE), por ter uma sintaxe mais simples e ter um resultado melhor em detecção de padrões do que o operador `LIKE` ou `SIMILAR TO`.

### Testes

Nos testes foi utilizada a gem [RSpec](https://rspec.info/) por possuir um conjunto de ferramentas poderosas para facilitar a implementação, como stubs e mocks. Além disso, para a criação de objetos durante a implementação dos desdes foi utilizada a gem [Factory Bot](https://github.com/thoughtbot/factory_bot).

## Frontend

O frontend foi implementado utilzando o [Vue.js](https://vuejs.org/), por ser um framework com uma comunidade ativa que fornece atualizações constantes ao código fonte, além de ser um framework familiar para quem já tem conhecimento sobre Javascript, HTML e CSS, facilitando a manutenção.

# Dívidas técnicas

## API

- A lógica responsável por requisitar o Github e parsear o conteúdo retornado está na controller `ProfileController`, essa implementação carrega a controller com responsabilidades que essa classe não deveria lidar, uma melhor alternativa seria mover essa lógica para um Service;

- É necessário adicionar validações sobre o formato da URL do github enviada a classe `RequestGh` e enviar a resposta correta caso a URL não esteja no formato desejado;

- Para garantir a extensibildade da classe `ParseProfile` deve ser criada uma abstração dessa classe, permitindo criar parsers de outras páginas seguindo a mesma interface;

- Os testes da model `Profile` podem ser refatorados para um sintaxe mais simples usando [shoulda matchers](https://github.com/thoughtbot/shoulda-matchers);

- Adicionar [Swagger](https://swagger.io/) com a documentação da API.

## Frontend

- Os componentes de formulário devem ser refatorados pois existe duplicação de código, é necessário definir um modelo genérico que pode ser utilizado tanto no contexto de atualização de usuário quanto de criação;

- É necessário implementar testes no frontend;
- É necessário cria um módulo separado para as rotas, pois elas estão definidas no arquivo `main.js`;
- É essencial implementar as animações de loading dos componentes que interagem com a API;
- É ncessário configurar as `meta` tags para garantir uma melhor performance em SEO;
- É necessário alterar a tag `title` e o favicon para uma melhor apresentação da página.