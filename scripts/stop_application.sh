#!/bin/bash
# 이전 프로세스 종료
CURRENT_PID=$(pgrep -f istory-*.jar)

if [ -z "$CURRENT_PID" ]; then
    echo "No spring boot application is running."
else
    echo "Kill process: $CURRENT_PID"
    kill -15 $CURRENT_PID
    sleep 5
fi