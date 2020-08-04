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
- `POSTGRES_PORT`: Porta do banco de dados postgresql.

## Execução

Para iniciar a aplicação execute na pasta raiz do projeto:

```bash
# docker-compose up
```

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

## Models

Existe uma model `Profile` para salvar as informações referentes ao perfil do Github dos usuários cadastrados. Como foi necessário implementar uma query de busca em cima de vários campos da model `Profile`, foi implementado um Query Object `SearchProfileQuery` para encapsular essa lógica e garantir uma melhor manutenabilidade.

Na query implementada na classe `SearchProfileQuery` utilizou-se o operador de expressões regulares(`~*`) disponibilizado pelo [banco de dados PostgreSQL](https://www.postgresql.org/docs/9.6/functions-matching.html#FUNCTIONS-POSIX-TABLE), por ter uma sintaxe mais simples e ter um resultado melhor em detecção de padrões do que o operador `LIKE` ou `SIMILAR TO`.

## Testes

Nos testes foi utilizada a gem [RSpec](https://rspec.info/) por possuir um conjunto de ferramentas poderosas para facilitar a implementação, como stubs e mocks. Além disso, para a criação de objetos durante a implementação dos desdes foi utilizada a gem [Factory Bot](https://github.com/thoughtbot/factory_bot).
