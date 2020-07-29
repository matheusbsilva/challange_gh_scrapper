FROM ruby:2.7.1-buster

WORKDIR /app

COPY Gemfile* /app/

RUN bundle install

COPY . /app/

EXPOSE 3000

CMD rails server -b 0.0.0.0 -p 3000

