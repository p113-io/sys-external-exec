# sys-external-exec
List of scripts to admin sys infrastructure

## Script de Configuración (`auto-update-setup`)
El script `auto-update-setup` realiza las siguientes tareas:
- Verifica si el usuario actual es `root`. Si no, termina la ejecución.
- Cambia al directorio `/root/`.
- Verifica si el directorio `sys-admin` ya existe. Si existe, realiza un `git pull` para actualizarlo. Si no, lo clona del repositorio remoto.
- Cambia al directorio del repositorio clonado `sys-admin`.
- Asigna permisos de ejecución al script `auto-update.sh`.
- Ejecuta el script `auto-update.sh`.

## Usa lo :

1. **Con Curl**:
   ```bash
   curl -s https://raw.githubusercontent.com/p113-io/sys-external-exec/main/auto-update-setup.sh | sudo bash
   ```
   Este comando descarga el script con `curl` y lo pasa directamente a `bash` para su ejecución.

2. **Con Wget**:
   ```bash
   wget -qO- https://raw.githubusercontent.com/p113-io/sys-external-exec/main/auto-update-setup.sh | sudo bash
   ```
