# Use an official PHP image as the base
FROM --platform=linux/arm64 php:8.1-apache
# Set working directory inside the container
WORKDIR /

# Copy the current directory contents into the container
COPY . .

# Install necessary PHP extensions and system packages
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libonig-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install PHP dependencies using Composer
RUN composer install

# Expose port 4000 to the Docker host
EXPOSE 4000

# Start Apache in the foreground
CMD ["apache2-foreground"]
