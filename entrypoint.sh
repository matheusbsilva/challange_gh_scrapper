#!/bin/bash

# Script to let restart server even if a server.pid exists
set -e

rm -f /app/tmp/pids/server.pid

exec "$@"
