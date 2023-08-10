#!/bin/bash

USERNAME="postgres"
PASSWORD="bao123"
DATABASE="maps"
BACKUP_DIR="/home/user1/Downloads/baophung2/database_backup"

# Backup database
mkdir -p $BACKUP_DIR
BACKUP_FILE="$BACKUP_DIR/$DATABASE-$(date +%Y%m%d-%H%M%S).sql"
/usr/lib/postgresql/15/bin/pg_dump -U $USERNAME -h localhost -d $DATABASE -f $BACKUP_FILE -F p

# Kiểm tra xem lệnh pg_dump có thành công hay không
if [ $? -eq 0 ]; then
  echo "Backup database $DATABASE completed: $BACKUP_FILE"
else
  echo "Backup database $DATABASE failed!"
  exit 1
fi
