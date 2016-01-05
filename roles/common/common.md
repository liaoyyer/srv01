### OpenSSH & SFTP

SSH (_Secure SHell_) is a client/server program allowing remote control of a machine. It provides a secure encrypted communication channel. It also allows file sharing between machines (SFTP), displaying graphical programs from the remote machine on your local display (X forwarding), and establishing encrypted tunnels (use the remote machine as a proxy).

Unlike FTP, SFTP is a **secure** file transfer protocol. Transfers and authentication are encrypted over the network, menaning an attacker can not sniff your password or transferred data over the network. Secure mechanisms for FTP transfers also exist, but SFTP is remarkably easier to configure. http://mywiki.wooledge.org/FtpMustDie

 * [SSH Key authentication (en)](https://we.riseup.net/debian/ssh-key-authentication)

### Maintenance and reports

Installed security tools include: `lynis, bleachbit, rkhunter, chkrootkit, tiger, debsums, unattended-upgrades, logwatch, logcheck, unhide, ufw, debsecan, needrestart, unattended-upgrades, fail2ban`  
Other command-line tools include: `build-essential, git, htop, iftop, iotop, sudo, molly-guard, ncdu, ranger, tree, aptitude, goaccess, nethogs, rsnapshot, usbmount, dma, ntp, ntpdate, autojump, colortail`
