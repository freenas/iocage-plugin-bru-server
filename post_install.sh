#!/bin/sh
fetch http://www.tolisgroup.com/downloads/bruserver20/complete/BRU_Server_Complete_freebsd11_2.0.5.tgz
if [ $? -ne 0 ] ; then
  echo "ERROR: Failed fetching the BRU server package"
  exit 1
fi
tar xvfz BRU_Server_Complete_freebsd11_2.0.5.tgz

mkdir -p /usr/local/bru-server
mkdir -p /usr/local/bin
mkdir -p /usr/local/etc/rc.d

cd unix/agent && mv * /usr/local/bru-server && cd ../console && mv * /usr/local/bru-server
chmod +x /usr/local/etc/rc.d/bru_server
ln -s /usr/local/bru-server/bru-server.console /usr/local/bin/bru-server.console
sysrc -f /etc/rc.conf bru_server_enable="YES"

echo "You will need to set bru_server_server and bru_server_password in /etc/rc.conf before the service will start" > /root/PLUGIN_INFO
echo "For more information on how to use BRU, visit: http://www.tolisgroup.com/assets/bru_server_1.2.0_cli_guide.pdf" >> /root/PLUGIN_INFO
