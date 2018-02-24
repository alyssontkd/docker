FROM php:5.6.30-apache

VOLUME ["/var/www"]

RUN echo "[ ***** ***** ***** ] - Copying files to Image ***** ***** ***** "

#Copiando os arquivos do HOST para a IMAGEM
COPY ./src /tmp/src
#RUN cp -av /tmp/src/actions/apt-get/sources.list /etc/apt/


RUN apt-get update

RUN echo "[ ***** ***** ***** ] - Installing each item in new command to use cache and avoid download again ***** ***** ***** "
RUN apt-get install -y apt-utils
RUN apt-get install -y libfreetype6-dev
RUN apt-get install -y libjpeg62-turbo-dev
RUN apt-get install -y libcurl4-gnutls-dev
RUN apt-get install -y libxml2-dev
RUN apt-get install -y freetds-dev
RUN apt-get install -y git
RUN apt-get install -y mysql-client

#vim is usefull for debug container in interactive shell
RUN apt-get install -y vim
RUN apt-get install -y telnet
RUN apt-get install -y bzip2

RUN echo "[ ***** ***** ***** ] - Installing PHP Dependencies ***** ***** ***** "
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install soap

RUN docker-php-ext-install calendar
RUN apt-get update && apt-get install -y libpq-dev && docker-php-ext-install pdo

#Uncomment the block for install this packages
#Configurando extensões específicas do SQL SERVER
#RUN docker-php-ext-configure mssql --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install mssql
#RUN docker-php-ext-configure pdo_dblib --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install pdo_dblib

#Uncomment the block for install this packages
#Configurando extenções especificas do Mysql
RUN docker-php-ext-configure mysqli --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install mysqli
RUN docker-php-ext-configure pdo_mysql --with-libdir=/lib/x86_64-linux-gnu && docker-php-ext-install pdo_mysql

#Uncomment the block for install this packages
#Configurando extenções especificas do Postgres
#Install essential stuff
#git are required by composer
#RUN apt-get update && apt-get install -y \
#	libbz2-dev \
#	libmcrypt-dev \
#	libpng12-dev \
#	libghc-postgresql-libpq-dev \
#	&& docker-php-ext-install mcrypt mbstring bz2 zip \
#	&& docker-php-ext-configure pgsql -with-pgsql=/usr/include/postgresql/ \
#	&& docker-php-ext-install pgsql pdo_pgsql


# Install Composer
#RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer


RUN chmod +x -R /tmp/src/

#Similar ao comando CD do terminal. Permite setar o diretório que o trabalho ocorrerá (Na Imagem).
WORKDIR /var/www/

EXPOSE 80
EXPOSE 443
EXPOSE 8888
#EXPOSE 9000

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]

RUN echo "[ Step 03 ] - Begin of Actions inside Image ***** ***** ***** "

# Comentar esta linha quando for subir a imagem depois do build realizado.
# CMD /tmp/src/actions/start.sh
