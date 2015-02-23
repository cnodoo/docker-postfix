#! /bin/sh
set +e

rsacert=/etc/ssl/certs/smtp-rsa.pem
rsakey=/etc/ssl/private/smtp-rsa.key
ecdsacert=/etc/ssl/certs/smtp-ecdsa.pem
ecdsakey=/etc/ssl/private/smtp-ecdsa.key
prefix=/x44.email/containers/$CONTAINER/postfix/

etcdctl get $prefix/smtp-rsa.key > $rsakey 2>/dev/null \
    && chmod 640 $rsakey \
    && chgrp ssl-cert $rsakey \
    && postconf -e smtpd_tls_key_file=$rsakey

etcdctl get $prefix/smtp-rsa.pem > $rsacert 2>/dev/null \
    && postconf -e smtpd_tls_cert_file=$rsacert

etcdctl get $prefix/smtp-ecdsa.key > $ecdsakey 2>/dev/null \
    && chmod 640 $ecdsakey \
    && chgrp ssl-cert $ecdsakey \
    && postconf -e smtpd_tls_eckey_file=$ecdsakey

etcdctl get $prefix/smtp-ecdsa.pem > $ecdsacert 2>/dev/null \
    && postconf -e smtpd_tls_eccert_file=$ecdsacert
