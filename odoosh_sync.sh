#!/bin/bash
echo "Escoge la acción a realizar (1 o 2):"
echo "1. Sincronizar repositorio de Odoo.sh a Gitlab."
echo "2. Sincronizar repositorio de Gitlab a Odoo.sh"
read action

# Clonar repositorio de Odoo.sh seleccionando una rama existente
if  [ $action == 1 ]; then
mkdir './odoo/custom/src/tmp'
cd './odoo/custom/src/tmp'
echo 'Introduce la url del repositorio de Odoo.sh: '
read url
echo ''
echo '--------CLONING FROM ODOO.SH----------'
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
sudo rm -r './tmp'

# Subir los cambios al repositorio de Odoo.sh
elif  [ $action == 2 ]; then
# Actualizar repositorio local
echo ''
echo '-----------GIT PULL GITLAB--------------'
echo 'Introduce tus credenciales arriba (si es necesario)'
git pull
git add .
echo '----------------------------------------'
echo 'Introduce el mensaje del commit: '
read message
git commit -m "${message}"
echo '----------PUSH A GITLAB-----------'
git push
echo '----------------------------------'

# Actualizar repositorio de Odoo.sh
mkdir './odoo/custom/src/tmp'
cd './odoo/custom/src/tmp'
echo ''
echo 'Introduce la url del repositorio: '
read url
echo '------------CLONING FORM ODOO.SH----------------'
git clone $url
git pull
echo '------------------------------------------------'
echo 'Introduce el nombre del repositorio: '
read repo_name
cd ${repo_name}
echo 'Introduce el nombre de la rama: '
git branch -l
read branch
echo '-------GIT PULL ODOO.SH BRANCH--------'
git checkout ${branch}
git pull
echo '--------------------------------------'
cp -a ./../../private_sync/* .
echo '------MAKING COMMIT FOR ODOO.SH-------'
git init
git add .
git commit -m "${message}"
echo '--------------------------------------'
echo '----------PUSH A ODOO.SH-----------'
git push
echo '-----------------------------------'
cd '../..'
sudo rm -r './tmp'
# Posible mejora: Clonar repositorio creando una nueva rama (para hacer PR)
else
echo "Error: Introduzca una opción válida."
fi
