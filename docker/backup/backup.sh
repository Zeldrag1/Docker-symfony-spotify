#!/bin/sh
# 1. On garde set -e pour arrêter le script en cas de pépin
set -e

TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR=/backup
UPLOADS_DIR=/uploads

mkdir -p ${BACKUP_DIR}

# --- MySQL dump ---
if [ -n "${DB_HOST:-}" ] && [ -n "${DB_USER:-}" ]; then
    echo "Tentative de sauvegarde de la base de données..."
    
    # Alternative au || true : Si ça rate, on affiche un message et le script s'arrête
    mariadb-dump -h ${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} > ${BACKUP_DIR}/db_${TIMESTAMP}.sql || { echo "ERREUR : Le dump SQL a échoué"; exit 1; }
    
    gzip -f ${BACKUP_DIR}/db_${TIMESTAMP}.sql || { echo "ERREUR : La compression Gzip a échoué"; exit 1; }
    
    echo "Sauvegarde SQL réussie."
fi

# --- Zip uploads ---
if [ -d "${UPLOADS_DIR}" ]; then
    echo "Tentative de sauvegarde des uploads..."
    
    cd ${UPLOADS_DIR}
    # On enlève le || true pour être sûr que l'archive est créée
    tar -czf ${BACKUP_DIR}/uploads_${TIMESTAMP}.tar.gz . || { echo "ERREUR : La création de l'archive tar a échoué"; exit 1; }
    
    echo "Sauvegarde des uploads réussie."
fi

# --- Nettoyage ---
echo "Nettoyage des anciens backups..."
ls -1t ${BACKUP_DIR} | tail -n +15 | xargs -r -I{} rm -f ${BACKUP_DIR}/{}

echo "--- Backup terminé avec succès ---"