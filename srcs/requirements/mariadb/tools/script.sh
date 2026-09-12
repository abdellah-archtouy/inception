#!/bin/bash

# Fail loudly if the .env is incomplete instead of running "CREATE USER ''@'%'".
: "${MYSQL_DATABASE:?MYSQL_DATABASE is not set}" \
  "${mariadb_USER:?mariadb_USER is not set}" \
  "${mariadb_PASSWORD:?mariadb_PASSWORD is not set}" \
  "${mariadb_ROOT_PASSWORD:?mariadb_ROOT_PASSWORD is not set}"

mysqld_safe &

# Wait until the server accepts connections (a fixed sleep is too short on slow hosts).
for i in $(seq 1 30); do
    mysqladmin ping --silent 2>/dev/null && break
    sleep 1
done

# Fresh data dir: root logs in through the unix socket without a password.
# Existing data dir: root already has the password set below.
if mariadb -u root -e 'SELECT 1' >/dev/null 2>&1; then
    ROOT_OPTS=(-u root)
else
    ROOT_OPTS=(-u root -p"$mariadb_ROOT_PASSWORD")
fi

mariadb "${ROOT_OPTS[@]}" <<SQL
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS '$mariadb_USER'@'%' IDENTIFIED BY '$mariadb_PASSWORD';
ALTER USER '$mariadb_USER'@'%' IDENTIFIED BY '$mariadb_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO '$mariadb_USER'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$mariadb_ROOT_PASSWORD';
FLUSH PRIVILEGES;
SQL

mysqladmin -u root -p"$mariadb_ROOT_PASSWORD" shutdown

exec mysqld --user=mysql
