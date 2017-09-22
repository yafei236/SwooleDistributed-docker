FROM  php:7-cli
MAINTAINER yafei

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's|security.debian.org|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

RUN apt-get -y update 

#安装 composer
RUN curl -sS https://install.phpcomposer.com/installer | php -- --install-dir=/usr/local/bin --filename=composer

#源码安装扩展
RUN apt-get install -y git zip unzip && docker-php-ext-install bcmath

#安装 inotify 和 redis
RUN pecl install inotify redis \
    && docker-php-ext-enable inotify redis

#安装 ds
RUN pecl install ds \
    && docker-php-ext-enable ds

#安装hiredis扩展方法1
RUN mkdir -p /app/src && cd /app/src/ \
    && curl -fsSL 'https://github.com/redis/hiredis/archive/v0.13.3.tar.gz' -o hiredis.tar.gz \
    && mkdir -p hiredis \
    && tar -xf hiredis.tar.gz -C hiredis --strip-components=1 \
    && cd hiredis && make && make install && ldconfig 

#安装swoole扩展
RUN curl -fsSL 'https://github.com/swoole/swoole-src/archive/v1.9.19.tar.gz' -o swoole.tar.gz \
    && mkdir -p /tmp/swoole \
    && tar -xf swoole.tar.gz -C /tmp/swoole --strip-components=1 \
    && rm swoole.tar.gz \
    && docker-php-ext-configure /tmp/swoole --enable-async-redis  \
    && docker-php-ext-install /tmp/swoole \
    && rm -r /tmp/swoole


COPY ./swooledistributed /app/sd

# #安装 consul
# RUN  cd /app/setup && unzip consul_0.9.0_linux_amd64.zip &&  mv consul /usr/local/bin/

RUN cd /app/sd && composer install && echo y |php vendor/tmtbe/swooledistributed/src/Install.php

#打包后删除无用文件
RUN rm -rf /var/lib/apt/lists/*;

WORKDIR /app

#执行启动命令
ENTRYPOINT ["php", "/app/sd/bin/start_swoole_server.php" , "start"]
