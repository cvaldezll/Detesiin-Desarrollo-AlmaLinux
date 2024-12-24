#!/bin/bash

#* ESTE SCRIPT SE DEBE EJECUTAR CON `root`

#* Validando parámetros
tcAlias=$1
tcDirec=$2

if [ -z "$tcAlias" ] || [ -z "$tcDirec" ]; then
    echo "No se ha enviado los parámetros necesarios."
    exit 1
fi

if ! [[ "$tcAlias" =~ ^[a-zA-Z0-9_]+$ ]]; then
    echo "El alias ${tcAlias} es inválido."
    exit 1
fi

if [ ! -d "$tcDirec" ]; then
    echo "El directorio ${tcDirec} no existe."
    exit 1
fi

if ! systemctl status apache2 > /dev/null 2>&1; then
    echo "Apache no está instalado o no está funcionando."
    exit 1
fi


#* Archivo de configuración que se creará
lcArchConf="/etc/httpd/conf.d/$tcAlias.conf"
if [ -f "$lcArchConf" ]; then
    rm -f $lcArchConf
fi


#* Contenido del archivo de configuración
echo "Alias /$tcAlias $tcDirec" >> "$lcArchConf"
echo "<Directory $tcDirec>" >> "$lcArchConf"
echo "   Options Indexes FollowSymLinks MultiViews" >> "$lcArchConf"
echo "   AllowOverride None" >> "$lcArchConf"
echo "   Require all granted" >> "$lcArchConf"
echo "</Directory>" >> "$lcArchConf"


#* Reinicia Apache
systemctl restart httpd