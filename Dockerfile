FROM centos:7

RUN yum install -y httpd wget epel-release yum-utils
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum-config-manager --enable remi-php73
RUN yum install -y php php-common php-opcache php-mcrypt php-cli php-gd php-curl php-mysqlnd
RUN mkdir wordpress
RUN cd wordpress/
RUN wget https://ko.wordpress.org/latest-ko_KR.tar.gz
RUN tar zxvf latest-ko_KR.tar.gz
RUN cp -a wordpress/* /var/www/html/
RUN chown apache.apache /var/www/html/*
RUN sed -i 's/DirectoryIndex index.html/DirectoryIndex index.php/g' /etc/httpd/conf/httpd.conf
RUN cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php
RUN sed -i 's/database_name_here/wordpress/g' /var/www/html/wp-config.php
RUN sed -i 's/username_here/root/g' /var/www/html/wp-config.php
RUN sed -i 's/password_here/It12345!/g' /var/www/html/wp-config.php
RUN sed -i 's/localhost/wordpress.cupr0nzbogkz.ap-northeast-2.rds.amazonaws.com/g' /var/www/html/wp-config.php

RUN mkdir -p /var/lib/amazon
RUN chmod 777 /var/lib/amazon
VOLUME /var/lib/amazon

RUN mkdir -p /var/log/amazon
RUN chmod 777 /var/log/amazon
VOLUME /var/log/amazon

CMD /usr/sbin/httpd -D FOREGROUND

EXPOSE 80
