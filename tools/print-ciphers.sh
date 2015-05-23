#! /bin/sh
openssl ciphers -v $1 | awk '{printf "%-32s %s\n", $1, $3}'
