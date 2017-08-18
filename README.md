# SwooleDistributed-docker

##基于 ubuntu:16.04

>本项目适用于 刚入手sd的新手 用于开发环境

使用方法 
- linux or mac  运行 ./run.sh
- windows 运行 run.bat

或者运行

docker build -t php-swoole-distributed:1.0 .

<p>
<code>
docker run ^
-p 8081:8081 ^
-v E:\develop\docker\SwooleDistributed-docker\swooledistributed:/app/sd ^
-t -i php-swoole-distributed:1.0 /bin/bash 
</code>
</p>


进入之后执行
composer install

php vendor/tmtbe/swooledistributed/src/Install.php
第一次点Y 确认创建项目
第二次点N 不安装consul


修改 swooledistributed\src\config\redis.php
redis ip 和 密码


$config['redis']['local']['ip'] = 'localhost';
//$config['redis']['local']['password'] = '123456';

cd bin
service redis-server restart 
php start_swoole_server.php start

测试成功方法
http://localhost:8081/TestController/test
http://127.0.0.1:8081/
http://localhost:8081/


