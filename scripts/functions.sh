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

_MaintenanceAptCleanup() {
    aptitude clean
    aptitude purge -y ~c
}

_MaintenanceAptUpgrade() {
aptitude -q5 update
aptitude -q5 -y upgrade
}

_ToolsRunAptitude() {
aptitude
}

#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Maintenance routines                        ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01EditMotd() { #Edit maintenance message
    nano /etc/motd
}

_Srv01EditMainConfig() { #Edit and reload main srv01 config file
    #Note: See also https://packages.debian.org/sid/augeas-tools to edit config files
    $EDITOR ${NZ_CONF_PATH}/srv01.conf
    source "${NZ_CONF_PATH}/srv01.conf"
    echo "$NZ_FQDN" >| /etc/hostname
    hostname "$NZ_FQDN"
    _Srv01ReloadConfig #TODO: (check if paths/values in srv01.conf are valid) update config files accordingly
}

_Srv01ClearCaches() { #Clear dokuwiki and php-apc caches
	rm -r "$srv01_apache_documentroot/dokuwiki/data/cache/*"
	service apache2 restart #clear php-apc cache, so subtle
	#TODO: remove more caches (minigal, shaarli, owncloud deleted files...)
}



_AutoMaintenance() { #full auto maintenance tasks
	_MaintenanceAptUpgrade
	_MaintenanceAptCleanup
}




_Srv01RegenCertificates() { #Regenerate TLS certificates for apache and prosody
    #TODO: Move text inside the function move this to NzMenuTroubleshooting, call it from there
    echo "
    Generating SSL keys and certificates..."
    make-ssl-cert generate-default-snakeoil --force-overwrite
    #prosodyctl cert generate #This only works on 0.9+
    openssl req -new -x509 -days 365 -nodes -out "/var/lib/prosody/$NZ_FQDN.crt" -newkey rsa:2048 -keyout "/var/lib/prosody/$NZ_FQDN.key" -batch
}



_Srv01ReloadConfig() { #Main config reload routine
	_Srv01ConfigUpdateFqdn
	_Srv01RegenContactPage
	_Srv01RegenHomePage
	_Srv01FixPermissions
}

_Srv01ConfigUpdateFqdn() {
	echo "$NZ_FQDN" >| /etc/hostname
	hostname "$NZ_FQDN"
}



#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Power management                            ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01Reboot() { #Reboot
    read -p "Are you sure? This will reboot the machine [y/N]: " confirmation
    if [ "$confirmation" != "y" ]
        then echo "Reboot cancelled."
        else reboot
    fi
}

_Srv01Poweroff() { #Power off the machine
    read -p "Are you sure? This will turn the machine off (you will have to manually turn it on) [y/N]: " confirmation
    if [ "$confirmation" != "y" ]
        then echo "Power off cancelled."
        else poweroff
    fi
}

#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Network management                          ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01TestInetConnection() { #Test connectivity to debian.org #TODO move to NzMenuTroubleshooting
    ping -q -c3 debian.org
}

_Srv01UserGetName() { #Get system's main user name (assume it was the first user created)
	NZ_USER=$(getent passwd|grep 1000:1000|awk -F":" '{print $1}')
}

_Srv01GetLANSubnet() { #Get the current LAN IP and subnet
	ip addr show ${srv01_net_iface} | egrep "inet " | awk -F" " '{print $2}'
}


#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Services management                         ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01ServiceToggle() { #Start or stop a service, depending on it's status
	if [ "$nz_service_toggle_action" = "Disable service" ]
		then service $1 stop
		else service $1 start
	fi
}

#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Apache admin                                ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01ServiceApacheCheck() { #Checks for apache2 status and network access
	if [ ! -f /etc.init.d/apache2 ]
	#If apache is not installed	
	then
		nz_apache2_installed="no",
		nz_menu_apache2_line=" [1]	Apache web server	[not installed]"

	#If apache is installed
	else
		#Get service status
		service apache2 status >/dev/null
		case "$?" in
		0) nz_apache2_status="running"; nz_service_toggle_action="Disable service";;
		*) nz_apache2_status="stopped"; nz_service_toggle_action="Enable service";;
		esac

		#Check firewall status for service
		#TODO: move this to NzMenuFirewall as a function: _Srv01FirewallCheck 443
		#TODO: use LAN and VPN netmasks instead of hardcoding 192.168 (_Srv01GetLANSubnet)
		if [[ $(sudo ufw status numbered | grep "443/tcp                    ALLOW IN    Anywhere") ]]
			then nz_apache2_firewall="Internet access"
		elif [[ $(sudo ufw status numbered | grep "443/tcp                    ALLOW IN    192.168") ]]
			then nz_apache2_firewall="LAN access only"
		else
			nz_apache2_firewall="Blocked"
		fi

		#Build variables for menus
		nz_menu_apache2_line=" [1]	Apache web server	[$nz_apache2_status]	[$nz_apache2_firewall]"
		nz_apache2_installed="yes"
	fi
}



_Srv01InstallWebappPrompt() { #Prompt user for app name to install
	read -p "Install what app? " apptoinstall
	_Srv01InstallWebApp "$apptoinstall"
}

_Srv01InstallWebapp() { #Install a web application
	AppToInstall="$1"
	"$srv01_path/webapps/$AppToInstall.sh" install

	_Srv01RegenHomepage
	#_Srv01FixPermissions TODO re-enable when it's verified
}

_Srv01UpgradeWebapp() { #Upgrade a web application
	AppToUpgrade="$1"
	"$srv01_path/webapps/$AppToUpgrade.sh" upgrade
}

#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Prosody XMPP server admin                   ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01ProsodyGetStatus() { #Get IM server enabled/disabled status
if [[ -f /var/run/prosody/prosody.pid ]]
then PROSODY_STATUS="Enabled"
else PROSODY_STATUS="Disabled"
fi
}

_xmpp_enable() { #Enable/disable IM server
update-rc.d prosody enable; service prosody start
}

_xmpp_disable() { #Enable/disable IM server
	update-rc.d prosody disable; service prosody stop
}

_Srv01ProsodyGetRegistrationsStatus() { #Get new IM accounts registrations allowed/denied status
if [ `grep "allow_registration = true" /etc/prosody/prosody.cfg.lua` ]
then PROSODY_REG_ENABLED="Allowed"
else PROSODY_REG_ENABLED="Not allowed"
fi
}

_Srv01ProsodyAddUser() { #Create new IM account
echo "Please enter the desired username for the new account:"
read PROSODY_NEW_USERNAME
prosodyctl adduser "${PROSODY_NEW_USERNAME}@${NZ_FQDN}"
if [ $? = 0 ]
    then echo "Done. You can now login with an XMPP client. Username: ${PROSODY_NEW_USERNAME} , Domain: ${NZ_FQDN}. Press any key to continue."
read -n 1
fi
}

_Srv01ProsodyGetUserlist() { #Get list of IM accounts on the server
PROSODY_FQDN_STRING=`echo $NZ_FQDN | sed 's/\./\%2e/g'`
PROSODY_ACCOUNT_FILES=`find "/var/lib/prosody/${PROSODY_FQDN_STRING}/accounts" -name "*.dat"`
PROSODY_ACCOUNT_LIST=`for i in ${PROSODY_ACCOUNT_FILES}; do basename $i .dat; done`
}

_Srv01ProsodyDelUser() { #Delete an existing IM account
_Srv01ProsodyGetUserlist
echo "List of accounts on the server:
$PROSODY_ACCOUNT_LIST
Enter the name of the account you want to delete:"
read PROSODY_DELETE_ACCOUNT
prosodyctl deluser "${PROSODY_DELETE_ACCOUNT}@${FQDN}"
}

_Srv01ProsodyChangeUserPassword() { #Change password for an IM account
_Srv01ProsodyGetUserlist
echo "List of accounts on the server:
$PROSODY_ACCOUNT_LIST
Enter the name of the account you want to change the password for:"
read PROSODY_PASSWD_ACCOUNT
prosodyctl passwd "${PROSODY_PASSWD_ACCOUNT}@${FQDN}"
}

#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Firewall admin                              ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01AllowFromLAN() { #Allow a port to be accessed from the LAN. Usage: _Srv01AllowFromLAN 135,139,445 tcp
	source "${NZ_PATH}/scripts/NzConfigRoutines"
	ufw allow from $(_Srv01GetLANSubnet) to any port "$1" proto "$2"
}

_Srv01FirewallDeny() { #Deny access to a port. Usage: _Srv01FirewallDeny 80,443 tcp
	ufw deny log $1/$2
}

_Srv01FirewallAllow() { #Allow all access to a port. Usage: _Srv01FirewallAllow 80,443 tcp
	ufw allow $1/$2
}



#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   MySQL admin                                 ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

_Srv01DeleteDB() {
	QUERY="DROP DATABASE $1; DROP USER $1@localhost;"
	mysql -u root -p -e "$QUERY"
}

_CreateDB() {
	QUERY="create database $1; create user $1@localhost identified by \"$2\"; grant all on $1.* to $1@localhost;"
	mysql -u root -p -e "$QUERY"
}

_Srv01SecureMysql() {
	mysql_secure_installation
}

_Srv01MysqlRootPwReset() {
	echo -n "Please enter your new MySQL root password: "
	read NEWMYSQLPASSWORD
	echo -n "Please enter your new password again: "
	read NEWMYSQLCONFIRMATION
	if [ "$NEWMYSQLPASSWORD" != "$NEWMYSQLCONFIRMATION" ]
		then echo "Passwords do not match\!"; return 1
	fi

	QUERY="UPDATE user SET Password=PASSWORD(\'"$NEWMYSQLPASSWORD"\') WHERE User='root'; FLUSH PRIVILEGES;"
	service mysql stop
	mysqld_safe --skip-grant-tables&
	sleep 5
	mysql -u root mysql -e "$QUERY"
	echo "Password changed to: $NEWMYSQLPASSWORD"
}

#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░                                               ░░░
#░░░   Permissions management                      ░░░
#░░░                                               ░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
#░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░


_Srv01UserShowWwwaccess() { #Show main user's permissions on web served content
    groups $NZ_USER | grep -q "$APACHE_GROUP"
    if [ ?$ != 0 ]
        then echo "$NZ_USER is not allowed to edit the web server files"
        export NZ_USERWWWACCESS=0
        else  echo "$NZ_USER is allowed to edit the web server files"
        export NZ_USERWWWACCESS=1
    fi
}

_Srv01UserToggleWwwAccess() { #Show main user's permissions on web served content
    _Srv01UserShowWwwAccess >/dev/null
    if [ $NZ_USERWWWACCESS = 0 ]
        then adduser $NZ_USER www-data; _Srv01UserShowWwwAccess
        else deluser $NZ_USER www-data; _Srv01UserShowWwwAccess
    fi
}

_Srv01UserShowTransmissionAccess() { #Show main user's permissions on transmission downloaded files
    groups $NZ_USER | grep -q debian-transmission
    if [ ?$ != 0 ]
        then echo "$NZ_USER is not allowed to edit transmission downloaded files"
        export NZ_USERTRANSMISSIONACCESS=0
        else  echo "$NZ_USER is allowed to edit the transmission downloaded files"
        export NZ_USERTRANSMISSIONACCESS=1
    fi
}

_Srv01UserToggleTransmissionAccess() { #Toggle main user's permissions on transmission downloaded files
    _Srv01UserShowTransmissionAccess
    if [ $NZ_USERTRANSMISSIONACCESS = 0 ]
        then adduser $NZ_USER debian-transmission; _Srv01UserShowTransmissionAccess
        else deluser $NZ_USER debian-transmission; _Srv01UserShowTransmissionAccess
    fi
}

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


_CheckRoot() { #Check if we are root
if [[ "$(/usr/bin/whoami)" != "root" ]]; then
    echo "This script must be run as root\! Script aborted."
    return 1
fi
}

_GetTimestamp() {
    date +"%Y-%m-%d_%H%M%S"
}
