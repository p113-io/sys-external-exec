#!/usr/bin/env bash

# Verificar si shellcheck está instalado
if ! command -v shellcheck &>/dev/null; then
  echo "shellcheck no encontrado. Instalando..."
  # Agregar aquí el comando de instalación
else
  echo "shellcheck ya está instalado."
fi

# Ubicación del archivo sudoers y del archivo de respaldo
SUDOERS_FILE="/etc/sudoers"
BACKUP_FILE="/etc/sudoers.bak"

# Si el usuario es root, no es necesario usar sudo
# shellcheck disable=SC2046
if [ $(id -u) -eq 0 ]; then
  # Crear una copia de seguridad del archivo sudoers
  if cp "$SUDOERS_FILE" "$BACKUP_FILE"; then
    echo "Copia de seguridad creada."
  else
    echo "Error al crear la copia de seguridad."
    exit 1
  fi

  # Agregar nuevas entradas con sed
  if ! sed -i '/^root\tALL=(ALL:ALL) ALL/a tom  ALL=(ALL) NOPASSWD:ALL\nsupport\tALL=(ALL) NOPASSWD:ALL' "$SUDOERS_FILE"; then
    echo "Error al modificar el archivo sudoers."
    cp "$BACKUP_FILE" "$SUDOERS_FILE"
    echo "Archivo sudoers restaurado desde la copia de seguridad."
    exit 1
  fi

  # Verificar la sintaxis con visudo
  if visudo -c; then
    echo "El archivo sudoers es sintácticamente correcto."
  else
    echo "Error de sintaxis detectado en el archivo sudoers."
    cp "$BACKUP_FILE" "$SUDOERS_FILE"
    echo "Archivo sudoers restaurado desde la copia de seguridad."
  fi
else
  # Si el usuario no es root, usar sudo
  # Crear una copia de seguridad del archivo sudoers
  if sudo cp "$SUDOERS_FILE" "$BACKUP_FILE"; then
    echo "Copia de seguridad creada."
  else
    echo "Error al crear la copia de seguridad."
    exit 1
  fi

  # Agregar nuevas entradas con sed
  if ! sudo sed -i '/^root\tALL=(ALL:ALL) ALL/a tom  ALL=(ALL) NOPASSWD:ALL\nsupport\tALL=(ALL) NOPASSWD:ALL' "$SUDOERS_FILE"; then
    echo "Error al modificar el archivo sudoers."
    sudo cp "$BACKUP_FILE" "$SUDOERS_FILE"
    echo "Archivo sudoers restaurado desde la copia de seguridad."
    exit 1
  fi

  # Verificar la sintaxis con visudo
  if sudo visudo -c; then
    echo "El archivo sudoers es sintácticamente correcto."
  else
    echo "Error de sintaxis detectado en el archivo sudoers."
    sudo cp "$BACKUP_FILE" "$SUDOERS_FILE"
    echo "Archivo sudoers restaurado desde la copia de seguridad."
  fi
fi

echo "done"
