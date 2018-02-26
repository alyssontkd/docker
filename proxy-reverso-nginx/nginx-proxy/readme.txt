# Primeiro Instale o NGINX com os seguintes comandos para Ubuntu
sudo apt-get install nginx -y

cd /etc/nginx/sites-enabled/

# Agora copie os arquivos fhe.conf e poupex.conf para este diretorio
cp -av /var/docker/nginx-proxy/fhe.conf .
cp -av /var/docker/nginx-proxy/poupex.conf . 

#Reinicie o servidor web
sudo service nginx restart

OBS: O caminho /var/docker/nginx-proxy/fhe.conf e /var/docker/nginx-proxy/poupex.conf era  onde estavam meus arquivos de configuração do NGINX
Neste Diretorio temos dois modelos de arquivos para cada um dos sites. Qualquer um dos sois vai funcionar perfeitamente.
