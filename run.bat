
docker build -t php-swoole-distributed:1.0 .

rem docker rm -f php-swoole-distributed-run-01 
rem docker run -d ^
rem --name php-swoole-distributed-run-01 ^
rem php-swoole-distributed:1.0

docker ps -a

docker run ^
-p 8082:8081 ^
-v E:\develop\docker\SwooleDistributed-docker\swooledistributed:/app/sd ^
-t -i php-swoole-distributed:1.0 /bin/bash 

