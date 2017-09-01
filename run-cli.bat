docker build -f Dockerfile-cli -t php-swoole-distributed:cli-1.2 .
docker rm -f php-swoole-distributed-run-01

docker ps -a
docker run ^
--name php-swoole-distributed-run-01 ^
-p 8085:8081 ^
-v E:\develop\code\php\swooledistributed:/app/sd ^
-t -i php-swoole-distributed:cli-1.2 /bin/bash 

