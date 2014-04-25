#! /bin/bash

TIMESTAMP=$(date +"%F")
BACKUP_DIR="sql-dumps/$TIMESTAMP"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

MYSQL_USER="root"
MYSQL_PASSWORD="password"

mkdir -p "$BACKUP_DIR/mysql"

databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema)"`

for db in $databases; do
  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db > "$BACKUP_DIR/mysql/$db.sql"
done
