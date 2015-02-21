#! /bin/sh
set +e

prefix=/x44.email/containers/$CONTAINER/postfix/

etcdctl get $prefix/dh512.pem > /etc/postfix/dh512.pem 2>/dev/null \
    && postconf -e smtpd_tls_dh512_param_file=\${config_directory}/dh512.pem
etcdctl get $prefix/dh2048.pem > /etc/postfix/dh2048.pem 2>/dev/null \
    && postconf -e smtpd_tls_dh1024_param_file=\${config_directory}/dh2048.pem
