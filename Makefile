DOCKER_COMPOSE = srcs/docker-compose.yml

up:
	docker-compose -f ${DOCKER_COMPOSE} up -d

down:
	docker-compose -f ${DOCKER_COMPOSE} down --volume
clean:
	sudo rm -rf /home/aarchtou/data/wordpress
	sudo rm -rf /home/aarchtou/data/mariadb
rmi :
	docker rmi mariadb:aarchtou wordpress:aarchtou nginx:aarchtou
rm :
	docker rm mariadb wordpress nginx