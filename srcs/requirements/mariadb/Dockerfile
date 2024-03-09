FROM debian:bullseye


# ENV MYSQL_ROOT_PASSWORD=1234
# ENV mariadb_ROOT_PASSWORD=1234

# ENV MYSQL_ROOT_USER = bele
# ENV DOMAIN_NAME = aarchtou42.fr
# ENV MYSQL_DATABASE=aarchtou42
# ENV MYSQL_USER=user
# ENV mariadb_USER=user1
# ENV mariadb_PASSWORD=user12
# ENV MYSQL_PASSWORD=user12

RUN apt-get update && \
    apt-get install -y mariadb-server 
    


RUN mkdir -p /var/run/mysqld && chown -R mysql /var/run/mysqld && chmod -R 777 /var/run/mysqld

RUN service  mariadb start

RUN sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE 3306

COPY tools/script.sh .

RUN chmod 777 script.sh

CMD ["./script.sh"]