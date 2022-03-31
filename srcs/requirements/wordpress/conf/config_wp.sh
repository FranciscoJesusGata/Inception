#!/bin/sh

if [ ! -d /usr/share/webapps/wordpress ]; then
	mkdir -p /usr/share/webapps/
	cd /usr/share/webapps/
	wget http://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz && rm latest.tar.gz
	chmod 755 wordpress
fi

# Is wordpress already installed?
if [ ! -d /var/www/wordpress ]; then
	ln -s /usr/share/webapps/wordpress/ /var/www/
	file=/usr/share/webapps/wordpress/wp-config.php
	echo "<?php" > $file
	echo "define( 'DB_NAME', '$MYSQL_DATABASE' );" >> $file
	echo "define( 'DB_USER', '$MYSQL_USER' );" >> $file
	echo "define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );" >> $file
	echo "define( 'DB_HOST', 'mariadb' );" >> $file
	echo "define( 'DB_CHARSET', 'utf8' );" >> $file
	echo "define( 'DB_COLLATE', '' );" >> $file
	wget -qO- https://api.wordpress.org/secret-key/1.1/salt/ >> $file
	echo "\$table_prefix = 'wp_';" >> $file
	echo "define( 'WP_DEBUG', false );" >> $file
	echo "define( 'FORCE_SSL_ADMIN', false );" >> $file
	echo "if ( ! defined( 'ABSPATH' ) ) {" >> $file
	echo "	define( 'ABSPATH', __DIR__ . '/' );" >> $file
	echo "}" >> $file
	echo "require_once ABSPATH . 'wp-settings.php';" >> $file
	echo "?>" >> $file
fi

until nc -z -v -w30 mariadb 3306
do
	echo "Waiting for database connection..."
  sleep 5
done

# Is the database already created?
db_installed=`mysqlshow -u $MYSQL_USER --password=$MYSQL_PASSWORD -h mariadb wordpress | grep -o wp_users`
if [ "$db_installed" == "" ]; then
	mysql -u $MYSQL_USER --password="$MYSQL_PASSWORD" -h mariadb wordpress < /root/data.sql
	wp user create fgata-va saoko@papi.es --role=administrator --allow-root --path=/usr/share/webapps/wordpress/ > login && chmod 400 login
	wp user create motomami moto@mami.es --role=subscriber --allow-root --path=/usr/share/webapps/wordpress/ > login2 && chmod 400 login2
fi

exec php-fpm7 -F
