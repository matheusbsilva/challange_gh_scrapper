FROM ruby:2.7.1-buster

ENV INSTALL_PATH /app/

WORKDIR $INSTALL_PATH

COPY Gemfile* $INSTALL_PATH

RUN bundle install

COPY . $INSTALL_PATH

EXPOSE 3000

# Add script to let restart server even if a server.pid exists
# and migrate database
ENTRYPOINT ["./entrypoint.sh"]

CMD rails server -b 0.0.0.0 -p 3000

