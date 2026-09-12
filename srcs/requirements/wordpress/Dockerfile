FROM debian:bookworm


RUN apt update -y && apt install  php8.2-fpm curl php-mysql php mariadb-client -y 

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
   
RUN chmod +x wp-cli.phar
    
RUN mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html

COPY tools/script.sh .

RUN service php8.2-fpm start

RUN chmod 777 script.sh

CMD [ "./script.sh" ]