#!/bin/bash

# 헬스체크 엔드포인트 확인
for i in {1..30}; do
    HTTP_RESPONSE=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/actuator/health)
    if [ "$HTTP_RESPONSE" -eq 200 ]; then
        echo "Application is running successfully!"
        exit 0
    fi
    echo "Waiting for application to start... (Attempt: $i/30)"
    sleep 2
done

echo "Application failed to start properly"
exit 1