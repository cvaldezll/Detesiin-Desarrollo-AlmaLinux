#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi

#* Crea carpetas de trabajo, la carpeta 'oficina' no debe ser de ningun Usuario del S.O.
mkdir /home/oficina
mkdir /home/oficina/Desarrollo
mkdir /home/oficina/Desarrollo/BD
mkdir /home/oficina/Desarrollo/Fuentes
mkdir /home/oficina/Produccion
mkdir /home/oficina/Documentos
mkdir /home/oficina/Documentos/ChristianValdez
mkdir /home/oficina/Respaldo
mkdir /home/oficina/CustodiaCpe
chmod -R 775 /home/oficina          #* permisos

#* Crea usuario Samba que se logueará desde windows, debe empezar con 'smb' para q no haya conflicto con windows
useradd -M -s /sbin/nologin smbcvaldez
passwd smbcvaldez                   #* tener a la mano la contraseña que le asignará

#* Crea grupos
groupadd administradores
groupadd programadores
groupadd produccion

#* Se asigna usuarios a los grupos, el usuario 'admin' a todos los grupos si o si
gpasswd -a admin administradores
gpasswd -a admin programadores
gpasswd -a admin produccion
gpasswd -a smbcvaldez administradores
gpasswd -a smbcvaldez programadores
gpasswd -a smbcvaldez produccion    #* usuario por usuario se asigna a este grupo

#* Se asigna grupos a sus carpetas respectivas
#* Tener en cuenta que la asignación es de un grupo por carpeta
#* No es como windows donde se puede asignar diferentes grupos a una misma carpeta
chgrp -R administradores /home/oficina/Documentos/
chgrp -R administradores /home/oficina/Respaldo/
chgrp -R administradores /home/oficina/CustodiaCpe/
chgrp -R programadores /home/oficina/Desarrollo/
chgrp -R produccion /home/oficina/Produccion/