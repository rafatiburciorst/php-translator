# Use uma imagem base do PHP mais leve
FROM php:8.1-fpm-alpine

# Instalar dependências necessárias
RUN apk --no-cache add \
    libzip-dev \
    unzip \
    && docker-php-ext-install zip

# Instalar o Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Definir o diretório de trabalho
WORKDIR /var/www/html

# Copiar o arquivo composer.json e o composer.lock (se existir)
COPY app/composer.json app/composer.lock ./

# Instalar as dependências do Composer
RUN composer install --no-dev --no-scripts --no-interaction --prefer-dist || \
    (sleep 5 && composer install --no-dev --no-scripts --no-interaction --prefer-dist)

# Copiar o restante da aplicação
COPY app/ .

# Ajustar permissões
RUN chown -R www-data:www-data /var/www/html

# Expor a porta 9000 para o PHP-FPM
EXPOSE 9000

# Comando para iniciar o PHP-FPM
CMD ["php-fpm"]
