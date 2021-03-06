#!/bin/bash
set -e
echo "[ ****************** ] Configuring username and password for git"

echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/html/plano_mudanca" ] || ! [ -d "/var/www/html/plano_mudanca/config/autoload" ]; then
    echo "Application not found in /var/www/plano_mudanca - cloning now..."
    if [ "$(ls -A)" ]; then
        echo "WARNING: /var/www/html/plano_mudanca is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    echo "[ ****************** ] Cloning Project repository to tmp folder"
    echo "[ ****************** ] Path of the repository. Ex: http://git.cultura.gov.br/sistemas/plano_mudanca_hepta.git"

    #Utilizado para Repositório com HTTPS
    #git clone -b 'develop' https://$(GIT_USER):$(GIT_PASS)@github.com/alyssontkd/etec.git /tmp/plano_mudanca
    git clone http://git.cultura.gov.br/sistemas/plano_mudanca_hepta.git /tmp/plano_mudanca

    ls -la /tmp/plano_mudanca

    echo "[ ****************** ] Copying Project from temporary folder to workdir"
    cp /tmp/plano_mudanca -av /var/www/html

    echo "[ ****************** ] Copying sample application configuration to real one"
    cp /var/www/html/plano_mudanca/config/autoload/development.exemplo.php /var/www/html/plano_mudanca/config/autoload/development.php
    cp /var/www/html/plano_mudanca/config/autoload/gerador.exemplo.php /var/www/html/plano_mudanca/config/autoload/gerador.php
    cp /var/www/html/plano_mudanca/config/autoload/global.exemplo.php /var/www/html/plano_mudanca/config/autoload/global.php

    ls -la /var/www/html/plano_mudanca

    echo "[ ****************** ] Creating the cache folder of the application and set permissions"
    if ! [ -d "/var/www/html/plano_mudanca/data/cache" ]; then
        mkdir /var/www/html/plano_mudanca/data/cache
        chmod -R 777 /var/www/html/plano_mudanca/data/cache
    fi


    echo "[ ****************** ] Creating the cache folder of the layout and set permissions"
    if ! [ -d "/var/www/html/plano_mudanca/public/assets/cache" ]; then
        mkdir /var/www/html/plano_mudanca/public/assets/cache
        chmod -R 777 /var/www/html/plano_mudanca/public/assets/cache
    fi

    echo "[ ****************** ] Creating the files folder of the application and set permissions"
    if ! [ -d "/var/www/html/plano_mudanca/data/arquivos" ]; then
        mkdir /var/www/html/plano_mudanca/data/arquivos
        chmod -R 777 /var/www/html/plano_mudanca/data/arquivos
    fi


    echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
    chown www-data:www-data -R /var/www/html/plano_mudanca
    
    #echo "[ ****************** ] Downloading composer "

    #php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
    #php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

    #echo "[ ****************** ] Installing composer "
    #php composer-setup.php

    #echo "[ ****************** ] Unlinking and moving composer to '/usr/local/bin/' directory"
    #php -r "unlink('composer-setup.php');"
    #mv composer.phar /usr/local/bin/composer

fi
echo "[ ****************** ] Ending Endpoint of Application"
exec "$@"
