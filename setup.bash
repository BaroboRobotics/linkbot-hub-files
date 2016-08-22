#!/bin/bash

MAC_ID=$(cat /sys/class/net/eth0/address \
    | cut -d: -f4- --output-delimiter='' \
    | awk '{print tolower($0)}')
echo $MAC_ID

NEWHN=linkbot-hub-$MAC_ID

# Set hostname to "linkbot-hub-$MAC_ID"

sudo sed -i "s/raspberrypi/$NEWHN/g" /etc/hosts
echo $NEWHN | sudo tee /etc/hostname
sudo /etc/init.d/hostname.sh

# Install necessary packages
sudo apt-add-repository 'deb http://repo.barobo.com/ jessie main'
wget http://repo.barobo.com/barobo.public.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node
sudo apt-get install linkbot-hub-files
