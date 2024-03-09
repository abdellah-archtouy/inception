#!bin/bash

# mysql_install_db
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

# mariadb -u root -p${mariadb_ROOT_PASSWORD} <<EOF
# shutdown
# EOF

mysqladmin -u root -p${mariadb_ROOT_PASSWORD} shutdown

exec mysqld

# mysqladmin shutdown -p${mariadb_ROOT_PASSWORD}
# wp config set SERVER_PORT 3306 --allow-root
# wp config set DB_NAME aarchtou42 --allow-root --path=.
# wp config set DB_USER bele --allow-root --path=.
# wp config set DB_PASSWORD 12 --allow-root --path=.
# wp config set DB_PASSWORD 1234 --allow-root --path=.
#wp config set DB_HOST 'mariadb:3306' --allow-root --path=.
