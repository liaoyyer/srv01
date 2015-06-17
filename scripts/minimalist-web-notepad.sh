#!/bin/bash
git clone https://github.com/pereorga/minimalist-web-notepad /var/www/notepad
chown -R www-data:www-data /var/www/notepad
hostname=($hostname)
domainname=$(domainname)
sed -i 's/^\$URL.*/\$URL = "https://$hostname.$domainname/notepad";/g' /var/www/notepad/index.php