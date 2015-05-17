#!/bin/sh
set -x
set -e

mgmt_ip=$(docker run --net=host alpine:latest sh -c "ip -4 route get 8.8.8.8" | awk '/src/ {print $NF}')

echo hello > foo
ftp -n $mgmt_ip <<EOF
user anonymous
cd uploads
put foo
bye
EOF

docker exec -t dropbox sh -c "cat /var/ftp/pub/uploads/foo"
