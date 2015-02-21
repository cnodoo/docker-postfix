#! /bin/sh
set +e

cert=/etc/ssl/certs/postfix.pem
key=/etc/ssl/private/postfix.key
prefix=/x44.email/containers/$CONTAINER/postfix/

etcdctl get $prefix/ssl-cert.pem > $key 2>/dev/null \
    && chmod 640 $key \
    && chgrp ssl-cert $key \
    && postconf -e smtpd_tls_key_file=$key

etcdctl get $prefix/ssl-cert.key > $cert 2>/dev/null \
    && postconf -e smtpd_tls_cert_file=$cert
