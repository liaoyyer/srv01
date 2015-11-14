    ░░░░░█▀█ ┏━┓┏━┓╻ ╻┏━┓╺┓ 
    ░░░░░█░█ ┗━┓┣┳┛┃┏┛┃┃┃ ┃ 
    ░▀▀▀░▀▀▀ ┗━┛╹┗╸┗┛ ┗━┛╺┻╸


## Usage

<!--
### SSH

    srv01 ssh regenkey


    srv01 firewall allowinet
    srv01 firewall allowlanonly
    srv01 firewall deny

### Apache

    srv01 apache install
    srv01 apache regenkey
    srv01 webapp shaarli install
    srv01 webapp h5ai install

### Mumble

    srv01 mumble install
    srv01 mumble changepassword
    srv01 mumble config

### Other

    srv01 transmission install
    srv01 prosody install
    srv01 pulseaudio install
    srv01 minidlna install

    srv01 maintenance securitychecks
    srv01 maintenance update
    srv01 maintenance cleanup

    srv01 tools
-->


### Tools

    srv01 maintenance
    srv01 reboot
    srv01 poweroff
 
## Hardware requirements

    1 GHz x86-compatible CPU
    512MB RAM
    10GB main storage
    External backup drive


Tested on `None`


----------------------------


## Server build tips

 * Get an [UPS](https://en.wikipedia.org/wiki/Uninterruptible_power_supply) to protect your server from power loss. Some BIOS configuration tools allow turning the power back on after a power loss.
 * Prefer using newer hardware as it likely decreases your server's power consumption.
  * [PicoPSU](http://www.silentpcreview.com/article601-page1.html) power supply units.
 * Prefer using wired network connections. A wireless connection is possible if the signal quality is good enough, but will decrease available bandwidth. Always USE WPA2 wireless connections with good passphrases.


----------------------------


## License 

[GPLv3](https://www.gnu.org/licenses/gpl-3.0.html)

Special thanks: [Sovereign](https://github.com/sovereign/sovereign), [Ansible](http://www.ansible.com/), [Debian](https://www.debian.org/), [awesome-selfhosted](https://github.com/Kickball/awesome-selfhosted).

