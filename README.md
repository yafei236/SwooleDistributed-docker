# SwooleDistributed-docker

##基于 php:7-cli

>本项目适用于 刚入手sd的新手 用于开发环境

使用方法 
- linux or mac  运行 ./run.sh
- windows 运行 run.bat

### 注意事项
- 默认sd 代码目录为 /app/sd
- 如果编译失败请多运行几次命令,因为pecl比较慢,容易掉线



或者运行如下脚本

``` shell
#!/bin/bash

docker build -t php-swoole-distributed:1.2 .
docker rm -f php-swoole-distributed-run-01
docker ps -a

docker run \
--name php-swoole-distributed-run-01 \
-p 8085:8081 \
-v /home/develop/docker/SwooleDistributed-docker/swooledistributed:/app/sd \
php-swoole-distributed:1.2

```
> -v 是映射宿主机的目录到虚拟机的目录

进入之后执行
composer install

php vendor/tmtbe/swooledistributed/src/Install.php
第一次点Y 确认创建项目
第二次点N 不安装consul


修改 swooledistributed\src\config\redis.php
redis ip 和 密码


$config['redis']['local']['ip'] = 'localhost';
//$config['redis']['local']['password'] = '123456';
~~ cd bin
service redis-server restart 
php start_swoole_server.php start~~

测试成功方法
http://localhost:8085/TestController/test
http://127.0.0.1:8085/
http://localhost:8085/


