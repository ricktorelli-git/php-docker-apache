FROM php:8.4-apache

# Atualiza e instala extensões necessárias
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libzip-dev \
    libicu-dev \
    libonig-dev \
 && docker-php-ext-install pdo pdo_mysql intl zip opcache \
 && rm -rf /var/lib/apt/lists/*

# Habilita módulos do Apache necessários para .htaccess e URLs amigáveis
RUN a2enmod rewrite

# Evita warning chato de ServerName e deixa parecido com XAMPP
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# VirtualHost agora vem de um arquivo versionado em docker/apache/vhost.conf
COPY docker/apache/vhost.conf /etc/apache2/sites-available/000-default.conf

# Instala Xdebug
RUN pecl install xdebug \
 && docker-php-ext-enable xdebug

# Copia configs PHP
COPY docker/php/php.ini /usr/local/etc/php/php.ini
COPY docker/php/xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

# Configuração de OPcache para sobrescrever a padrão da imagem
# (certifique-se de que o arquivo foi renomeado para z_opcache.ini)
COPY docker/php/z_opcache.ini /usr/local/etc/php/conf.d/z_opcache.ini

# Diretório de trabalho da aplicação
WORKDIR /var/www/html

# Instala Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer
