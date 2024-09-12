# Use an official PHP image as the base
FROM --platform=linux/arm64 php:8.1-apache

# Set working directory inside the container
WORKDIR /

# Copy the current directory contents into the container at /var/www/html
COPY . .

# Install necessary PHP extensions and Composer
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install PHP dependencies
RUN composer install

# Expose port 80 to the Docker host
EXPOSE 4000

# Start Apache in the foreground
CMD ["apache2-foreground"]
