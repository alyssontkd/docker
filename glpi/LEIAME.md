[![Build Status](https://secure.travis-ci.org/glpi-project/glpi.svg?branch=master)](https://secure.travis-ci.org/glpi-project/glpi)

![GLPi Logo](https://raw.githubusercontent.com/glpi-project/glpi/master/pics/logos/logo-GLPI-250-black.png)

## Antes da instalação
* Crie a um usuário padrão
 - mysql -u root -p
 - mysql> create database glpi;
 - mysql> create user 'usr_aplicacao'@'%' identified by '12345678';
 - mysql> grant all on glpi.* to usr_aplicacao identified by '12345678';
 - mysql> flush privileges;
 - mysql> quit;


## Instalação
* Para realizar a customização da imagem e criação do contêiner:
 - Acesse o diretório raiz
 - Digite o comando docker-compose up -d


## Após a instalação
* Por motivos de segurança, por favor: 
 - Altere as senhas dos usuários padrão: glpi post-only tech normal 
 - Por favor remova o arquivo: install/install.php 
 
* Os usuários e senhas padrões são:
 - glpi/glpi para a conta do usuário administrador
 - tech/tech para a conta do usuário técnico
 - normal/normal para a conta do usuário normal
 - post-only/postonly para a conta do usuário postonly

* Você pode excluir ou modificar estes usuários bem como os dados iniciais.


## License

It is distributed under the GNU GENERAL PUBLIC LICENSE Version 2 - please consult the file called [COPYING](https://raw.githubusercontent.com/glpi-project/glpi/master/COPYING.txt) for more details.


