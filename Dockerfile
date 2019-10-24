FROM ruby:2.5.3-alpine3.8

RUN apk add --update \
    build-base \
    ruby-dev \
    git

RUN mkdir -p /app
WORKDIR /app
COPY Gemfile Gemfile.lock *.gemspec /app/
COPY lib/ruby_extensions/version.rb /app/lib/ruby_extensions/version.rb
RUN bundle install

COPY . /app
# CMD rake spec