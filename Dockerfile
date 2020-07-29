FROM ruby:2.7.1-buster

WORKDIR /app

COPY Gemfile* /app/

RUN bundle install

COPY . /app/

EXPOSE 3000

# Add script to let restart server even if a server.pid exists
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD rails server -b 0.0.0.0 -p 3000

