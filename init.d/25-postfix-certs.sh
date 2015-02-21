#! /bin/sh
set +e

. /docker-entrypoint-init.d/functions.sh

cert=/etc/ssl/certs/postfix.pem
key=/etc/ssl/private/postfix.key
prefix=/x44.email/containers/$CONTAINER/postfix/

getfile $prefix/ssl-cert.pem $key \
    && chmod 640 $key \
    && chgrp ssl-cert $key \
    && postconf -e smtpd_tls_key_file=$key

getfile $prefix/ssl-cert.key $cert \
    && postconf -e smtpd_tls_cert_file=$cert
