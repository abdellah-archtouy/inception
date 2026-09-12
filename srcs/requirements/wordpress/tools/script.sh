#!/bin/bash

# Fail loudly if the .env is incomplete instead of installing with blank values.
: "${MYSQL_DATABASE:?MYSQL_DATABASE is not set}" \
  "${mariadb_USER:?mariadb_USER is not set}" \
  "${mariadb_PASSWORD:?mariadb_PASSWORD is not set}" \
  "${DOMAIN_NAME:?DOMAIN_NAME is not set}" \
  "${TITLE:?TITLE is not set}" \
  "${MYSQL_ROOT_USER:?MYSQL_ROOT_USER is not set}" \
  "${MYSQL_ROOT_PASSWORD:?MYSQL_ROOT_PASSWORD is not set}" \
  "${MYSQL_USER:?MYSQL_USER is not set}" \
  "${MYSQL_PASSWORD:?MYSQL_PASSWORD is not set}"

WP="wp --allow-root --path=/var/www/html"
cd /var/www/html

# Wait until the database really answers a query. A plain ping can succeed
# against a server that is still shutting down, which breaks the checks below.
for i in $(seq 1 60); do
    mariadb -h mariadb -u "$mariadb_USER" -p"$mariadb_PASSWORD" \
        -e 'SELECT 1' "$MYSQL_DATABASE" >/dev/null 2>&1 && break
    sleep 2
done

if [ ! -f /var/www/html/wp-includes/version.php ]; then
    $WP core download
fi

if [ ! -f /var/www/html/wp-config.php ]; then
    $WP config create \
        --dbname="$MYSQL_DATABASE" \
        --dbuser="$mariadb_USER" \
        --dbpass="$mariadb_PASSWORD" \
        --dbhost=mariadb
fi

if ! $WP core is-installed 2>/dev/null; then
    $WP core install \
        --url="https://$DOMAIN_NAME" \
        --title="$TITLE" \
        --admin_user="$MYSQL_ROOT_USER" \
        --admin_password="$MYSQL_ROOT_PASSWORD" \
        --admin_email=aarchtou@student.1337.ma \
        --skip-email
fi

if ! $WP user get "$MYSQL_USER" >/dev/null 2>&1; then
    $WP user create "$MYSQL_USER" randomMail@gmail.com \
        --role=author --user_pass="$MYSQL_PASSWORD"
fi

# The image installs PHP 8.2 (not 7.4): make php-fpm listen on TCP 9000 for nginx.
mkdir -p /run/php
sed -i 's#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/8.2/fpm/pool.d/www.conf

exec /usr/sbin/php-fpm8.2 -F
