FROM ruby:2.7.0-slim-buster

RUN apt-get update && apt-get install -y vim
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y mariadb-server default-libmysqlclient-dev
RUN apt-get -y install git

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile

RUN \
  gem update --system --quiet && \
  gem install bundler -v '~> 2.2'
ENV BUNDLER_VERSION 2.2

RUN gem install mysql2

RUN bundler install 

ADD Gemfile.lock /app/Gemfile.lock

RUN groupadd -g 1000 app
RUN useradd -u 1000 -ms /bin/bash -g app app

COPY --chown=app:app . /app

USER app

ENV LANG en_US.UTF-8

COPY . /app

