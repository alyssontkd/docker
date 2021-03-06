#!/bin/bash
set -e

echo "[ ****************** ] Starting Endpoint of Application"
if ! [ -d "/var/www/html/dev.glpi.com.br/vendor" ]; then
    echo "Application not found in /var/www/html/dev.glpi.com.br - Downloading now..."
    if [ "$(ls -A)" ]; then
        echo "WARNING: /var/www/html/dev.glpi.com.br is not empty - press Ctrl+C now if this is an error!"
        ( set -x; ls -A; sleep 10 )
    fi
    echo "[ ****************** ] Execute download of the GLPI"
    cd /tmp
    wget https://github.com/glpi-project/glpi/releases/download/9.1.1/glpi-9.1.1.tgz

    echo "[ ****************** ] Extract GLPI Application"
    tar -xvzf glpi-9.1.1.tgz

    echo "[ ****************** ] Copying sample application configuration to real one"
    mv glpi dev.glpi.com.br
    cp -av /tmp/dev.glpi.com.br /var/www/html/

    ls -la /var/www/html/dev.glpi.com.br

    echo "[ ****************** ] Changing owner and group from the Project to 'www-data' "
    chown www-data:www-data -R /var/www/html/dev.glpi.com.br
    chmod 775 /var/www/html -Rf

    echo "[ ****************** ] Enter in the directory of the application and clone the code of the 'vendor' project"
    cd /var/www/html/dev.glpi.com.br

fi

echo "[ ****************** ] Ending Endpoint of Application"
exec "$@"
