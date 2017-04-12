FROM php:7.0.16-fpm

MAINTAINER Serkan Yılmaz <me@serkanylmz.com>

RUN apt-get update
RUN apt-get install -y \
		libicu-dev  \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxslt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt intl xsl zip pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

COPY ./entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
