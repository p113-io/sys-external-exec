#!/usr/bin/env bash

## Cambiar al directorio /root/
cd /root/

# Clonar el repositorio Git
git clone https://github.com/p113-io/sys-admin.git

## Cambiar al directorio del repositorio clonado
cd sys-admin

## Asignar permisos de ejecución a update.sh
chmod +x auto-update.sh
#
## Ejecutar update.sh
./auto-pdate.sh
