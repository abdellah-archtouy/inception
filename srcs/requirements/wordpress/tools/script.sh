#!/bin/bash

sleep  20

cd /var/www/html
wp core download  --allow-root --path=/var/www/html
mv wp-config-sample.php wp-config.php


wp config set SERVER_PORT 3306 --allow-root
wp config set DB_NAME $MYSQL_DATABASE --allow-root  --path=/var/www/html
wp config set DB_USER $mariadb_USER --allow-root --path=/var/www/html
wp config set DB_PASSWORD $mariadb_PASSWORD --allow-root --path=/var/www/html
wp config set DB_HOST 'mariadb' --allow-root --path=/var/www/html

wp core install --url=https://$DOMAIN_NAME --title=$TITLE --admin_user=$MYSQL_ROOT_USER --admin_password=$MYSQL_ROOT_PASSWORD --admin_email=aarchtou@student.1337.ma --allow-root --path=/var/www/html


wp user create $MYSQL_USER randomMail@gmail.com --role=author --user_pass=$MYSQL_PASSWORD  --allow-root --path=/var/www/html

# The image installs PHP 8.2 (not 7.4): make php-fpm listen on TCP 9000 for nginx.
mkdir -p /run/php
sed -i 's#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:9000#' /etc/php/8.2/fpm/pool.d/www.conf


exec /usr/sbin/php-fpm8.2 -F
