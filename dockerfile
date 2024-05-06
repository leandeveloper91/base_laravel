# Usa la imagen oficial de PHP con la versión más reciente
FROM php:latest

# Instala las extensiones de PHP necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Instala Composer (el gestor de dependencias de PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia los archivos de tu proyecto Laravel al directorio de trabajo del contenedor
COPY . .

# Instala las dependencias de Composer
RUN composer install

# Exponer el puerto 8000 (puedes cambiarlo según sea necesario)
EXPOSE 8000

# Comando para ejecutar el servidor web PHP incorporado de Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000
