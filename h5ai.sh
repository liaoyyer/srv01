#!/bin/bash
function _install() {
	wget https://github.com/lrsjng/h5ai/releases/download/v0.27.0/h5ai-0.27.0.zip
	aunpack h5ai-0.27.0.zip
	mv _h5ai /var/www
	chown -R www-data:www-data /var/www/_h5ai
	chmod g+rwx /var/www/_h5ai/cache
	mkdir /var/www/docs/
	echo "DirectoryIndex  index.html  index.php  /_h5ai/server/php/index.php" >| /var/www/docs/.htaccess
	chown -R www-data:bsp /var/www/docs
	chown g+rws /var/www/docs
	cp config/h5ai/conf/options.json /var/www/_h5ai/conf/options.json
}

_install