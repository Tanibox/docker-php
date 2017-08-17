FROM tanibox/php7-fpm

MAINTAINER Didiet Noor <dnoor@tanibox.com>

RUN apk update && apk add --no-cache nginx supervisor

COPY ./php-fpm-nginx-supervisord/conf/pool.conf /usr/local/etc/php-fpm.d/
COPY ./php-fpm-nginx-supervisord/conf/nginx.conf /etc/nginx/nginx.conf
COPY ./php-fpm-nginx-supervisord/conf/supervisord.conf /etc/supervisord.conf
COPY ./php-fpm-nginx-supervisord/site/index.php /var/www/index.php
 
EXPOSE 8080

ENTRYPOINT [ "/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf" ]
