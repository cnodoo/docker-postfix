#! /bin/sh
curl -L -X PUT http://$1/v2/keys$2 --data-urlencode value@$3
