### MiniDLNA multimedia server


ReadyMedia/MiniDLNA is a multimedia server using uPnP/DLNA. It can serve multimedia files (audio, video, images) to other devices connected to your network.

[ReadyMedia - ArchWiki](https://wiki.archlinux.org/index.php/ReadyMedia)

Client software includes VLC Media Player, Kodi, [and more](https://en.wikipedia.org/wiki/List_of_UPnP_AV_media_servers_and_clients#UPnP_AV_clients)), and other multimedia devices (portable players, smartphones, television, media centers).

_Note: Shares are not password protected. Files are shared publicly on your local network_

_Note: your media player may take some time to scan the media server if you have a lot of shared files_

_Note: If you add new files to your media directory, you will need to restart MiniDLNA to be able to see them. If you want MiniDLNA to rescan directories automatically, uncomment `inotify=yes` in the file `/etc/minidlna.conf` (this consumes more resources on your server)_



