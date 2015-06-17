#!/bin/bash

clean_trashes() {
	oc_trashes=$(find /var/www/owncloud -name files_trashbin)
	srm -llzr $oc_trashes
}