#!/usr/bin/env bash
PIDFILE="/tmp/waybar.pid"

if [ -f "$PIDFILE" ] && kill -0 $(cat "$PIDFILE") 2>/dev/null; then
    kill $(cat "$PIDFILE")
    rm "$PIDFILE"
else
    waybar &
    echo $! > "$PIDFILE"
fi
