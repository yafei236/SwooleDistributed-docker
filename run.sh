#!/bin/bash

docker build -t php-swoole-distributed:1.2 .
docker rm -f php-swoole-distributed-run-01
docker ps -a

docker run \
--name php-swoole-distributed-run-01 \
-p 8081:8081 \
-t -i php-swoole-distributed:1.2 bash 

#-v /home/develop/docker/SwooleDistributed-docker/swooledistributed:/app/sd \