#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi

lcDirectorio="/home/oficina/"
lcArchivo="respaldo.sh"
lcArchRespaldo=$lcDirectorio$lcArchivo
if [ -f "$lcArchRespaldo" ]; then
    rm -f $lcArchRespaldo
fi

wget -P $lcDirectorio -O $lcArchivo https://raw.githubusercontent.com/cvaldezll/Script-Detesiin-Desarrollo-AlmaLinux/master/confbak_respaldo.sh

