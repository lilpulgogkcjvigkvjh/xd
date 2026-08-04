#!/bin/sh
foundry model download qwen3.5-0.8b
DAEMON=$(find /opt/foundry -type f -name 'foundrylocald' | head -n 1)
$DAEMON -p 3000 &
# Wait for the daemon to start on port 3000
while ! curl -s http://127.0.0.1:3000/v1/models > /dev/null; do
    sleep 1
done
foundry model load qwen3.5-0.8b
socat TCP-LISTEN:${PORT:-8080},fork,reuseaddr TCP:127.0.0.1:3000
