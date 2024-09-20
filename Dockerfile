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

# Manually download and install Zend Framework components and other libraries
RUN mkdir -p /var/www/html/vendor \
    && curl -L https://github.com/zendframework/zend-authentication/archive/2.7.0.zip -o zend-authentication.zip \
    && unzip zend-authentication.zip -d /var/www/html/vendor \
    && rm zend-authentication.zip \
    && curl -L https://github.com/zendframework/zend-cache/archive/2.9.0.zip -o zend-cache.zip \
    && unzip zend-cache.zip -d /var/www/html/vendor \
    && rm zend-cache.zip \
    && curl -L https://github.com/zendframework/zend-console/archive/2.8.0.zip -o zend-console.zip \
    && unzip zend-console.zip -d /var/www/html/vendor \
    && rm zend-console.zip \
    && curl -L https://github.com/zendframework/zend-debug/archive/2.6.0.zip -o zend-debug.zip \
    && unzip zend-debug.zip -d /var/www/html/vendor \
    && rm zend-debug.zip \
    && curl -L https://github.com/zendframework/zend-di/archive/2.6.1.zip -o zend-di.zip \
    && unzip zend-di.zip -d /var/www/html/vendor \
    && rm zend-di.zip \
    && curl -L https://github.com/zendframework/zend-diactoros/archive/2.2.1.zip -o zend-diactoros.zip \
    && unzip zend-diactoros.zip -d /var/www/html/vendor \
    && rm zend-diactoros.zip \
    && curl -L https://github.com/zendframework/zend-file/archive/2.8.3.zip -o zend-file.zip \
    && unzip zend-file.zip -d /var/www/html/vendor \
    && rm zend-file.zip \
    && curl -L https://github.com/zendframework/zend-i18n-resources/archive/2.6.1.zip -o zend-i18n-resources.zip \
    && unzip zend-i18n-resources.zip -d /var/www/html/vendor \
    && rm zend-i18n-resources.zip \
    && curl -L https://github.com/zendframework/zend-log/archive/2.12.0.zip -o zend-log.zip \
    && unzip zend-log.zip -d /var/www/html/vendor \
    && rm zend-log.zip \
    && curl -L https://github.com/zendframework/zend-version/archive/2.5.1.zip -o zend-version.zip \
    && unzip zend-version.zip -d /var/www/html/vendor \
    && rm zend-version.zip \
    && curl -L https://github.com/true/php-punycode/archive/2.1.1.zip -o php-punycode.zip \
    && unzip php-punycode.zip -d /var/www/html/vendor \
    && rm php-punycode.zip

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