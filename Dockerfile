FROM alpine

RUN apk --no-cache --update \
    add apache2 \
    apache2-ssl \
    curl \ 
    wget \
    php8-apache2 \
    php8-bcmath \
    php8-bz2 \
    php8-calendar \ 
    php8-common \
    php8-ctype \
    php8-curl \ 
    php8-dom \
    php8-gd \
    php8-iconv \
    php8-mbstring \
    php8-mysqli \
    php8-mysqlnd \
    php8-openssl \ 
    php8-pdo_mysql \ 
    php8-pdo_pgsql \
    php8-pdo_sqlite \
    php8-phar \
    php8-session \
    php8-xml

RUN mkdir wordpress
RUN cd wordpress/
RUN wget https://ko.wordpress.org/latest-ko_KR.tar.gz
RUN tar zxvf latest-ko_KR.tar.gz
RUN cp -a wordpress/* /var/www/localhost/htdocs/
RUN chown apache.apache /var/www/localhost/htdocs/*
RUN sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/apache2/httpd.conf
RUN cp /var/www/localhost/htdocs/wp-config-sample.php /var/www/localhost/htdocs/wp-config.php
RUN sed -i 's/database_name_here/wordpress/g' /var/www/localhost/htdocs/wp-config.php
RUN sed -i 's/username_here/root/g' /var/www/localhost/htdocs/wp-config.php
RUN sed -i 's/password_here/It12345!/g' /var/www/localhost/htdocs/wp-config.php
RUN sed -i 's/localhost_here/wordpress.cupr0nzbogkz.ap-northeast-2.rds.amazonaws.com/g' /var/www/localhost/htdocs/wp-config.php

CMD /usr/sbin/httpd -D FOREGROUND

EXPOSE 80
