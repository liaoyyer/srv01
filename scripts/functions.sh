#!/bin/bash
# srv01-admin functions
# https://github.com/nodiscc/srv01
# ░░░░░█▀█
# ░░░░░█░█
# ░▀▀▀░▀▀▀

# Copyright (c) 2014-2015 nodiscc

# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Package management                          ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_maintenanceAptCleanup() {
    aptitude clean
    aptitude purge -y ~c
}

_maintenanceAptUpgrade() {
aptitude -q5 update
aptitude -q5 -y upgrade
}



#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Maintenance routines                        ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01ReloadConfig() { #Main config reload routine
	_Srv01ConfigUpdateFqdn
	_Srv01FixPermissions
}


#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Apache admin                                ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░



#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Permissions management                      ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01UserTransmissionPassword() {
    service transmission-daemon stop
    #Todo: Test required files availability
    CurrentTransmissionUsername=$(grep rpc-username /etc/transmission-daemon/settings.json |awk -F "\"" '{print $4}')
    CurrentTransmissionPassword=$(grep rpc-password /etc/transmission-daemon/settings.json |awk -F "\"" '{print $4}')
    read -p "Please enter the username required to access Transmission web interface (current: $CurrentTransmissionUsername): " NewTransmissionUsername
    read -p "Please enter the password required to access Transmission web interface (current: $CurrentTransmissionPassword): " NewTransmissionPassword
    sed -i "s/^    \"rpc-username\".*/    \"rpc-username\": \"$NewTransmissionUsername\",/g" /etc/transmission-daemon/settings.json
    sed -i "s/^    \"rpc-password\".*/    \"rpc-password\": \"$NewTransmissionPassword\",/g" /etc/transmission-daemon/settings.json
    echo "Transmission web interface username/password has been changed to $NewTransmissionUsername/$NewTransmissionPassword"
    service transmission-daemon start
}



_Srv01FixPermissions() { #Fix permissions for transmission/apache files
    chown debian-transmission:debian-transmission /var/log/debian-transmission.log
    chown -R debian-transmission:debian-transmission ${transmission_download_dir}
    chown daemon:daemon /var/log/debsecan
    chown -R "$NZ_USER":"$APACHE_GROUP" "$srv01_apache_documentroot"
    find "$srv01_apache_documentroot" -type d -print0 | xargs -0 chmod 750
    find "$srv01_apache_documentroot" -type f -print0 | xargs -0 chmod 640
    chmod -R g+w /var/www/links/{data,pagecache,cache,tmp}/ \
    	/var/www/bugs/{.htaccess,database} \
    	/var/www/tt-rss/{cache/export/,cache/images/,feed-icons/,lock/,cache/upload/,cache/js/}
    chmod 600 /etc/ssl/private/ssl-cert-snakeoil.key
}




#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Wrappers                                    ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_ArrayContainsElement() { #thanks https://stackoverflow.com/questions/3685970/
  local e
  for e in "${@:2}"; do [[ "$e" == "$1" ]] && return 0; done
  return 1
}

_Srv01ListFunctions() { #List all available Nodezero shell scripts
grep -roh "^_.*()" $srv01_path/scripts/
}


_checkRoot() { #Check if we are root
if [[ "$(/usr/bin/whoami)" != "root" ]]; then
    echo "This script must be run as root\! Script aborted."
    return 1
fi
}

_getTimestamp() {
    date +"%Y-%m-%d_%H%M%S"
}

listFunctions() { #List all available Nodezero shell scripts
	grep -roh "^_.*()" $0
}