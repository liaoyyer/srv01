#!/bin/bash
_getTimestamp() {
    date +"%Y-%m-%d_%H%M%S"
}

_CreateDB() {
	QUERY="create database $1; create user $1@localhost identified by \"$2\"; grant all on $1.* to $1@localhost;"
	mysql -u root -p -e "$QUERY"
}