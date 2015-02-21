#! /bin/sh

CONTAINER_HOSTNAME=`etcdctl get /x44.email/containers/$CONTAINER/hostname`
if [[ ! -z $CONTAINER_HOSTNAME ]]
then
    echo "hostname: $CONTAINER_HOSTNAME"
    hostname $CONTAINER_HOSTNAME
fi
CONTAINER_HOSTNAME=
