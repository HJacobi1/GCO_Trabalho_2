#!/bin/bash

# Configuração do banco de dados
DB_HOST=$1
DB_PORT=$2
DB_NAME=$3
DB_USER=$4
DB_PASSWORD=$5
MIGRATIONS_DIR="./sql_scripts"

export PGPASSWORD=$DB_PASSWORD

# Verificar se a tabela de controle existe
psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "
CREATE TABLE IF NOT EXISTS migration_history (
    id SERIAL PRIMARY KEY,
    migration_name TEXT NOT NULL UNIQUE,
    applied_at TIMESTAMP DEFAULT NOW()
);
"

# Aplicar novas migrações
for file in $(ls $MIGRATIONS_DIR/*.sql | sort); do
    MIGRATION_NAME=$(basename "$file")

    # Verificar se a migração já foi executada
    RESULT=$(psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -t -c \
        "SELECT COUNT(*) FROM migration_history WHERE migration_name = '$MIGRATION_NAME';" | xargs)

    if [ "$RESULT" -eq "0" ]; then
        echo "Aplicando migração: $MIGRATION_NAME"
        psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -f "$file"

        # Registrar a migração como aplicada
        psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c \
            "INSERT INTO migration_history (migration_name) VALUES ('$MIGRATION_NAME');"
    else
        echo "Migração já aplicada: $MIGRATION_NAME"
    fi
done
