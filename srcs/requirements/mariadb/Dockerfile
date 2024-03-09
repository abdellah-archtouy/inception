FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server 

RUN mkdir -p /var/run/mysqld && chown -R mysql /var/run/mysqld && chmod -R 777 /var/run/mysqld

RUN service  mariadb start

RUN sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/script.sh .

RUN chmod 777 script.sh

CMD ["./script.sh"]