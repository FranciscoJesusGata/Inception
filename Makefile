# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgata-va <fgata-va@student.42madrid>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/07 11:27:54 by fgata-va          #+#    #+#              #
#    Updated: 2022/03/07 15:23:23 by fgata-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

USER := fgata-va

CERTS_DIR := requirements/nginx/certs/

all: srcs/.env srcs/$(CERTS_DIR)$(USER).crt
	docker-compose up

srcs/.env:
	echo "DOMAIN_NAME=$(USER).42.fr" > ./srcs/.env
	echo "CERTS_=$(CERTS_DIR)" >> ./srcs/.env
	echo "MYSQL_ROOT_PASSWORD=$$(srcs/requirements/tools/passwdgen.sh 24)" >> ./srcs/.env
	echo "MYSQL_USER=$(USER)" >> ./srcs/.env
	echo "MYSQL_PASSWORD=$$(srcs/requirements/tools/passwdgen.sh 24)" >> ./srcs/.env

srcs/$(CERTS_DIR)$(USER).crt:
	mkdir srcs/requirements/nginx/certs/\
	|| openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 \
	-nodes -subj "/C=ES/ST=Madrid/O=./CN=fgata-va.42.fr" \
	-out srcs/$(CERTS_DIR)$(USER).crt -keyout srcs/$(CERTS_DIR)$(USER).key

