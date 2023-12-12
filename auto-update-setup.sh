#!/usr/bin/env bash

# Verificar si el script se está ejecutando como root
if [ "$(id -u)" != "0" ]; then
    echo "Este script debe ser ejecutado como root. Saliendo."
    exit 1
fi

# Cambiar al directorio /root/
cd /root/

# Verificar si el directorio sys-admin existe
if [ -d "sys-admin" ]; then
    # Si existe, cambiar al directorio y actualizar el repositorio
    echo "El directorio sys-admin ya existe. Actualizando..."
    cd sys-admin
    git pull
else
    # Si no existe, clonar el repositorio
    echo "Clonando el repositorio sys-admin..."
    git clone https://github.com/p113-io/sys-admin.git
    cd sys-admin
fi

# Asignar permisos de ejecución a auto-update.sh
chmod +x auto-update.sh

# Ejecutar auto-update.sh
./auto-update.sh
