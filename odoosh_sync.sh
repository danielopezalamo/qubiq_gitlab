#!/bin/bash

echo "Escoge la acción a realizar (1 o 2):"
echo "1. Sincronizar repositorio de Odoo.sh a Gitlab."
echo "2. Sincronizar repositorio de Gitlab a Odoo.sh"
read action

# Clonar repositorio de Odoo.sh seleccionando una rama existente
if  [ $action == 1 ]; then
echo "Odoo.sh -> Local"
cd './odoo/custom/src/private_sync'
echo 'Introduce la url del repositorio: '
read url
echo 'Introduce el nombre del repositorio: '
read repo_name
echo '-------------------------------------'
git clone $url
echo 'Introduce el nombre de la rama: '
git branch -l
read branch
git checkout ${branch}
echo '--------------------------------------'

# Subir los cambios al repositorio de Odoo.sh
elif  [ $action == 2 ]; then
# Actualizar repositorio local

echo "Git pull: Introduce tus credenciales arriba (si es necesario)"
echo '-------------------------------------'
git pull
echo '-------------------------------------'
git add .
echo 'Introduce el mensaje del commit: '
read message
git commit -m "${message}"
echo 'Push a Gitlab...'
git push
# Actualizar repositorio de Odoo.sh
echo 'Introduce el nombre del repositorio (dentro de la carpeta private_sync): '
read repo_name
cd './odoo/custom/src/private_sync/'${repo_name}
git init
echo '-------------------------------------'
git pull
echo '-------------------------------------'
git add .
git commit -m "${message}"
echo 'Push a Odoo.sh...'
git push
# Posible mejora: Clonar repositorio creando una nueva rama (para hacer PR)
else
echo "Error: Introduzca una opción válida."
fi
