    ░░░░░█▀█ ┏━┓┏━┓╻ ╻┏━┓╺┓ 
    ░░░░░█░█ ┗━┓┣┳┛┃┏┛┃┃┃ ┃ 
    ░▀▀▀░▀▀▀ ┗━┛╹┗╸┗┛ ┗━┛╺┻╸


Automated, unattended installation/setup/maintenance tool for personal servers

## Features

 * Automated system configuration
 * Web server ([Apache](https://httpd.apache.org/) + [Apaxy](http://adamwhitcroft.com/apaxy/) )
  * Links/bookmarks sharing tool ([Shaarli](https://github.com/shaarli/shaarli))
  * Image gallery ([MinigalNano](https://github.com/sebsauvage/MinigalNano))
  * File synchronization and sharing, calendars, address books ([Owncloud](https://owncloud.org))
 * Jabber/XMPP communication server ([Prosody](https://prosody.im/))
  * Web chat client ([Converse.js](https://conversejs.org/))
 * Bittorrent client ([Transmission](http://www.transmissionbt.com/))
 * Voice communication server ([Mumble](http://wiki.mumble.info/wiki/Main_Page))
 * Automated maintenance and reports (`unattended-upgrades, debsecan, logwatch, tiger, chkrootkit, rkhunter, lynis, debsums, needrestart, fail2ban, iftop, htop, iotop, ncdu, goaccess, nethogs, mod-security2, mod-evasive, ufw, goaccess, nethogs, tree, ranger, autojump, ncdu, iotop, iftop, rsnapshot ...`)

## Installation

 * Hardware requirements: x86-compatible CPU, 512MB RAM, 10+GB system storage, Data storage drive, External backup drive, 1GB+ USB drive
 * Download [Debian](https://www.debian.org/CD/netinst/) netinstall
 * Burn or write the iso to USB using `dd` or [win32diskimager](http://sourceforge.net/projects/win32diskimager/)
 * Boot your server from USB/DVD
  * Select `Graphical advanced install` and setup Debian
   * Allow root (administrator) logins.
   * Only install `Standard system utilities` and `SSH server` tasks.
 * Finish install, reboot, login as root
  * Run `aptitude install ansible git sudo pwgen python-mysqldb; git clone https://github.com/nodiscc/srv01; cd srv01`
  * Change required configuration values (`nano config.yml`, use `pwgen -s 20` to generate random passwords)
  * Run `./srv01 setup` to setup initial system.
 * Run any command below

## Usage

    ./srv01 setup                       #run initial setup

    # WEB SERVER
    ./srv01 install apache              #(re)install web server
    ./srv01 install apaxy               #update home page/(re)setup directory listings

    # WEB APPLICATIONS
    ./srv01 install owncloud            #(re)install owncloud file sharing and synchronization tool
    ./srv01 install minigalnano         #(re)install minigalnano image gallery
    ./srv01 install shaarli             #(re)install shaarli links/bookmarks sharing tool
    ./srv01 <app> password/nopassword  #add/remove access restriction for web <app>lication
    ./srv01 apache updatepassword       #update webserver directories password

    # XMPP SERVER
    ./srv01 install prosody             #(re)install xmpp/jabber communication server
    ./srv01 install conversejs          #(re)install the web chat client
    ./srv01 prosody adduser <username> #create new XMPP instant messaging account
    ./srv01 prosody listusers           #list xmpp accounts registered on server

    # MUMBLE SERVER
    ./srv01 install mumble              #(re)install voice communication server

    # BITTORRENT CLIENT
    ./srv01 install transmission        #(re)install bittorrent client
    ./srv01 allowinet transmission      #allow bittorrent peer connections from Internet

    # FIREWALL
    ./srv01 allowinet <service>        #allow <service> access from Internet
    ./srv01 allowlanonly <service>     #allow <service> access only from LAN
    ./srv01 deny <service>             #deny webserver network access

    # UTILITIES
    ./srv01 services                    #display services status
    ./srv01 maintenance                 #run auto maintenance
    ./srv01 permissions                 #fix file permissions
    ./srv01 ssl                         #re-setup ssl permissions
    ./srv01 security                    #re-setup security





Run `ansible-playbook site.yml --list-tags` for a complete list of commands (_tags_) 

----------------------------

## Server build

 * Get an [UPS](https://en.wikipedia.org/wiki/Uninterruptible_power_supply) to protect your server from power loss. Some BIOS configuration tools allow turning the power back on after a power loss.
 * Prefer using newer hardware as it will decrease your server's power consumption.
  * [PicoPSU](http://www.silentpcreview.com/article601-page1.html) power supply units.
 * Prefer using wired network connections. A wireless connection is possible if the signal quality is good enough, but will decrease available bandwidth. Always use WPA2. Use strong passphrases.

----------------------------

## License 

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.html).

    Copyright (c) 2014-2015 nodiscc <nodiscc@gmail.com>

Special thanks: [Sovereign](https://github.com/sovereign/sovereign), [Ansible](http://www.ansible.com/), [Debian](https://www.debian.org/), [awesome-selfhosted](https://github.com/Kickball/awesome-selfhosted).