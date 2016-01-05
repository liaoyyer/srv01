    ░░░░░█▀█ ┏━┓┏━┓╻ ╻┏━┓╺┓ 
    ░░░░░█░█ ┗━┓┣┳┛┃┏┛┃┃┃ ┃ 
    ░▀▀▀░▀▀▀ ┗━┛╹┗╸┗┛ ┗━┛╺┻╸


Automated, unattended installation/setup/maintenance tool for personal servers

## Features

 * Automated system [configuration, maintenance and reporting](roles/common/common.md)
 * Web server ([Apache + Apaxy](roles/apache2/apache.md)
  * Links/bookmarks sharing tool ([Shaarli](roles/webapp-shaarli/shaarli.md))
  * Image gallery ([MinigalNano](roles/webapp-minigalnano/minigalnano.md))
  * File synchronization and sharing, calendars, address books ([Owncloud](roles/webapp-owncloud/owncloud.md))
 * Jabber/XMPP communication server ([Prosody](roles/prosody/prosody.md))
  * Web chat client ([Converse.js](roles/webapp-conversejs/conversejs.md))
 * Git ([repository server](roles/git/git.md)
  * Web repository browser [Gitlist](roles/webapp-gitlist/gitlist.md)
 * Bittorrent client ([Transmission](roles/transmission/transmission.md))
 * Voice communication server ([Mumble](roles/mumble/mumble.md))

## Requirements

```
    Computer with x86-compatible CPU
    512MB RAM
    10+GB system storage drive
    80GB-4+TB data storage drive
    80GB-4+TB external (USB) backup drive
    1GB+ USB drive, Internet connection
    Optional: remote control computer running Linux
    Optional: register a domain name (https://freedns.afraid.org/domain/registry/)
```

## Installation

 * Download [Debian](https://www.debian.org/CD/netinst/)
 * Burn or write the iso file to USB using `dd` or [win32diskimager](http://sourceforge.net/projects/win32diskimager/)
 * Boot your server from USB/DVD; select `Advanced > Graphical advanced install`
 * Allow root (administrator) logins
 * Do not create and extra user
 * Only install `Standard system utilities` and `SSH server` tasks.
 * Finish installation, reboot, login as `root`, and run:

```
    aptitude install ansible git sudo pwgen python-mysqldb
    git clone https://github.com/nodiscc/srv01
    cd srv01
    nano config.yml #change required configuration values
    ./srv01 setup #setup the base system
```

## Setup remote administration from another computer

 * Run `git clone https://github.com/nodiscc/srv01; cd srv01` on your computer.
 * set the `srv01_user` variable in `config.yml` to match your username on the server, and replace the `localhost...` line in `hosts` with the domain name (or IP address) of your server.
 * run `./srv01 client `. This will authorize the machine to connect to the server using SSH keys, and will disable password-based authentication.

## Usage

    USAGE: ./srv01 'command'

    setup                       #run initial setup
    client                      #setup local computer for remote control of the server

    # WEB SERVER
    install apache              #(re)install web server
    apache updatehome           #update home page/(re)setup directory listings
    apache setpassword          #update webserver directories password
    apache allowinet            #allow web server access from Internet
    apache allowlanonly     #allow web server access only from LAN


    # WEB APPLICATIONS
    install owncloud            #(re)install owncloud file sharing and synchronization tool
        upgrade owncloud        #upgrade owncloud to latest version
    install minigalnano         #(re)install minigalnano image gallery
    install shaarli             #(re)install shaarli links/bookmarks sharing tool


    # XMPP SERVER
    install prosody             #(re)install xmpp/jabber communication server
    install conversejs          #(re)install the web chat client
    prosody adduser <username> #create new XMPP instant messaging account
    prosody listusers           #list xmpp accounts registered on server

    # MUMBLE SERVER
    install mumble              #(re)install voice communication server

    # BITTORRENT CLIENT
    install transmission        #(re)install bittorrent client
    transmission allowinet      #allow bittorrent peer connections from Internet

    # GIT SERVER
    install gitlist             #install the git repository web interface/browser

    # UTILITIES
    services                    #display services status
    firewall                    #display firewall status
    maintenance                 #run auto maintenance
    report                      #generate full system report
    permissions                 #fix file permissions
    ssl                         #regenerate ssl certificates
    security                    #re-setup security
    reboot                      #reboot the machine
    poweroff                    #power off the machine


Run `ansible-playbook site.yml --list-tags` for a complete list of commands (_tags_). All commands can be run locally on the server, or from the computer you set up as a client.



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
