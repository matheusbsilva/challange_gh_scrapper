#!/bin/bash

set -e

# let restart server even if a server.pid exists
rm -f /app/tmp/pids/server.pid

# migrate database
if rails db:migrate:status &> /dev/null; then
  rails db:migrate
else
  rails db:setup
fi

exec "$@"
