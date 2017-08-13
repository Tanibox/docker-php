# Docker Build Image For Tania

This docker image is built from [official alpine php-fpm image](https://registry.hub.docker.com/_/php/). We add these
features:

 - `docker-php-pecl-install` script. Snatched from straight from [Mathew Peterson's Github](https://github.com/mathewpeterson/docker-php7/blob/master/fpm/bin/docker-php-pecl-install)
 - [Composer](https://getcomposer.org)

## LICENSE
MIT
