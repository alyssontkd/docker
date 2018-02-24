#!/bin/bash
set -e
echo "[ ****************** ] Configuring username and password for git"

echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/html/siep.projecao.br" ] || ! [ -d "/var/www/html/siep.projecao.br/config/autoload" ]; then
    echo "Application not found in /var/www/siep.projecao.br - cloning now..."
    if [ "$(ls -A)" ]; then
        echo "WARNING: /var/www/html/siep.projecao.br is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    echo "[ ****************** ] Cloning Project repository to tmp folder"
    echo "[ ****************** ] Path of the repository. Ex: http://git.cultura.gov.br/sistemas/siep.projecao.br_hepta.git"

    #Utilizado para Repositório com HTTPS
    #git clone -b 'develop' https://$(GIT_USER):$(GIT_PASS)@github.com/alyssontkd/siep.git /tmp/siep.projecao.br
    git clone -b 'dev-alysson' https://alyssontkd:alysson123@github.com/alyssontkd/ejur.git /tmp/siep.projecao.br

    ls -la /tmp/siep.projecao.br

    echo "[ ****************** ] Copying Project from temporary folder to workdir"
    cp /tmp/siep.projecao.br -av /var/www/html

    echo "[ ****************** ] Copying sample application configuration to real one"
    cp /var/www/html/siep.projecao.br/config/autoload/development.exemplo.php /var/www/html/siep.projecao.br/config/autoload/development.php
    cp /var/www/html/siep.projecao.br/config/autoload/gerador.exemplo.php /var/www/html/siep.projecao.br/config/autoload/gerador.php
    cp /var/www/html/siep.projecao.br/config/autoload/global.exemplo.php /var/www/html/siep.projecao.br/config/autoload/global.php

    ls -la /var/www/html/siep.projecao.br

    echo "[ ****************** ] Creating the cache folder of the application and set permissions"
    if ! [ -d "/var/www/html/siep.projecao.br/data/cache" ]; then
        mkdir /var/www/html/siep.projecao.br/data/cache
        chmod -R 777 /var/www/html/siep.projecao.br/data/cache
    fi


    echo "[ ****************** ] Creating the cache folder of the layout and set permissions"
    if ! [ -d "/var/www/html/siep.projecao.br/public/assets/cache" ]; then
        mkdir /var/www/html/siep.projecao.br/public/assets/cache
        chmod -R 777 /var/www/html/siep.projecao.br/public/assets/cache
    fi

    echo "[ ****************** ] Creating the files folder of the application and set permissions"
    if ! [ -d "/var/www/html/siep.projecao.br/data/arquivos" ]; then
        mkdir /var/www/html/siep.projecao.br/data/arquivos
        chmod -R 777 /var/www/html/siep.projecao.br/data/arquivos
    fi


    echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
    chown www-data:www-data -R /var/www/html/siep.projecao.br

fi

#Instalando esta extensão porque ocoreia um erro ao tentar instalar pelo Dockerfile
docker-php-ext-install bcmath

echo "[ ****************** ] Ending Endpoint of Application"
exec "$@"
