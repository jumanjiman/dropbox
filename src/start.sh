#!/bin/sh

readonly logfile=/var/log/vsftpd.log
tail -F $logfile &

tail -F $logfile &

touch $logfile
chmod o+wx /var/ftp/pub/uploads
exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
