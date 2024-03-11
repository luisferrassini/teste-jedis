# Projeto Municipe

Este é um projeto Ruby on Rails para gerenciar informações de cidadões de um município. Ele permite criar, visualizar, editar e inativar registros de cidadões, além de filtrar por dados pessoais e de endereço.

## Configuração do Ambiente

Antes de rodar o projeto, é necessário configurar algumas variáveis de ambiente para envio de SMS e de e-mail.

### Variáveis de Ambiente

- `SMTP_ADDRESS`: O endereço SMTP do servidor de e-mail (opcional para Mailtrap).
- `SMTP_PORT`: A porta SMTP do servidor de e-mail (opcional para Mailtrap).
- `SMTP_HOST`: O host do servidor de e-mail (opcional para Mailtrap).
- `SMTP_USERNAME`: O nome de usuário SMTP para autenticação (opcional para Mailtrap).
- `SMTP_PASSWORD`: A senha SMTP para autenticação (opcional para Mailtrap).
- `SENDPULSE_API_USER`: O nome de usuário do Sendpulse (caso esteja usando Sendpulse).
- `SENDPULSE_API_KEY`: A api key do Sendpulse (caso esteja usando Sendpulse).

### Configuração das Variáveis de Ambiente

Você pode configurar as variáveis de ambiente de diferentes maneiras, dependendo do seu ambiente de desenvolvimento, vou deixar aqui explicado como colocar no docker-compose.

#### Docker Compose

Se estiver utilizando Docker Compose, você pode definir as variáveis de ambiente no arquivo `docker-compose.dev.yml`:

```yaml
version: '3.8'
services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "3000:3000"
    environment:
      SMTP_ADDRESS: smtp.example.com
      SMTP_PORT: 587
      SMTP_DOMAIN: example.com
      SMTP_USERNAME: username
      SMTP_PASSWORD: password
      MAILTRAP_USERNAME: mailtrap_username
      MAILTRAP_PASSWORD: mailtrap_password
```

## Rodando o Projeto

### Rodando com Docker Compose
Se preferir rodar o projeto com Docker Compose, siga os passos abaixo:

- Clone este repositório:
```git clone https://github.com/luisferrassini/teste-jedis.git```
- Navegue até o diretório do projeto:
```cd teste-jedis```
- Construa as imagens Docker:
```docker-compose -f docker-compose.dev.yml build```
- Inicie os contêineres Docker:
```docker-compose -f docker-compose.dev.yml up```
- Acesse o projeto em seu navegador em http://localhost:3000.
- Para parar os contêineres, pressione Ctrl + C, e depois execute:
```docker-compose -f docker-compose.dev.yml down```

### Rodando Localmente
Para rodar o projeto localmente, siga os passos abaixo (sendo necessário ter instalado na máquina o PostgreSQL):

- Clone este repositório:
```git clone https://github.com/luisferrassini/teste-jedis.git```
- Navegue até o diretório do projeto:
```cd teste-jedis```
- Modifique o db, username e password do `config/database.yml` com a informação de seu PostgreSQL local
- Instale as dependências do projeto:
```bundle install```
- Execute as migrações do banco de dados:
```rails db:migrate```
- Inicie o servidor Rails:
```rails server```
- Acesse o projeto em seu navegador em http://localhost:3000.
- Para parar o servidor, pressione Ctrl + C.

## Licença
Este projeto está licenciado sob a MIT License.