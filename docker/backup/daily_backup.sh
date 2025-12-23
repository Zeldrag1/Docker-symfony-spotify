#!/bin/sh
# Simple backup script: dump DB + zip uploads

set -e
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
BACKUP_DIR=/backup
UPLOADS_DIR=/uploads

mkdir -p ${BACKUP_DIR}

# MySQL dump (utilise mariadb-client présent dans l'image if installed)
if [ -n "${DB_HOST:-}" ] && [ -n "${DB_USER:-}" ]; then
  mysqldump -h ${DB_HOST:-database} -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} > ${BACKUP_DIR}/db_${TIMESTAMP}.sql || true
  gzip -f ${BACKUP_DIR}/db_${TIMESTAMP}.sql || true
fi

# Zip uploads
if [ -d "${UPLOADS_DIR}" ]; then
  cd ${UPLOADS_DIR}
  tar -czf ${BACKUP_DIR}/uploads_${TIMESTAMP}.tar.gz . || true
fi

# Prune older backups (keep 14)
ls -1t ${BACKUP_DIR} | tail -n +15 | xargs -r -I{} rm -f ${BACKUP_DIR}/{} || true
