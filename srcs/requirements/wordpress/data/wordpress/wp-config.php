<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'wordpress' );
define( 'DB_PASSWORD', '6#1_24&03FL$f+' );
define( 'DB_HOST', 'mariadb' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define('AUTH_KEY',         '51+wPmv}CdHtkW`5xXsnC+w/Cbkw+|MI.,EUf+6E!R%;ht9C^7K_L?sC;`f,*w3u');
define('SECURE_AUTH_KEY',  'vVpOq1?HE*mw60G Jf97Z8!1-uY/(9ZBR}H(R4_t}NHP*YW<a^RFr70}aw7kYG-_');
define('LOGGED_IN_KEY',    'jblc-7)Z|4O?QAP44}]?|T&ZAW4@19s+T8-(-5!luYac!c(^vW4#,+WM&VE&`F~+');
define('NONCE_KEY',        '?</T%Ut7cRy:snD(]E~%JTlpw//zxpG-A+bSL-[J %]D!o)YyqPXyDhk<e_7>qJ[');
define('AUTH_SALT',        '+m++N%K3]<>^eu9=}J[,F`J(>$ZpX=-zL&31tb7#?iD_UUts4k H%O}Q/3P=~Jm3');
define('SECURE_AUTH_SALT', ',zwN|$EDx1YbVj$)Z>I|C&+%L#I|(u(ihOn5aeC-jU U!b=dfQeqxG;]EXG7/^M9');
define('LOGGED_IN_SALT',   'uoRw5^7,x$DVI|qkba3J!C*Bc8{#jC{l+}k}LK84J69_VisHchTtRPNGuq<G$]<2');
define('NONCE_SALT',       '7.NED@VNwQc0X|*.(xu-e,35^rT=gh~MmhjwMRdj88d-tX5B`8vcZ_lIJC6JT5<!');
$table_prefix = 'wp_';
define( 'WP_DEBUG', false );
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}
require_once ABSPATH . 'wp-settings.php';
