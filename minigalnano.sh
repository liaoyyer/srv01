#!/bin/bash

function _install() {
	git clone https://github.com/sebsauvage/MinigalNano /var/www/images
	cp -r config/MinigalNano/* /var/www/images
	chown -R www-data:www-data /var/www/images
	chown -R www-data:bsp /var/www/images/photos
	chown g+rws /var/www/images/photos
	ln -s /var/www/images/photos /home/bsp/photos
	echo "Done. You can now upload your pictures to the directory ~/photos/ directory through SFTP."
}

_install