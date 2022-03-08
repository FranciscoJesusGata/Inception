# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgata-va <fgata-va@student.42madrid.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/08 15:05:18 by fgata-va          #+#    #+#              #
#    Updated: 2022/03/08 16:33:24 by fgata-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.14

EXPOSE 3306

RUN apk update && apk add mariadb mariadb-common mariadb-openrc openrc\
&& mkdir /run/openrc && touch /run/openrc/softlevel

RUN /etc/init.d/mariadb setup

CMD /usr/bin/mysqld_safe --datadir="/var/lib/mysql"
