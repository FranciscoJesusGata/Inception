# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgata-va <fgata-va@student.42madrid>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/03 21:19:25 by fgata-va          #+#    #+#              #
#    Updated: 2022/03/04 17:32:17 by fgata-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.15

EXPOSE 443

RUN apk update && apk add nginx && mkdir /var/www/html\
&& chmod 755 /var/www/html && apk add openssl

ADD nginx.conf /etc/nginx/
ADD index.html /var/www/html/
ADD fgata-va.jpg /var/www/html/
ADD fgata-va.css /var/www/html/

RUN openssl req -new -newkey rsa:4096 -x509 -sha256 -days 365 \
-nodes -subj "/C=ES/ST=Madrid/O=./CN=fgata-va.42.fr" \
-out /etc/ssl/fgata-va.crt -keyout /etc/ssl/fgata-va.key

CMD ["nginx", "-g", "daemon off;"]
