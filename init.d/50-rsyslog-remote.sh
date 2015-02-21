#! /bin/sh

rm /etc/rsyslog.d/50-default.conf

REMOTE_HOST=`etcdctl get /x44.email/services/rsyslog/remotehost`
if [ ! -z $REMOTE_HOST ]; then
    echo "rsyslog remote host: $REMOTE_HOST"
    echo "*.* $REMOTE_HOST" > /etc/rsyslog.d/50-remote.conf
fi
REMOTE_HOST=
