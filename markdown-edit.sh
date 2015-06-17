#!/bin/bash
function _install() {
	aptitude install npm
	npm install -g bower
	git clone https://github.com/georgeOsdDev/markdown-edit /var/www/markdown-edit
	cd /var/www/markdown-edit
	ln -s /usr/bin/nodejs /usr/bin/node
	sudo -u www-data bower install
	chown -R www-data:www-data /var/www/markdown-edit
}

_install