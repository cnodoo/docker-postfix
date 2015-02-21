#! /bin/sh
set +e

. /docker-entrypoint-init.d/functions.sh

prefix=/x44.email/containers/$CONTAINER/postfix/

getfile $prefix/dh512.pem /etc/postfix/dh512.pem \
    && postconf -e smtpd_tls_dh512_param_file=\${config_directory}/dh512.pem
getfile $prefix/dh2048.pem /etc/postfix/dh2048.pem \
    && postconf -e smtpd_tls_dh1024_param_file=\${config_directory}/dh2048.pem
