#!/bin/sh

postconf -e myhostname=`hostname -f`
postconf -e mydomain=`hostname -d`
postconf -e myorigin=\$mydomain
