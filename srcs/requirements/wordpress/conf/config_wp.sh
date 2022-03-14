#!/bin/sh
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
echo "if ( ! defined( 'ABSPATH' ) ) {" >> $file
echo "	define( 'ABSPATH', __DIR__ . '/' );" >> $file
echo "}" >> $file
echo "require_once ABSPATH . 'wp-settings.php';" >> $file
exec php-fpm7 -F
