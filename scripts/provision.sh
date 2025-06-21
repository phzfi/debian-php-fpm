#!/bin/sh

#add-apt-repository ppa:ondrej/php
apt-get update
apt-get -y install \
    ssmtp \
    php8.2-fpm \
    php8.2-cli \
    php-fpm \
    php-mysql \
    php-curl \
    php-imagick \
    php-tidy \
    php-memcache \
    php-apcu \
    php-pear \
    php-imap \
    php-intl \
    php-ssh2 \
    php-zip \
    php-xml \
    php-xmlrpc

#Install composer outside WORKDIR since it's not then under shared folder
#and will be packaged to the image instead out of it
echo "Install composer"
curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
