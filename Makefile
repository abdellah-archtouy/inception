DOCKER_COMPOSE = srcs/docker-compose.yml
DATA_PATH = $(shell grep '^DATA_PATH=' srcs/.env | cut -d= -f2-)

up:
	mkdir -p $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	docker-compose -f ${DOCKER_COMPOSE} up -d

down:
	docker-compose -f ${DOCKER_COMPOSE} down --volumes
re : down  rmi up
# clean:
# 	sudo rm -rf $(DATA_PATH)/wordpress/*
# 	sudo rm -rf $(DATA_PATH)/mariadb/*
rmi :
	-docker rmi mariadb:aarchtou wordpress:aarchtou nginx:aarchtou
rm :
	docker rm mariadb wordpress nginx
