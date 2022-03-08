#!/bin/sh
if [ ! -d /var/lib/mysql/mysql ]; then
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
	cat << EOF > tmp.sql
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION ;
FLUSH PRIVILEGES ;
CREATE DATABASE IF NOT EXISTS wordpress CHARACTER SET utf8 COLLATE utf8_general_ci ;
GRANT ALL ON wordpress.* TO '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_PASSWORD' ;
FLUSH PRIVILEGES ;
EOF
	/usr/bin/mysqld --user=mysql < tmp.sql
	rm -f tmp.sql
fi

exec /usr/bin/mysqld --user=mysql
