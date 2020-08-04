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
