FROM php:7.2-apache
MAINTAINER James Wade <jpswade@gmail.com>

# Install gd, iconv, mbstring, mcrypt, mysql, soap, sockets, zip, and zlib extensions
# see example at https://hub.docker.com/_/php/
RUN apt-get update \
    && apt-get install -y \
        git \
        yarn \
        build-essential \
        libbz2-dev \
        libfreetype6-dev \
        libgd-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        zlib1g-dev \
        netcat \
        wget \
        sudo \
    && docker-php-ext-install iconv mbstring mysqli mcrypt soap sockets zip \
    && docker-php-ext-configure gd --enable-gd-native-ttf --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install pcntl

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install XDebug
RUN (pecl install xdebug || pecl install xdebug-2.5.5)

ENV WORKDIR /var/www/

# setup apache DocumentRoot.
ENV APACHE_DOCUMENT_ROOT ${WORKDIR}/public
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# enable mod_rewrite
RUN a2enmod rewrite

# make the webroot a volume
VOLUME ${WORKDIR}
WORKDIR ${WORKDIR}

EXPOSE 80

ENTRYPOINT ["apache2-foreground"]

#EOF
