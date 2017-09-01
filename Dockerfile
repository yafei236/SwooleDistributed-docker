FROM  php:7-cli
MAINTAINER yafei

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
RUN sed -i 's|security.debian.org|mirrors.ustc.edu.cn/debian-security|g' /etc/apt/sources.list

RUN apt-get -y update 

RUN pecl install inotify redis \
    && docker-php-ext-enable inotify redis

RUN pecl install ds \
    && docker-php-ext-enable ds

#安装hiredis扩展
RUN mkdir -p /app/src && cd /app/src/ \
    && curl -fsSL 'https://github.com/redis/hiredis/archive/v0.13.3.tar.gz' -o hiredis.tar.gz \
    && mkdir -p hiredis \
    && tar -xf hiredis.tar.gz -C hiredis --strip-components=1 \
    && cd hiredis && make && make install && ldconfig 
 
   
#RUN pecl install swoole --enable-async-redis  --enable-openssl \
#    && docker-php-ext-enable swoole

 RUN curl -fsSL 'https://github.com/swoole/swoole-src/archive/v1.9.19.tar.gz' -o swoole.tar.gz \
     && mkdir -p /tmp/swoole \
     && tar -xf swoole.tar.gz -C /tmp/swoole --strip-components=1 \
     && rm swoole.tar.gz \
     && docker-php-ext-configure /tmp/swoole --enable-async-redis  \
     && docker-php-ext-install /tmp/swoole \
     && rm -r /tmp/swoole

     #安装swoole扩展
# RUN cd /tmp \
#     && curl -fsSL 'https://github.com/swoole/swoole-src/archive/v1.9.19.tar.gz' -o swoole-src.tar.gz \
#     && mkdir -p swoole-src \
#     && tar -xf swoole-src.tar.gz -C swoole-src --strip-components=1 \
#     &&  cd swoole-src && phpize \
#     && docker-php-ext-configure --enable-async-redis \
#     && docker-php-ext-install 

    #  && ./configure --enable-async-redis \
    # && make clean && make && make install && echo "extension=swoole.so" >> /etc/php/7.0/cli/php.ini




# RUN curl -fsSL 'https://github.com/redis/hexiiredis/archive/v0.13.3.tar.gz' -o hiredis.tar.gz \
#     && mkdir -p hiredis \
#     && tar -xf hiredis.tar.gz -C hiredis --strip-components=1 \
#     && rm hiredis.tar.gz \
#     && ( \
#         cd hiredis \
#         && make -j$(nproc) \
#         && make install \
#     ) \
#     && rm -r hiredis \


# RUN curl -fsSL 'https://github.com/redis/hiredis/archive/v0.13.3.tar.gz' -o hiredis.tar.gz \
#     && mkdir -p /tmp/hiredis \
#     && tar -xf hiredis.tar.gz -C /tmp/hiredis --strip-components=1 \
#     && rm hiredis.tar.gz \
#     && cd  /tmp/hiredis   \
#     && make \
#     && make install \
#     && ldconfig \
#     && rm -r /tmp/hiredis



# RUN curl -fsSL 'https://github.com/swoole/swoole-src/archive/v1.9.16.tar.gz' -o swoole.tar.gz \
#     && mkdir -p swoole \
#     && tar -xf swoole.tar.gz -C swoole --strip-components=1 \
#     && rm swoole.tar.gz \
#     && ( \
#         cd swoole \
#         && phpize \
#         && ./configure --enable-async-redis --enable-openssl \
#         && make -j$(nproc) \
#         && make install \
#     ) \
#     && rm -r swoole \
#     && docker-php-ext-enable swoole



WORKDIR /app
# COPY ./develop /app

# #安装必备组件
# RUN apt-get install -y unzip make gcc

# #安装php
# RUN apt-get install -y php7.0-cli php7.0-dev php7.0-mbstring php7.0-bcmath php7.0-zip php-redis php7.0-mysql

# #安装hiredis扩展
# RUN cd /app/src/ && unzip hiredis-0.13.3.zip  \
#     && cd hiredis-0.13.3 && make && make install && ldconfig 

# #安装swoole扩展
# RUN cd /app/src/ && unzip swoole-src-1.9.16.zip  &&  cd swoole-src-1.9.16 && phpize \
#     && ./configure --enable-async-redis  --enable-openssl \
#     && make clean && make && make install && echo "extension=swoole.so" >> /etc/php/7.0/cli/php.ini

# #安装inotify扩展
# RUN cd /app/src/ && tar zxvf inotify-2.0.0.tgz  &&  cd inotify-2.0.0 && phpize \
#     && ./configure  \
#     && make clean && make && make install && echo "extension=inotify.so" >> /etc/php/7.0/cli/php.ini


# #安装 consul
# RUN  cd /app/setup && unzip consul_0.9.0_linux_amd64.zip &&  mv consul /usr/local/bin/

# #安装 composer
RUN curl -sS https://install.phpcomposer.com/installer | php -- --install-dir=/usr/local/bin --filename=composer

#执行启动命令
# php start_swoole_server.php start
#CMD [ "php", "/app/sd/bin/server.php start" ]

#打包后删除无用文件
RUN rm -rf /var/lib/apt/lists/*;
