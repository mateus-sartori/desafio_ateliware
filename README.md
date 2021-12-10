# Desafio Ateliware

![](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSJxUqN1ucQcwoJRXVDXD5RUhUmtZcdRcEbp6Nl0UFnXr9iDM_oWoQKSJDu7IAIKyNxJKk&usqp=CAU)

Desafio dedicado a empresa Ateliware para avaliação

### 🚦 Pré Requisitos

- [Node](https://nodejs.org/en/)
- [Yarn](https://yarnpkg.com/)
- [Docker](https://www.docker.com/products/docker-desktop)

## Para executar o projeto

Clone o projeto em sua pasta local

```bash
git clone https://github.com/mateus-sartori/desafio_ateliware.git
```

Após isso temos dois ambientes `frontend` e `backend`

Para subir os containers em `backend(Rails)`:

## 🎲 Rodando o servidor

É necessário estar dentro da basta backend e rodar os seguintes comandos:

```bash
docker-compose build
```

```bash
docker-compose up
```

```bash
# Instale as dependencias do Gemfile
docker-compose exec app bash

# Dentro da bash do app
bundle install

# Por ser um projeto em Rails é necessário também inicializar o banco de dados em ambiente dev
rails db:create
```

## 🎲 Rodando o frontend

Para abrir a aplicação em `frontend(VueJs)`:

É necessário estar dentro da basta `frontend` e rodar os seguintes comandos:

```bash
# Instalar as dependencias do node
yarn
```

```bash
# Em seguida é possivel levantar a aplicação front com o seguinte comando
yarn dev
```

##### Em caso de aviso de comando inválido em frontend

```bash
# O Link a seguir tem os detalhes da instalação do quasar, framework que utiliza o Vue no frontend
https://quasar.dev/quasar-cli/installation

# Se por acaso faltar script para rodar com yarn tente:
quasar dev
```