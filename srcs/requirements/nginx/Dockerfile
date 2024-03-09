FROM debian:bullseye

RUN apt update -y && apt install nginx -y && apt install openssl -y

COPY ./conf/*.conf /etc/nginx/

RUN mkdir -p /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt -subj "/C=MA/ST=Khouribga/L=Khouribga/O=1337/CN=aarchtou.42.fr"

CMD ["nginx", "-g", "daemon off;"]