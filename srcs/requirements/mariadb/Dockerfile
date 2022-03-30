# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgata-va <fgata-va@student.42madrid.com>   +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/08 15:05:18 by fgata-va          #+#    #+#              #
#    Updated: 2022/03/08 18:08:13 by fgata-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.14

EXPOSE 3306

RUN apk add --no-cache mariadb mariadb-common mariadb-openrc mariadb-client openrc\
&& mkdir /run/openrc && touch /run/openrc/softlevel

COPY conf/setup.sh /setup.sh
RUN chmod 755 /setup.sh

CMD ["/setup.sh"]
