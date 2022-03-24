#!/bin/sh

if [ ! -d /usr/share/webapps/wordpress ]; then
	mkdir -p /usr/share/webapps/
	cd /usr/share/webapps/
	wget http://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz && rm latest.tar.gz
	chmod 755 wordpress
fi

mysql -u wordpress --password="$MYSQL_WP_PASSWORD" wordpress < /root/data.sql
mysql -u wordpress --password="$MYSQL_WP_PASSWORD" wordpress << EOF
LOCK TABLES `wp_users` WRITE;
/*!40000 ALTER TABLE `wp_users` DISABLE KEYS */;
INSERT INTO `wp_users` VALUES (1,'fgata-va',MD5('$WP_ADMIN_PASSWORD'),'fgata-va','saoko@papi.es','https://fgata-va.42.fr','2022-03-21 13:53:05','',0,'fgata-va');
/*!40000 ALTER TABLE `wp_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

EOF

ln -s /usr/share/webapps/wordpress/ /var/www/
file=/usr/share/webapps/wordpress/wp-config.php
echo "<?php" > $file
echo "define( 'DB_NAME', '$MYSQL_DATABASE' );" >> $file
echo "define( 'DB_USER', 'wordpress' );" >> $file
echo "define( 'DB_PASSWORD', '$MYSQL_WP_PASSWORD' );" >> $file
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
exec php-fpm7 -F
