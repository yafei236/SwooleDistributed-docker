#!/bin/bash


docker build -t php-swoole-distributed:1.1 .
docker rm -f php-swoole-distributed-run-01
docker ps -a

docker run \
--name php-swoole-distributed-run-01 \
-p 8081:8081 \
-v E:\develop\code\php\swooledistributed:/app/sd \
-t -i php-swoole-distributed:1.1 /bin/bash 


