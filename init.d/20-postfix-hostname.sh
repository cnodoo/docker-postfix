#!/bin/sh
set +e

postconf -e myhostname=${POSTFIX_MYHOSTNAME:-`hostname -f`}
postconf -e mydomain=${POSTFIX_MYDOMAIN:-`hostname -d`}
postconf -e myorigin=${POSTFIX_MYORIGIN:-'$mydomain'}
