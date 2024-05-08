# Usa la imagen oficial de PHP con la versión más reciente
FROM php:latest

# Instala las extensiones de PHP necesarias para Laravel y la extensión zip
RUN apt-get update && apt-get install -y \
    zlib1g-dev \
    libzip-dev \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip pdo pdo_mysql



# Establece el directorio de trabajo dentro del contenedor
WORKDIR /var/www/html

# Instala Composer (el gestor de dependencias de PHP)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copia los archivos de tu proyecto Laravel al directorio de trabajo del contenedor
COPY . .

# Instala las dependencias de Composer
RUN composer install --no-plugins --no-scripts

# Instala Node.js y npm
RUN apt-get update && apt-get install -y \
    curl \
    && curl -sL https://deb.nodesource.com/setup_16.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN npm install && npm install vite --save-dev

# Exponer el puerto 8000 (puedes cambiarlo según sea necesario)
EXPOSE 8000

# Comando para ejecutar el servidor web PHP incorporado de Laravel
CMD npm start