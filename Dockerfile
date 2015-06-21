FROM dawi2332/alpine.rsyslog
MAINTAINER dawi2332@gmail.com

EXPOSE 25
EXPOSE 587

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["postfix"]

RUN apk add --update postfix postfix-pcre ca-certificates py-pip py-ipaddr \
	&& pip install pydns pyspf pypolicyd-spf \
	&& rm -rf /var/cache/apk/*

# copy postfix config files
COPY assets/etc/postfix/ /etc/postfix/
RUN postmap hash:/etc/postfix/tls_policy

# copy aliases and update hash
COPY assets/etc/aliases /etc/aliases
RUN newaliases

# add/modify services in /etc/postfix/master.cf
RUN postconf -eM submission/inet="submission inet n - - - - smtpd -o syslog_name=postfix/submission -o smtpd_tls_security_level=encrypt -o smtpd_sasl_auth_enable=yes -o smtpd_client_restrictions=permit_sasl_authenticated,reject -o smtpd_sender_restrictions=reject_sender_login_mismatch,permit -o milter_macro_daemon_name=ORIGINATING -o cleanup_service_name=submission-cleanup"
RUN postconf -eM submission-cleanup/unix="submission-cleanup unix n - - - 0 cleanup -o syslog_name=postfix/submission -o header_checks=pcre:\${config_directory}/header_checks"
RUN postconf -eM policy-spf/unix="policy-spf unix - n n - - spawn user=nobody argv=/usr/bin/policyd-spf"

# create /var/spool/postfix/hold
RUN mkdir -p /var/spool/postfix/hold && \
	chmod 700 /var/spool/postfix/hold && \
	chown postfix /var/spool/postfix/hold

RUN postconf -e smtpd_tls_dh1024_param_file=\${config_directory}/dh2048.pem

COPY assets/etc/supervisor /etc/supervisor

COPY docker-entrypoint.sh /
COPY init.d /docker-entrypoint-init.d

COPY dh512.pem /etc/postfix/dh512.pem
COPY dh1024.pem /etc/postfix/dh1024.pem
COPY dh2048.pem /etc/postfix/dh2048.pem
