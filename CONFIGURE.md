# Roundcube imapsync configuration

## Mysql
At the default mysql-server create the imapsynctable located in the appendix mysql.initial.sql

## Imapsync.pl
Replace the --host2 parameter from localhost to the imap-server used for the brand.
Also there is mysql connection data in bin/config.conf

Idealy this should run on a dedicated server with cron every 15 minutes or so


## Config.inc.php
This just limits the max ammound of imapsyncs.

