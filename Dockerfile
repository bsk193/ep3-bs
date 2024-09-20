# Use an official PHP runtime as a parent image
FROM php:8.1-apache

# Set the working directory
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Install necessary PHP extensions and other dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libzip-dev \
    zip \
    unzip \
    git \
    libicu-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip intl

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies using Composer
RUN composer install --ignore-platform-reqs

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Create necessary directories
RUN mkdir -p /var/www/html/data/cache \
    /var/www/html/data/log \
    /var/www/html/data/session \
    /var/www/html/public/docs-client/upload \
    /var/www/html/public/imgs-client/upload

# Set permissions for the storage and cache directories
RUN chown -R www-data:www-data /var/www/html/data/cache \
    /var/www/html/data/log \
    /var/www/html/data/session \
    /var/www/html/public/docs-client/upload \
    /var/www/html/public/imgs-client/upload

# Set write permissions for the specified directories
RUN chmod -R 775 /var/www/html/data/cache \
    /var/www/html/data/log \
    /var/www/html/data/session \
    /var/www/html/public/docs-client/upload \
    /var/www/html/public/imgs-client/upload

# Expose port 80
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2-foreground"]