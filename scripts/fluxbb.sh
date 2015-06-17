#!/bin/bash
source common.sh

function _install() {
	dbpassword=$(pwgen -s 18 1)
	git clone https://github.com/fluxbb/fluxbb /var/www/forum
	_CreateDB fluxbb "$dbpassword"
	chown -R www-data:www-data /var/www/forum
	echo "Please open forum/install.php"
}

_install