#!bin/bash

mysqld_safe &

sleep 5

mariadb -u root <<EOF
CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
EOF
mariadb -u root <<EOF
CREATE USER '$mariadb_USER'@'%' IDENTIFIED BY '$mariadb_PASSWORD';
EOF
mariadb -u root <<EOF
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO $mariadb_USER@'%';
EOF
mariadb -u root <<EOF
FLUSH PRIVILEGES;
EOF

mariadb -u root <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY '$mariadb_ROOT_PASSWORD';
EOF

mariadb -u root -p${mariadb_ROOT_PASSWORD} <<EOF
shutdown
EOF

exec mysqld