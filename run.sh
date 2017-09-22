#!/bin/bash

docker build -t php-swoole-distributed:1.2 .
docker rm -f php-swoole-distributed-run-01
docker ps -a

docker run -d \
--name php-swoole-distributed-run-01 \
-p 8085:8081 \
php-swoole-distributed:1.2