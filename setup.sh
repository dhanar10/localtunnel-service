#!/usr/bin/env bash

set -e
set -o pipefail

if ! [ $(id -u) -eq 0 ]; then
	echo "Must be run as root"
	exit 1
fi

if ! which nodejs > /dev/null; then
	curl -sL https://deb.nodesource.com/setup_15.x | bash -
	apt-get install -y nodejs
fi

if ! which lt > /dev/null; then
	npm install -g localtunnel
fi

mkdir -p /etc/localtunnel

cat EOF | tee /etc/localtunnel/example.conf
SUBDOMAIN=example
PORT=5000
EOF

cat << EOF | tee /etc/systemd/system/localtunnel@.service
[Unit]
Description=Expose yourself to the world
After=network-online.target
Wants=network-online.target
StartLimitInterval=200
StartLimitBurst=5

[Service]
EnvironmentFile=/etc/localtunnel/%i.conf
ExecStart=/usr/bin/lt --subdomain $SUBDOMAIN --port $PORT
Restart=always
RestartSec=30

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
#systemctl enable localtunnel@example
#systemctl start localtunnel@example

