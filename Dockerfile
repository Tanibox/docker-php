FROM php:7.1.8-fpm-alpine

MAINTAINER Didiet Noor <dnoor@tanibox.com>

COPY bin/* /usr/local/bin/
COPY conf/php.ini /usr/local/etc/php/conf.d/
COPY conf/pool.conf /usr/local/etc/php/

ENV PKG_CONFIG_PATH=/usr/lib/pkgconfig:/usr/local/lib/pkgconfig
RUN   export BUILD_ESSENTIAL="build-base zlib-dev autoconf automake pcre-dev pkgconfig file libmemcached-dev re2c cyrus-sasl-dev" \
      export ESSENTIAL="libmemcached-libs libpcre16 libpcre32 libpcrecpp libsasl libmagic" \
      && apk update \
      && apk add --no-cache $BUILD_ESSENTIAL $ESSENTIAL \
      && curl -sS -o /tmp/libzip.tar.gz -L https://nih.at/libzip/libzip-1.2.0.tar.gz \
      && tar -xzvf /tmp/libzip.tar.gz -C /tmp \
      && cd /tmp/libzip-1.2.0 \
      && ./configure --prefix=/usr/local \
      && make -j 4 && make install \
      && curl -sS -o /tmp/icu.tar.gz -L http://download.icu-project.org/files/icu4c/57.1/icu4c-57_1-src.tgz \
      && tar -zxf /tmp/icu.tar.gz -C /tmp && cd /tmp/icu/source \
      && ./configure --prefix=/usr/local \
      && make -j 4 && make install \
      && docker-php-ext-install intl pdo pdo_mysql \
      && docker-php-ext-enable opcache \
      && docker-php-pecl-install redis zip memcached \
      && apk del $BUILD_ESSENTIAL \
      && unset BUILD_ESSENTIAL \
      && unset ESSENTIAL \
      &&  curl -sS https://getcomposer.org/installer | php -- \
      --install-dir=/usr/local/bin \
      --filename=composer \
      && echo "phar.readonly = off" > /usr/local/etc/php/conf.d/phar.ini

EXPOSE 9000
WORKDIR /var/www

CMD ["/usr/local/bin/entrypoint", "php-fpm"]
