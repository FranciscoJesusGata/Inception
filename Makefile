# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgata-va <fgata-va@student.42madrid>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/07 11:27:54 by fgata-va          #+#    #+#              #
#    Updated: 2022/03/08 19:26:20 by fgata-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

USER := fgata-va

CERTS_DIR := requirements/nginx/certs/

DATABASE:= wordpress

all:	srcs/.env srcs/$(CERTS_DIR)$(USER).crt /home/$(USER)/data
	@if [ ! dpkg -s docker -ce > /dev/null 2>&1 ] || [ ! -f /usr/local/bin/docker-compose ]; then \
		echo "Docker or docker-compose is not installed, to install both run:";\
		echo "sudo ./srcs/requirements/tools/InstallDocker.sh";\
	else\
		docker-compose -f srcs/docker-compose.yml up -d;\
	fi

/home/$(USER)/data:
	-bash -c "mkdir -p /home/$(USER)/data/{wp_volume,db_volume}"

srcs/.env:
	echo "DOMAIN_NAME=$(USER).42.fr" > ./srcs/.env
	echo "CERTS_=$(CERTS_DIR)" >> ./srcs/.env
	echo "MYSQL_ROOT_PASSWORD=$$(srcs/requirements/tools/passwdgen.sh 14)" >> ./srcs/.env
	echo "MYSQL_USER=$(USER)" >> ./srcs/.env
	echo "MYSQL_PASSWORD=$$(srcs/requirements/tools/passwdgen.sh 14)" >> ./srcs/.env
	echo "MYSQL_WP_PASSWORD=$$(srcs/requirements/tools/passwdgen.sh 14)" >> ./srcs/.env
	echo "MYSQL_DATABASE=$(DATABASE)" >> ./srcs/.env
	echo "WP_ADMIN_PASSWORD=$$(srcs/requirements/tools/passwdgen.sh 14)" >> ./srcs/.env

srcs/$(CERTS_DIR)$(USER).crt:
	mkdir srcs/requirements/nginx/certs/
	openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 \
	-nodes -subj "/C=ES/ST=Madrid/O=./CN=fgata-va.42.fr" \
	-out srcs/$(CERTS_DIR)$(USER).crt -keyout srcs/$(CERTS_DIR)$(USER).key
stop:
	docker-compose -f srcs/docker-compose.yml stop

clean:
	-docker-compose -f srcs/docker-compose.yml down

fclean:	clean
	-bash -c "docker rmi fgata-va/{mariadb,nginx,php-fpm}"
	-docker volume rm $$(docker volume ls -q)

re:	fclean all

prune:	fclean
	rm -f srcs/.env
	rm -rf srcs/$(CERTS_DIR)
