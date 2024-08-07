#!/bin/bash

# Nome do container
CONTAINER_NAME="doctor-postgres"

# Nome do usuário do banco de dados
DB_USER="postgres"

# Senha do usuário do banco de dados
DB_PASSWORD="8&pj@GSN4q!1z7&22L2SfBKbb@n@"

# Nome do banco de dados
DB_NAME="doctor"

# Data atual no formato desejado
CURRENT_DATE=$(date +%d-%m-%Y)

# Caminho dentro do container onde o backup será salvo
CONTAINER_BACKUP_PATH="/var/lib/postgresql/data/backup-$CURRENT_DATE.tar"

# Caminho no host onde o backup será copiado
HOST_BACKUP_PATH="/root/pastabackup/backup-$CURRENT_DATE.tar"

# Comando para criar o backup dentro do container
docker exec -u postgres $CONTAINER_NAME bash -c "export PGPASSWORD=$DB_PASSWORD && pg_dump -U $DB_USER -F t $DB_NAME -f $CONTAINER_BACKUP_PATH"

# Comando para copiar o backup do container para o host
docker cp $CONTAINER_NAME:$CONTAINER_BACKUP_PATH $HOST_BACKUP_PATH

# Mensagem de conclusão
echo "Backup concluído e copiado para $HOST_BACKUP_PATH"