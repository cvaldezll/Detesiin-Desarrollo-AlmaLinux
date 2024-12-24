#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi

#* Se asigna permiso 777 para que desde Windows se pueda usar los archivos con el usuario Samba (ooo => permisos de otros)

lcArchZip="/home/oficina/Respaldo/Desarrollo.zip"
if [ -f "$lcArchZip" ]; then
    unzip $lcArchZip -d /
    chmod -R 777 /home/oficina/Desarrollo
else
    echo "El archivo $lcArchZip no existe, restaurarlo manualmente"
fi

lcArchZip="/home/oficina/Respaldo/Produccion.zip"
if [ -f "$lcArchZip" ]; then
    unzip $lcArchZip -d /
    chmod -R 777 /home/oficina/Produccion
else
    echo "El archivo $lcArchZip no existe, restaurarlo manualmente"
fi

lcArchZip="/home/oficina/Respaldo/Documentos.zip"
if [ -f "$lcArchZip" ]; then
    unzip $lcArchZip -d /
    chmod -R 777 /home/oficina/Documentos
else
    echo "El archivo $lcArchZip no existe, restaurarlo manualmente"
fi