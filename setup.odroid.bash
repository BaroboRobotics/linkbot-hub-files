#!/bin/bash

MAC_ID=`ifconfig eth0 | grep HWaddr | awk '{ print $5; }' | sed 's/[[:xdigit:]]*:[[:xdigit:]]*:[[:xdigit:]]*:\([[:xdigit:]]*\):\([[:xdigit:]]*\):\([[:xdigit:]]*\)/\1\2\3/g'`
echo $MAC_ID

NEWHN=linkbot-hub-$MAC_ID

# Set hostname to "linkbot-hub-$MAC_ID"

sudo sed -i "s/odroid64/$NEWHN/g" /etc/hosts
echo $NEWHN | sudo tee /etc/hostname
sudo /etc/init.d/hostname.sh

cp odroid/authorized_keys ~/.ssh/
sudo cp odroid/sshd_config /etc/ssh/

# Install necessary packages
sudo apt-add-repository 'deb http://repo.barobo.com/ jessie main'
wget http://repo.barobo.com/barobo.public.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo apt-get install linkbot-hub-files
