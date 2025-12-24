FROM php:8.3-apache

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ADD --chmod=0755 https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN install-php-extensions \
    curl \
    gd \
    intl \
    mbstring \
    mysqli \
    pdo \
    zip \
    pdo_mysql \
    opcache \
    apcu

ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf
RUN a2enmod rewrite

EXPOSE 80

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY php.ini /usr/local/etc/php/conf.d/50-custom.ini

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]