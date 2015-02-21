#! /bin/sh
set -e

if [ "$1" = 'postfix' ]; then
    if [ -d /docker-entrypoint-init.d ]; then
            for f in /docker-entrypoint-init.d/*.sh; do
                    [ -f "$f" ] && . "$f"
            done
    fi

    exec /usr/lib/postfix/master -d
fi
