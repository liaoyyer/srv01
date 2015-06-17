#!/bin/bash

function _install() {
	git clone https://github.com/shaarli/Shaarli /var/www/links
	cp -r config/shaarli/* /var/www/links
	chown -R www-data:www-data /var/www/links
	echo "please open links/"
}

_install