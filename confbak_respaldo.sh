#!/bin/bash

echo "Borrando los backups previos..."
rm /home/oficina/Respaldo/Desarrollo.zip
rm /home/oficina/Respaldo/Produccion.zip
rm /home/oficina/Respaldo/Documentos.zip
#
echo "Generando los nuevos backups..."
zip -r /home/oficina/Respaldo/Desarrollo /home/oficina/Desarrollo
zip -r /home/oficina/Respaldo/Produccion /home/oficina/Produccion
zip -r /home/oficina/Respaldo/Documentos /home/oficina/Documentos