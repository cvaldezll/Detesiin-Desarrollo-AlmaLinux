#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi


#* Se descarga el script de respaldo.sh
lcDirectorio="/home/oficina/"
lcArchivo="respaldo.sh"
lcArchProc=$lcDirectorio$lcArchivo
if [ -f "$lcArchProc" ]; then
    rm -f $lcArchProc
fi

wget -P $lcDirectorio -O $lcArchivo https://raw.githubusercontent.com/cvaldezll/Script-Detesiin-Desarrollo-AlmaLinux/master/confbak_respaldo.sh
chmod 770 $lcArchProc


#* Se descarga el archivo de texto LEER_PRIMERO_AQUI.txt
lcDirectorio="/home/oficina/Respaldo/"
lcArchivo="LEER_PRIMERO_AQUI.txt"
lcArchProc=$lcDirectorio$lcArchivo
if [ -f "$lcArchProc" ]; then
    rm -f $lcArchProc
fi

wget -P $lcDirectorio -O $lcArchivo https://raw.githubusercontent.com/cvaldezll/Script-Detesiin-Desarrollo-AlmaLinux/master/confbak_leerprimeroaqui.txt
chmod 770 $lcArchProc