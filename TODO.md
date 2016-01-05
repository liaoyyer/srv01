
## TODO

```
apache upgradeapps          #upgrade all web applications to their latest versions
<app> password/nopassword   #add/remove access restriction for web <app>lication TODO FOR ALL APPS, add to readme
srv01 xmpp start
srv01 xmpp disable
srv01 xmpp status (version/installed/running/enabled/firewall)
srv01 apache allowinet
srv01 apache allowlan
srv01 apache localonly
srv01 regencerts
srv01 apache forcehttps
srv01 tools (list cli utils)
srv01 services
srv01 firewall
srv01 report
srv01 scan
srv01 clean
srv01 config
☐ mumble: change superuser password: murmurd -i /etc/mumble-server.ini -supw "$NEWPASSWORD"; service mumble-server restart
☐ prosody: change user password
☐ prosody: delete user account
☐ srv01 allowinet/allowlanonly/deny/status for each service
☐ https://github.com/kern/filepizza
☐ test usbmount
☐ h5ai test
☐ mail: use external SMTP provider (package dma, dma.conf, smarthost)

☐ [bug] backups
     ☐ run/store tree command output before backup
     ☐ action: backup data files, dbs and manually specified dirs to local dir
     ☐ action: sync local backups to external drive (check avail space)
     ☐ rsnapshot config
         https://github.com/okfn/infra/blob/master/ansible/roles/rsnapshot/templates/rsnapshot.conf.j2
         https://github.com/okfn/infra/blob/master/ansible/roles/rsnapshot/files/rsnapshot.cron
         https://github.com/debops/ansible-rsnapshot https://github.com/osiell/ansible-rsnapshot-master nice/priority
         http://www.cyberciti.biz/faq/howto-install-rsnapshot-filesystem-snapshot-backup-utility-in-freebsd/

☐ [feature] tt-rss

☐ [feature] pastebin

☐ [feature] minidlna:
  ☐ flac support??
  ☐ config + test

☐ [security] apache/prosody: generate secure ssl certs
    https://www.ssllabs.com/ssltest/ returns grade B (disable RC4 ciphersuites)
    https://github.com/sovereign/sovereign/issues/373, https://weakdh.org/sysadmin.html
    https://github.com/sovereign/sovereign/issues/399
https://github.com/elnappo/ansible-role-prosody, https://github.com/lxmx/prosody-ansible

☐ [feature] pulseaudio (share audio outputs over local network)
    ☐ start services pulseaudio and avahi-daemon
    https://github.com/pimusicbox/pimusicbox/blob/develop/filechanges/etc/avahi/avahi-daemon.conf
    ☐ firewall port 4713: sudo ufw allow from 192.168.0.0/16 to any port 4713 proto tcp
    ☐ /etc/default/pulse
    ☐ /etc/pulse/system.pa
    ☐ paprefs on client
    ☐ adduser root et baseuser pulse-access
    ☐ adduser pulse audio
    ☐ doc: http://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/WhatIsWrongWithSystemWide/
  avahi-daemon (zero-configuration)!


☐ [feature] CUPS printer sharing


☐ [feature] samba file sharing (CIFS)
  ☐ config: https://github.com/debops/ansible-samba/blob/master/tasks/main.yml https://www.reddit.com/r/raspberry_pi/comments/3jnaqx/pikeeper_keep_your_data_fresh_a_pibased_nas/
  ☐ Add samba user: create corresponding unix user -s /dev/null -m -d /homedir user1; smbpasswd -a, smb.conf:; run testparm
        ## SAMBA SHARE
        #[$username-share]
        #path = /home/$username (?)
        #available = yes
        #valid users = $username
        #read only = no
        #browseable = yes
        #public = yes
        #writeable = yes
  ☐ List samba users
  ☐ Remove samba user
  ☐ Change samba passwords
  ☐ Change UNIX passwords
  ☐ install/uninstall/enable/disable
  ☐ [enh] disk quotas: http://xmodulo.com/samba-file-server-windows-clients.html

####### SAMBA CONFIG !
#samba_users:
#    - username: alice
#      readwrite_dirs:
#        - /media/STORAGE/Downloads
#        - /media/STORAGE/Torrents
#      readonly_dirs:
#        - /media/STORAGE/Programs
#    - username: bob
#      readwrite_dirs:
#        - /media/STORAGE/Music
#        - /media/STORAGE/Programs
#        - /media/STORAGE/Torrents
#      readonly_dirs:
#        - ""

   user creation: remove all ACLs for each user, apply new ACLS

☐ [feature]network scanner server
    https://wiki.archlinux.org/index.php/SANE
    http://xmodulo.com/2014/08/usb-network-printer-and-scanner-server-debian.html
    clients?
    http://xmodulo.com/2014/08/configure-network-printer-scanner-ubuntu-desktop.html





☐ [enh] SFTP user creation: propose to generate a key and authorize it

☐ [bug] [security] MONITORING/REPORTS
    https://github.com/lfit/itpol/blob/master/linux-workstation-security.md#root-mail
    http://askubuntu.com/questions/280944/what-automated-intrusion-notification-detection-setup-is-good-for-home-desktop-u
    https://web.archive.org/web/20130313105847/http://cilab.math.upatras.gr/mikeagn/content/how-setup-logwatch-ubuntu-based-systems  
    ☐ logcheck/logwatch (logcheck only?)
    ☐ tiger
    ☐ chkrootkit
    ☐ tripwire
    ☐ debsums
    ☐ lynis
    ☐ debsecan
    ☐ https://github.com/derhansen/logwatch-modsec2
    ☐ fail2ban blocks
        https://github.com/Glench/dotfiles/tree/master/conf/fail2ban
        http://www.it-connect.fr/filtres-et-actions-personnalises-dans-fail2ban/
        http://tuxicoman.jesuislibre.net/2015/01/fail2ban-pour-owncloud-7-sur-debian-jessie.html
        http://blog.bandinelli.net/index.php?post/2015/01/02/Entretenir-et-s%C3%A9curiser-ownCloud-avec-logrotate-et-fail2ban
        ☐ shaarli failed logins
        ☐ owncloud failed logins
        ☐ transmission failed logins
        ☐ tt-rss failed logins
    ☐ apache 403s
    ☐ SMART tests
    ☐ Send reports (rsync? xmpp? mail?) twice a week `LOGWATCH_OUT_FILE="${BACKUP_LOCAL_STORAGE}/UserToolkit/logwatch-report.txt"; logwatch -- service All --range All --archives --filename=${LOGWATCH_OUT_FILE}; echo "Logwatch report saved at $LOGWATCH_OUT_FILE."; /usr/sbin/logwatch --output mail --mailto test@gmail.com --detail high`

☐ [security] blocklist management      
    ☐ Add a switch to set fail2ban to ban mode
    clear warning about false positives and blocking legit visitors/admins
    ☐ Provide a way to manually blacklist/unblacklist IPs (using prerouting DROP)
    See also iptables hashlimit, connlimit, limit for more actions
    ☐ Add optional blacklist-based blocking
    https://github.com/trick77/ipset-blacklist may be useful
    clear warning about false positives and blocking legit visitors/admins

☐ [security] autorestart updated services
    checkrestart
    https://raw.githubusercontent.com/octopuce/octopuce-goodies/master/checkrestart/checkrestart.octopuce
    https://packages.debian.org/jessie/needrestart

☐ [security] apache prevent access by ISP hostname
    ☐ requests to the ISP hostname (domain names other than NZ_FQDN) should be catched returned 403 or DROPped at firewall level
    ☐ Use mod_security's DROP action instead of a 403 error for apache2's prevent-direct-ip-access.conf The 403 error still allows to get the server's certificate, which has a reference to the actual FQDN see http://serverfault.com/questions/401517/how-to-drop-all-requests-using-mod-security
    owncloud: mount transmission downloads dir

☐ [security] portsentry
    http://www.tldp.org/HOWTO/Security-Quickstart-HOWTO/firewalls.html
    http://www.linuxjournal.com/article/4751
    http://www.linuxfocus.org/English/September2001/article214.shtml
    https://wiki.netbsd.org/nsps/portsentry.conf
    http://www.linuxhomenetworking.com/forums/showthread.php/18760-How-to-setup-portsentry
    https://www.isalo.org/wiki.debian-fr/Portsentry
    http://www.computersecuritystudent.com/UNIX/UBUNTU/1204/lesson14/
    http://www.techrapid.co.uk/raspberry-pi/avoid-port-scanning-portsentry-raspberry-pi/
    http://bodhizazen.net/Tutorials/psad
    http://www.admin-magazine.com/Articles/Customizing-PortSentry

☐ [feature] rtcwake
    http://man.cx/rtcwake
    http://korben.info/faire-hiberner-et-reveiller-automatiquement-votre-ordinateur-linux-a-une-certaine-heure.html

☐ [feature] wake on lan
    https://wiki.debian.org/fr/WakeOnLan
    http://doc.ubuntu-fr.org/wakeonlan

☐ [feature] OpenVPN server or similar
    IPSEC: https://blog.ls20.com/ipsec-l2tp-vpn-auto-setup-for-ubuntu-12-04-on-amazon-ec2/
    https://github.com/Nyr/openvpn-install
    http://readwrite.com/2014/04/10/raspberry-pi-vpn-tutorial-server-secure-web-browsing
    https://we.riseup.net/debian/personal-vpn
    http://thegeekblog.aahank.com/notes/debian-ubuntu-vpn-server/
    http://networkfilter.blogspot.fr/2015/01/be-your-own-vpn-provider-with-openbsd.html
    https://github.com/StarshipEngineer/OpenVPN-Setup
    https://github.com/sovereign/sovereign/tree/master/roles/vpn
    ☐ test against http://ipleak.net/
    ☐ Firewall: restrict access to VPN ou mod_authz_host
    http://serverfault.com/questions/451788/how-to-access-a-port-via-openvpn-only

☐ [feature] tor relay
    http://www.devconsole.info/?p=848

☐ [feature] encrypted DNS proxy
    https://packages.debian.org/stretch/dnscrypt-proxy

☐ [feature] dns resolver
    bind, dnsmasq
    http://www.bortzmeyer.org/son-propre-resolveur-dns.html
    http://www.linuxhomenetworking.com/wiki/index.php/Quick_HOWTO_:_Ch18_:_Configuring_DNS

☐ [feature] htaccess/htpasswd manager (restrict access to each individual web app)

☐ [feature] Main RSS feed on the homepage
    ☐ Should aggregate feeds from links, images, owncloud shared files, blog, bugs....
    ☐ Feedek client side, JS, uses google Feed API
    ☐ Feed2js, server-side PHP + client JS



☐ [feature] tt-rss [dn]
    ☐ tt-rss/config.php
    ☐ create database
    ☐ replace password in tt-rss/config.php
    ☐ replace fqdn in config file
    ☐ replace FEED_CRYPT_KEY with a 24-char random string in config file
    ☐ automatically setup a new tt-rss user with predefined username/password
    ☐ Set a stroooong password for the admin user
    ☐ store it in the user password store
    See https://github.com/skottler/ttrss-ansible
    ☐ [feature] zerobin https://github.com/sebsauvage/ZeroBin

☐ [feature] owncloud
    ☐ Automated install
    ☐ default user creation
    ☐ setup apps
    ☐ config

☐ [feature] opensondage https://github.com/framasoft/OpenSondage

☐ [feature] wallabag
    https://www.wallabag.org/
    https://www.wallabag.org/pages/download-wallabag.html
    http://doc.wallabag.org/
    https://github.com/wallabag/wallabag


☐ [feature] private bittorrent tracker

☐ [feature] DHCP server
    dhcpd configured Disabled by default
    http://www.linuxhomenetworking.com/wiki/index.php Quick_HOWTO_:_Ch08_:_Configuring_the_DHCP_Server
    http://www.it-connect.fr/serveur-dhcp-sous-linux/

☐ [feature] maps:routing
    provide directions/routes from the map service.
    ☐ Graphhopper
    * Supports search with autocompletion, via points, extremely fast.
    * Quickstart just JRE and a.jar file, run through reverseproxy
    * Demo http://graphhopper.com/maps/
    * needs an OSM file
    * optional: use a local tileserver (rendering and autodownload of .osm needed)
    * Downside, it does not support placing arbitrary markers, shapes on the map (mapbbcodeshare does)

☐ [feature] search engine
    * https://github.com/asciimoo/searx
    * http://www.seeks-project.info/site/2011/12/03/what-freedom-in-websearch-truely-means, http://www.seeks-project.info/site/, http://doc.ubuntu-fr.org/seeks, http://www.seeks-project.info/wiki/index.php/List_of_Web_Seeks_nodes
    * https://github.com/asciimoo/searx/wiki/Installation



☐ [security] prosody: more security features (plugins)
    ☐ strict_https
    ☐ block_registrations
    ☐ log_auth
    ☐ check sec level with https://xmpp.net/index.php






☐ [bug] reports
     ☐ services status + firewall access
     ☐ installed services/roles
     ☐ list of samba users
     ☐ date of last local backup
     ☐ date of last remote/external backup
     ☐ current FS tree
     ☐ samba addresses smb://localip/$share-name on linux, \\$localip\$share-name
     ☐ output of w, who, uptime, date, last, lastb




☐ [security] Grsec/RBAC/SELinux/sandboxing?
 * https://forum.xojo.com/5439-webapp-deployment-with-selinux/0
 * http://stackoverflow.com/questions/15437603/running-an-untrusted-application-on-linux-in-a-sandbox
 * https://people.redhat.com/tscherf/articles/lm_en_selinux.pdf
 * https://www.linux.com/learn/tutorials/382226-run-applications-in-secure-sandboxes-with-selinux
 * https://www.google.fr/search?q=selinux+sanbodx+webapp
 * firejail? http://l3net.wordpress.com/2014/04/16/how-to-restrict-a-login-shell-using-linux-namespaces/


☐ [enh] [security] SFTP: chroot users to their home directory
    requires the home dir to be owned by root; https://en.wikibooks.org/wiki/OpenSSH/Cookbook/SFTP -> `ChrootDirectory %h`; http://www.cyberciti.biz/faq/debian-ubuntu-restricting-ssh-user-session-to-a-directory-chrooted-jail/
☐ [enh] improve less usability:
    environment:
    LESSOPEN: "| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
    LESS: ' -R '
    LESSPROMPT: "Line %lb/%L. Press Q to quit; Press / to search, Press H for help"
☐ [enh] create symlinks to webapps data dirs/transmission data dir in user home
☐ [enh] GUI on client for remote administration
☐ [enh] prosody: file transfer does not work in every direction
☐ [feature] etherpad
☐ [feature] ethercalc
☐ [enh] mumble Auto-setup accounts on client
☐ [maybe] markdown editor
☐ [maybe] add unit tests https://github.com/sovereign/sovereign/blob/master/tests.py
☐ [maybe] mail server (postfix, exim4-base, exim4-daemon-light, exim4-config, sendmail): dkim; spf; antispam; smtp; imap; web UI
☐ [maybe] LDAP + PostgreSQL backend, Samba4 as AD: FREEIPA http://www.freeipa.org/page/Main_Page; libpam-ldapd ldapscripts libpam-ldapd, https://wiki.debian.org/DebianLAN, https://packages.debian.org/jessie/debian-lan-config
☐ [maybe] hypervisor? Proxmox VE, Xenserver, ESXi
☐ [maybe] lvm/raid helpers: http://xmodulo.com/2014/09/create-software-raid1-array-mdadm-linux.html, http://xmodulo.com/2014/09/manage-lvm-volumes-centos-rhel-7-system-storage-manager.html
☐ [maybe] ACLs
☐ [enh] prevent forkbombs http://www.cyberciti.biz/tips/linux-limiting-user-process.html
☐ [enh] prosody offline support <http://prosody.im/doc/modules/modoffline(http://prosody.im/doc/modules/modoffline>
☐  [maybe] support nginx?
☐  [maybe] support postgresql?

---------------------------------------------

CLIENT

 * auto export bumpy booby bugs (json)
 * auto export TT-RSS OPML (populate public url in db, curl?)
 * auto-export shaarli public/private/all
 * auto-copy client ssh key
 * auto backup LUKS keys (password protected)
        ☐ owncloud backup calendriers/taches
          http://www.webdav.org/cadaver/
          https://github.com/untitaker/vdirsyncer
          https://git.barrera.io/hobarrera/todoman/tree/master
        ☐ owncloud backup users/passes
        ☐ owncloud backup contacts
 * backup prosody accounts
 * setup SFTP connection as gtk bookmark, mount sftp://${srv01_remote_username}@${srv01_hostname}:${srv01_ssh_port}, xdg-open
 * rsync server backups to client?
 * open webserver in browser
```
