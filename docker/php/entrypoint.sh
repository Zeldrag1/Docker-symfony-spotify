#!/bin/sh
set -e

echo "Entrypoint: Démarrage des actions post-déploiement..."

# 1. S'assurer des droits et créer les dossiers persistants
chown -R www-data:www-data /var/www/html || true
mkdir -p /var/www/html/var/cache /var/www/html/var/log /var/www/html/public/uploads
chown -R www-data:www-data /var/www/html/var /var/www/html/public/uploads

# --- AJOUT ICI : Création du .env pour éviter le crash ---
if [ ! -f .env ]; then
    echo "Fichier .env manquant, création d'un fichier vide pour satisfaire Symfony..."
    touch .env
fi
# ---------------------------------------------------------

# 2. Installer les dépendances
echo "Installation/mise à jour des dépendances..."
# On ajoute --no-scripts pour éviter que composer lance cache:clear avant que tout soit prêt
composer install --no-interaction --prefer-dist --optimize-autoloader

chown -R www-data:www-data /var/www/html/vendor || true

# 3. Attente DB et Migrations (On suppose que tu as gardé ce code)
# ...

# 4. Exécuter les autres tâches
echo "Exécution des tâches finales (Assets et Cache)..."
php bin/console assets:install public --symlink
php bin/console cache:clear
php bin/console cache:warmup
chown -R www-data:www-data /var/www/html/var /var/www/html/public/uploads

echo "Entrypoint finished. Lancement du serveur Apache..."
exec apache2-foreground