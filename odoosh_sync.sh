#!/bin/bash

echo "Escoge la acción a realizar (1 o 2):"
echo "1. Sincronizar repositorio de Odoo.sh a Gitlab."
echo "2. Sincronizar repositorio de Gitlab a Odoo.sh"
read action

# Clonar repositorio de Odoo.sh seleccionando una rama existente
if  [ $action == 1 ]; then
echo "Odoo.sh -> Local"
mkdir './odoo/custom/src/tmp'
cd './odoo/custom/src/tmp'
echo 'Introduce la url del repositorio: '
read url
echo '-------------------------------------'
git clone $url
echo 'Introduce el nombre de la rama: '
git branch -l
read branch
git checkout ${branch}
git pull
echo '--------------------------------------'
echo 'Introduce el nombre del repositorio: '
read repo_name
cp -a ${repo_name}/* ./../private_sync
cd ..
sudo rm -r ./tmp


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
mkdir './odoo/custom/src/tmp'
cd './odoo/custom/src/tmp'
echo 'Introduce la url del repositorio: '
read url
echo '-------------------------------------'
git clone $url
echo 'Introduce el nombre de la rama: '
git branch -l
read branch
git checkout ${branch}
git pull
echo '--------------------------------------'
echo 'Introduce el nombre del repositorio: '
read repo_name
cp -a ./../private_sync ${repo_name}/*
git init
git add .
git commit -m "${message}"
echo 'Push a Odoo.sh...'
git push
cd ..
sudo rm -r ./tmp
# Posible mejora: Clonar repositorio creando una nueva rama (para hacer PR)
else
echo "Error: Introduzca una opción válida."
fi
