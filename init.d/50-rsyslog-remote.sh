#! /bin/sh
set +e

RSYSLOG_REMOTE=`etcdctl get /x44.email/services/rsyslog/remotehost`
if [ ! -z $RSYSLOG_REMOTE ]; then
    echo "rsyslog remote host: $RSYSLOG_REMOTE"
    echo "*.* $RSYSLOG_REMOTE" > /etc/rsyslog.d/50-remote.conf

    rm /etc/rsyslog.d/50-default.conf
fi
