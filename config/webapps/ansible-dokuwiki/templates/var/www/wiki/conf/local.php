<?php
/*
 * Dokuwiki's Main Configuration File - Local Settings
 */

$conf['lang'] = 'fr'; // Language
$conf['dmode'] = 0775; // Permission modes for directories
$conf['fmode'] = 0664; // Permission modes for files
$conf['youarehere'] = 1; // Display page location in toolbar https://www.dokuwiki.org/config:youarehere
$conf['tocminheads'] = '1'; // At least this number of headings before a Table of Contents is generated https://www.dokuwiki.org/config:tocminheads
$conf['maxtoclevel'] = '5'; // Table of content levels https://www.dokuwiki.org/config:tocminheads
$conf['useacl'] = 1; // Enable user account and permission systems https://www.dokuwiki.org/config:useacl
$conf['disableactions'] = 'register'; // Disable some actions https://www.dokuwiki.org/config:disableactions
$conf['htmlok'] = 1; // Allow user-provided HTML to be rendered in pages
$conf['rss_update'] = 600; // How often to update the RSS feed in seconds. Between updates the cached version of the RSS feed is used https://www.dokuwiki.org/config:rss_update
$conf['userewrite'] = '1'; // Cleaner addresses