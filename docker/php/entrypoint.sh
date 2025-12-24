#!/bin/sh
set -e

echo "Entrypoint: Démarrage des actions post-déploiement..."

# S'assurer des droits et créer les dossiers persistants
chown -R www-data:www-data /var/www/html || true
mkdir -p /var/www/html/var/cache /var/www/html/var/log /var/www/html/public/uploads
chown -R www-data:www-data /var/www/html/var /var/www/html/public/uploads

if [ ! -f .env ]; then
    echo "Fichier .env manquant, création d'un fichier vide pour satisfaire Symfony..."
    touch .env
fi

# Installer les dépendances
echo "Installation/mise à jour des dépendances..."
composer install --no-interaction --prefer-dist --optimize-autoloader

chown -R www-data:www-data /var/www/html/vendor || true

# Attente DB et Migrations
echo "Attente de la base de données..."
until php bin/console doctrine:database:create --if-not-exists --no-interaction > /dev/null 2>&1; do
    echo "MariaDB n'est pas encore prête... on attend 2 secondes."
    sleep 2
done

echo "Base de données connectée !"

echo "Exécution des migrations..."
php bin/console doctrine:migrations:migrate --no-interaction --allow-no-migration

# Exécuter les autres tâches
echo "Exécution des tâches finales (Assets et Cache)..."
php bin/console assets:install public --symlink
php bin/console cache:clear
php bin/console cache:warmup
chown -R www-data:www-data /var/www/html/var /var/www/html/public/uploads

echo "Entrypoint finished. Lancement du serveur Apache..."
exec apache2-foreground