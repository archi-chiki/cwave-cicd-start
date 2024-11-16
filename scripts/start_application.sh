#!/bin/bash
cd /home/ec2-user/app

# 환경 변수 설정
export SERVER_PORT=8080
export JAVA_OPTS="-Xms512m -Xmx1024m"

# 애플리케이션 시작
nohup java $JAVA_OPTS \
    -Dserver.port=$SERVER_PORT \
    -jar *.jar > /home/ec2-user/app/logs/application.log 2>&1 &

# PID 저장
echo $! > /home/ec2-user/app/application.pid

# 시작 대기
sleep 10