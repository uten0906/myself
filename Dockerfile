FROM ruby:2.6.3

RUN apt-get update\
  && apt-get install -y --no-install-recommends\
  libpq-dev\
  nodejs\
  vim\
  mariadb-client\
  build-essential\
  && apt-get clean\
  && rm -rf /var/lib/apt/list/*

RUN mkdir /myproject
WORKDIR /myproject

COPY Gemfile /myproject/Gemfile
COPY Gemfile.lock /myproject/Gemfile.lock

RUN gem install bundler
RUN bundle install

COPY . /myproject

RUN mkdir -p tmp/sockets
RUN mkdir -p tmp/pids