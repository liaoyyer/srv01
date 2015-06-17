#!/bin/bash
set -o errexit
set -o nounset
source common.sh

_install() {
	echo "Not yet implemented"
	#configure: enable external API
}

_backup() {
	TS=$(getTimestamp)
	ttrss_backup_dir='/var/backups/ttrss'
	ttrss_backup_file="ttrss.$TS.mysqldump"
	backup_compress="true"

	if [[ ! -d "$ttrss_backup_dir" ]]; then
	  mkdir -p "$ttrss_backup_dir"
	fi

	mysqldump --single-transaction ttrss > "$ttrss_backup_dir/$ttrss_backup_file" &&

	if [ "$backup_compress" == "true" ]; then
		apack "$ttrss_backup_dir/$ttrss_backup_file.7z" "$ttrss_backup_dir/$ttrss_backup_file" &&
		srm -llzr  "$ttrss_backup_dir/$ttrss_backup_file"
	fi


}

_backup_expire() {
	  find "$ttrss_ttrss_backup_dir" -mtime +"$days_keep" -print0 | xargs -0 "$rm_command"
}

