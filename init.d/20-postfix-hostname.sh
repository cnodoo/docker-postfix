#!/bin/sh
set +e

MYHOSTNAME=`etcdctl get /x44.email/containers/$CONTAINER/postfix/myhostname`
MYDOMAIN=`etcdctl get /x44.email/containers/$CONTAINER/postfix/mydomain`
MYORIGIN=`etcdctl get /x44.email/containers/$CONTAINER/postfix/myorigin`

postconf -e myhostname=${MYHOSTNAME:-`hostname -f`}
postconf -e mydomain=${MYDOMAIN:-`hostname -d`}
postconf -e myorigin=${MYORIGIN:-\$mydomain}
