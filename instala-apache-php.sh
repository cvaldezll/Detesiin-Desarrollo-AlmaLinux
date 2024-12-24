#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi


#* APACHE

#* Instala Apache
yum install httpd -y

#* Abre servicios y puerto
firewall-cmd --zone=public --permanent --add-service=http   #* servicio http
firewall-cmd --zone=public --permanent --add-service=https  #* servicio https
firewall-cmd --zone=public --permanent --add-port=8080/tcp  #* puerto 8080
firewall-cmd --reload										#* se recarga el firewall para q haga efecto los cambios
firewall-cmd --list-all										#* para verificar los servicios y puertos abiertos

#* Copia backup del archivo de configuración
cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.backup

#* Configura puerto 8080
echo "A continuación debe indicar el puerto de escucha de Apache."
echo "Ubicar la línea que dice 'Listen 80' y cambiarla por 'Listen 8080'."
read -n1 -p "Presiona cualquier tecla para continuar..."
nano /etc/httpd/conf/httpd.conf

#* Inicia Apache
systemctl start httpd										#* inicia
systemctl restart httpd										#* reinicia
systemctl status httpd  									#* estado
systemctl enable httpd										#* pone como inicio automático cuando inicie el S.O.
systemctl enable httpd										#* repetir esto si sale algun mensaje con la linea anterior


#* PHP

#* Actualiza repositorio PHP antes de la instalación
yum install http://rpms.remirepo.net/enterprise/remi-release-9.rpm -y
yum install yum-utils -y

#* Elige la versión de PHP
yum module list php -y										#* para ver las versiones disponibles
yum module reset php -y										#* reseteando (cuando hubiera algo q resetear)

lcStream="remi-8.1"
read -p "De la columna 'Stream [$lcStream]' elije y escribe la versión a instalar: " lcStreamNew
lcStream=${lcStreamNew:-$lcStream}
lcStream="php:$lcStream"

#* Instala PHP
yum module enable $lcStream -y                              #* selección de la version
yum install php -y											#* instala
php -v														#* ver versión instalada

#* Crea archivo PHP de prueba
lcDirWeb="/var/www/html/"
lcArchInfo="${lcDirWeb}info.php"
if [ -d "$lcDirWeb" ]; then
    echo "<?php phpinfo(); ?>" > $lcArchInfo
else
    echo "El directorio ${lcDirWeb} no existe."
fi

#* Reinicia Apache
if systemctl status apache2 > /dev/null 2>&1; then
    systemctl restart httpd
    systemctl status httpd
else
    echo "Apache no está instalado o no está funcionando."
fi