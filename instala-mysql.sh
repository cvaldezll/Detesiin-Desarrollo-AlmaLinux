#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi

yum install mysql-server -y #* instala
systemctl start mysqld      #* inicia
systemctl status mysqld     #* estado


echo "A continuación se debe configurar manualmente MySQL..."
echo "Tener a la mano la contraseña que le asignará al usuario `root`..."
echo "Aparecerá unas preguntas para dehabilitar cosas, leer bién las preguntas..."
mysql_secure_installation


#* Pone como inicio automático cuando inicie el S.O.
systemctl enable mysqld
systemctl enable mysqld


echo "A continuación se abrirá el puerto que escuchará MySQL..."
lcPort="3306"
read -p "Puerto MySQL [$lcPort]: " lcPortNew
lcPort=${lcPortNew:-$lcPort}
firewall-cmd --zone=public --permanent --add-port=$lcPort/tcp
firewall-cmd --reload       #* se recarga el firewall para q haga efecto los cambios
firewall-cmd --list-all     #* para verificar los servicios y puertos abiertos


echo "A continuación se creará una BD y su usuario de acceso remoto..."
read -p "Nombre de la BD: " lcNombBD
read -p "Nombre del usuario MySQL: " lcUsrMySQL
read -p "Contraseña del usuario MySQL: " lcPassMySQL
read -p "IP remota: " lcIpRemota
mysql -u root -p -e "
SELECT VERSION();
CREATE DATABASE $lcNombBD;
CREATE USER '$lcUsrMySQL'@'$lcIpRemota' IDENTIFIED BY '$lcPassMySQL';
GRANT ALL PRIVILEGES ON $lcNombBD.* TO '$lcUsrMySQL'@'$lcIpRemota';
FLUSH PRIVILEGES;
"