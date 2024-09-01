FROM php:7.2-apache

WORKDIR /var/www/html

# Install Composer

# Install required packages and Node.js
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Install PHP extensions and Redis

COPY --from=composer:2.6 /usr/bin/composer /usr/bin/composer

COPY . /var/www/html

# Copy and configure Apache and PHP
COPY .docker/vhost.conf /etc/apache2/sites-available/000-default.conf
COPY .docker/php.ini /usr/local/etc/php/php.ini
RUN a2enmod rewrite


# Set permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Set entry point
CMD ["apache2-foreground"]