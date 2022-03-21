# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: fgata-va <fgata-va@student.42madrid>       +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/03/08 19:56:24 by fgata-va          #+#    #+#              #
#    Updated: 2022/03/08 20:30:05 by fgata-va         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.14

EXPOSE 9000

RUN apk add php7 php7-fpm php7-session php7-iconv php7-json php7-gd php7-curl\
 php7-xml php7-mysqli php7-imap php7-cgi fcgi php7-pdo php7-pdo_mysql php7-soap\
 php7-xmlrpc php7-posix php7-mcrypt php7-gettext php7-ldap php7-ctype php7-dom php7-simplexml

RUN mkdir -p /usr/share/webapps/ && mkdir -p /var/www 

ADD data/ /usr/share/webapps/
ADD conf/www.conf /etc/php7/php-fpm.d/
ADD conf/config_wp.sh /root

CMD ["/root/config_wp.sh"]
