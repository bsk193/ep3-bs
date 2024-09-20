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
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install mysqli pdo pdo_mysql zip

# Download Zend Framework
RUN curl -L https://github.com/zendframework/zendframework/archive/refs/heads/master.zip -o zendframework.zip \
    && unzip zendframework.zip -d /var/www/html \
    && rm zendframework.zip

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Create necessary directories
RUN mkdir -p /var/www/html/data /var/www/html/cache

# Set permissions for the storage and cache directories
RUN chown -R www-data:www-data /var/www/html/data /var/www/html/cache

# Expose port 80
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2-foreground"]