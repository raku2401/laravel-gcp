FROM php:7.4-apache
#php7.4-apache

RUN apt-get update -y && apt-get install -y  libmcrypt-dev  libzip-dev libonig-dev zip unzip

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

WORKDIR /app
COPY . /app

#Superuser for Composer 
ENV COMPOSER_ALLOW_SUPERUSER=1

#Install PHP extensions
RUN docker-php-ext-install  pdo mbstring

#install composer dependencies
RUN composer install --no-scripts  --no-autoloader

#Generate composer autoload files
RUN composer dump-autoload

EXPOSE 8000

CMD php artisan serve --host=0.0.0.0 --port=8000

