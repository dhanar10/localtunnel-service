# localtunnel-setup

Setup a localtunnel service that runs on boot

## Usage

To setup a localtunnel service

```
$ wget -c https://github.com/dhanar10/localtunnel-setup/raw/master/localtunnel-setup.sh
$ sudo bash localtunnel-setup.sh
$ cat EOF | sudo tee /etc/localtunnel/mylocaltunnel.conf
SUBDOMAIN=mydomain
PORT=5000
EOF
```
$ sudo systemctl enable localtunnel@mylocaltunnel
$ sudo systemctl start localtunnel@mylocaltunnel

## Credits

https://theboroer.github.io/localtunnel-www/
