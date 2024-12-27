#!/bin/bash

echo "Este SCRIPT no se debe ejecutar"
exit 1
#* RECORDATORIO DE COMANDOS EN GENERAL PARA ALMALINUX


#* Verificar el uso de disco
df -h

#* Versión del Kernel
uname -a

#* Versión del Distro
cat /etc/*-release

#* Crea grupo
groupadd $lcGrupo

#* Para identificar el Id del grupo
grep -i $lcGrupo /etc/group                         #* -i => indistingue mayúsculas y minúsculas

#* Cambia nombre del grupo
groupmod $lcGrupoOld -n $lcGrupoNew

#* Crea usuario
useradd $lcUsuario -c "$lcUsuarioNombreCompleto"    #* -c => comentario del usuario, puede ser el nombre del mismo

#* Asigna contraseña al usuario
passwd $lcUsuario

#* Asigna usuario al grupo
gpasswd -a $lcUsuario $lcGrupo

#* Borra usuario
userdel -r $lcUsuario                               #* -r => borra la carpeta del usuario de la carpeta /home


#* Administración de ficheros, se entiendo que un fichero puede ser un archivo o un directorio
$lcArchivo="/etc/group"                             #* archivo de los grupos
$lcArchivo="/etc/passwd"                            #* archivo de los usuarios
$lcArchivo="/etc/shadow"                            #* archivo de las contraseñas
more $lcArchivo                                     #* muestra el contenido del archivo
nano $lcArchivo                                     #* editor de texto

#* Cambia propietario de un fichero
chown -R $lcUsuario $lcFichero                      #* -R => recursividad si es un directorio

#* Cambia grupo de un fichero
chgrp -R $lcGrupo $lcFichero                        #* -R => recursividad si es un directorio

#* Cambia permisos de un fichero
ls -l                                               #* -l => muestra los permisos
#* -uuugggooo    => cuando es archivo
#* duuugggooo    => cuando es carpeta
#* uuu   => permisos de propietarios
#* ggg   => permisos de grupos
#* ooo   => permisos de otros
#* r=4       => lectura
#* w=2       => escritura
#* x=1       => ejecución
#* la suma de r w x es el permiso a asignar
$lcUUU="7"                                          #* r+w+x => rwx
$lcGGG="6"                                          #* r+w   => rw-
$lcOOO="4"                                          #* r     => r--
$lcPermisos="${lcUUU}${lcGGG}${lcOOO}"
chmod -R $lcPermisos $lcFichero                     #* -R => recursividad si es un directorio


#* Comprime ficheros
zip -r $lcArchZip $lcFichero                        #* -r => recursividad si es un directorio

#* Descomprime ficheros
#* Tener presente que se descomprime con toda la ruta que tiene incluído el archivo .ZIP
unzip $lcArchZip -d $lcDirectorio                   #* -d => directorio de destino


#* Apaga y reinicia el S.O.
shutdown -r                                         #* -r    => reinicia
shutdown now                                        #* now   => apaga ahora mismo
shutdown -k                                         #* -k    => avisa a los usuarios pero no apaga
shutdown -f                                         #* -f    => apaga sin preguntar o forza el apagado
shutdown 20:50                                      #* 20:50 => apaga en la hora indicada
shutdown 5                                          #* 5     => apaga en N minutos
shutdown -c                                         #* -c    => cancela el apagado


#* Agrega Alias en Apache con `root`: ./apache-alias.sh ALIAS DIRECTORIO
#* DIRECTORIO tiene que se ruta completa y tiene que estar creado previamente
#* Ejemplo: ./apache-alias.sh prueba /usr/share/WebsDesarrollo/prueba/


#* Ejecuta Servidor Uvicorn
cd /var/www/html/                                   #* ubica la carpeta del archivo de Python
uvicorn info:app --host 0.0.0.0 --port 8000         #* ejecuta el archivo info.py en el puerto 8000