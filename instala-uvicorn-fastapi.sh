#!/bin/bash

if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi


#* PYTHON y PIP

if command -v python3 > /dev/null 2>&1; then
    lcPyVer=$(python3 --version)
    echo "Python ya estaba instalado: $lcPyVer"
else
    dnf install python3 -y
fi

if command -v pip3 > /dev/null 2>&1; then
    lcPipVer=$(pip3 --version)
    echo "PIP ya estaba instalado: $lcPipVer"
else
    dnf install python3-pip -y
fi


#* FASTAPI y UVICORN

if pip show fastapi > /dev/null 2>&1; then
    echo "FastAPI ya estaba instalado."
else
    pip3 install fastapi
fi

if pip show uvicorn > /dev/null 2>&1; then
    echo "Uvicorn ya estaba instalado."
else
    pip3 install uvicorn
fi

pip3 list


echo "A continuación se abrirá el puerto que escuchará Uvicorn..."
lcPort="8000"
read -p "Puerto Uvicorn [$lcPort]: " lcPortNew
lcPort=${lcPortNew:-$lcPort}
firewall-cmd --zone=public --permanent --add-port=$lcPort/tcp
firewall-cmd --reload                                       #* se recarga el firewall para q haga efecto los cambios
firewall-cmd --list-all                                     #* para verificar los servicios y puertos abiertos


#* Crea archivo PYTHON de prueba

lcDirWeb="/var/www/html/"
lcArchWeb="info.py"
lcArchInfo="${lcDirWeb}${lcArchWeb}"
if [ -d "$lcDirWeb" ]; then
    if [ -f "$lcArchInfo" ]; then
        rm -f $lcArchInfo
    fi

    wget -P $lcDirWeb -O $lcArchWeb https://raw.githubusercontent.com/cvaldezll/Script-Detesiin-Desarrollo-AlmaLinux/master/fastapi_info.py

    if [ -f "$lcArchInfo" ]; then
        echo "Se ha creado el archivo ${lcArchInfo}"
    fi
else
    echo "El directorio ${lcDirWeb} no existe."
fi