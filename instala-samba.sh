#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi

#* VIDEO MANUAL: https://youtu.be/SfLCnSY_z0s
#*               https://youtu.be/lInuZPRxFjE

#* INSTALA

yum install samba samba-client samba-common samba-libs -y   #* instala
firewall-cmd --zone=public --permanent --add-service=samba  #* abre el servicio samba en el firewall
firewall-cmd --zone=public --permanent --add-port=137/tcp   #* abre un puerto q usa samba
firewall-cmd --zone=public --permanent --add-port=138/tcp   #* abre otro puerto q usa samba
firewall-cmd --reload                                       #* se recarga el firewall para q haga efecto los cambios
firewall-cmd --list-all                                     #* para verificar los servicios y puertos abiertos

#* CONFIGURA

#* Copia backup del archivo de configuración
cp /etc/samba/smb.conf /etc/samba/smb.conf.backup
#* Reemplaza el contenido del archivo de configuración
wget -O /etc/samba/smb.conf https://raw.githubusercontent.com/cvaldezll/Script-Detesiin-Desarrollo-AlmaLinux/master/smb.conf

#* Asigna contraseña Samba al usuario linux, con esta contraseña se loguea desde windows
smbpasswd -a smbcvaldez                                     #* tener a la mano la contraseña que le asignará

#* Da permisos de escritura en SELINUX (tienen que ser las mismas rutas de smb.conf)
chcon -t samba_share_t /home/oficina/Desarrollo/BD/
chcon -t samba_share_t /home/oficina/Desarrollo/Fuentes/
chcon -t samba_share_t /home/oficina/Produccion/
chcon -t samba_share_t /home/oficina/Documentos/ChristianValdez/
chcon -t samba_share_t /home/oficina/Respaldo/

#* Termina la configuración de Samba
systemctl start smb                                         #* inicia
systemctl restart smb										#* reinicia
systemctl status smb                                        #* estado
systemctl enable smb										#* pone como inicio automático cuando inicie el S.O.
systemctl enable smb                                        #* repetir esto sólo si sale algún mensaje con la línea anterior
testparm                                                    #* otra forma de verificar el estado



echo "Tener presente activar SMB en las características de Windows"