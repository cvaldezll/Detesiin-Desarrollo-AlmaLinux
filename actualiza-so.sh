if [[ ! "$1" == "ACEPTAR" ]]; then
    lcNombArchSH=$(basename "$0")
    echo "Ejecutar así: $lcNombArchSH ACEPTAR"
    exit 1
fi

#* Actualiza S.O.
dnf check-update
dnf update

#* Actualiza repositorio base
yum install epel-release -y