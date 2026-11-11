#!/bin/sh
set -eu
cd "$(dirname "$0")"
if ! ruby -rsocket -e 'TCPSocket.new("127.0.0.1", 8000).close' >/dev/null 2>&1; then
  (ruby -run -e httpd . -b 127.0.0.1 -p 8000 >/tmp/setlist-ai-server.log 2>&1 &)
  i=0
  while ! ruby -rsocket -e 'TCPSocket.new("127.0.0.1", 8000).close' >/dev/null 2>&1; do
    i=$((i + 1))
    [ "$i" -lt 30 ] || { echo "Setlist AI could not start. See /tmp/setlist-ai-server.log"; exit 1; }
    sleep 1
  done
fi
open "http://127.0.0.1:8000"
