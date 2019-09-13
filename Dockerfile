FROM ruby:2.5.3-alpine3.8

RUN apk add --update \
    build-base \
    ruby-dev \
    git \
    && gem install bump

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile Gemfile.lock *.gemspec /app/
RUN bundle install

COPY . /app

CMD rake spec