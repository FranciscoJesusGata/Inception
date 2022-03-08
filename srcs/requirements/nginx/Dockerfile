# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgata-va <fgata-va@student.42madrid>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/03 21:19:25 by fgata-va          #+#    #+#              #
#    Updated: 2022/03/08 17:08:38 by fgata-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.14

EXPOSE 443

RUN apk update && apk add nginx && mkdir /var/www/html\
&& chmod 755 /var/www/html

ADD conf/default.conf /etc/nginx/http.d/
ADD index.html /var/www/html/
ADD fgata-va.jpg /var/www/html/
ADD fgata-va.css /var/www/html/

CMD ["nginx", "-g", "daemon off;"]
