#!/bin/bash

# Configurações de Backup
DB_USER="root"  # Usuário 
DB_PASS="password"  # Senha do MySQL
DB_NAME="nome_do_banco"  # Nome do BD
BACKUP_DIR="/var/backups/mysql"  # Diretório de destino dos backups
DATE=$(date +"%Y-%m-%d_%H-%M-%S")
RETENTION_DAYS=7  # Quantidade de dias para manter os backups antigos

# Criar diretório de backup, se não existir
mkdir -p ${BACKUP_DIR}

# Realizar o Backup Completo do Banco de Dados
mysqldump -u${DB_USER} -p${DB_PASS} ${DB_NAME} | gzip > ${BACKUP_DIR}/${DB_NAME}_backup_${DATE}.sql.gz

# Verificar se o backup foi realizado com sucesso
if [ $? -eq 0 ]; then
  echo "Backup do banco de dados ${DB_NAME} realizado com sucesso em ${DATE}."
else
  echo "Erro ao realizar o backup do banco de dados ${DB_NAME}." >&2
  exit 1
fi

# Excluir backups mais antigos que 7 dias
find ${BACKUP_DIR} -type f -name "${DB_NAME}_backup_*.sql.gz" -mtime +${RETENTION_DAYS} -exec rm {} \;

# Para agendar o script de backup, é necessário executar os seguintes comandos no terminal:

# crontab -e
# 0 3 * * * /usr/local/bin/backup_mysql.sh >> /var/log/mysql_backup.log 2>&1