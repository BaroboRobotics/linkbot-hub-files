#!/bin/bash

MAC_ID=`ifconfig eth0 | grep HWaddr | awk '{ print $5; }' | sed 's/[[:xdigit:]]*:[[:xdigit:]]*:[[:xdigit:]]*:\([[:xdigit:]]*\):\([[:xdigit:]]*\):\([[:xdigit:]]*\)/\1\2\3/g'`
echo $MAC_ID

NEWHN=linkbot-hub-$MAC_ID

# Set hostname to "linkbot-hub-$MAC_ID"

sudo sed -i 's/raspberrypi/$NEWHN/g' /etc/hosts
echo $NEWHN | sudo tee /etc/hostname
sudo /etc/init.d/hostname.sh

# Copy service file to correct location

sudo cp linkbot-hub.service /etc/avahi/services

# Install necessary packages
sudo apt-get update
sudo apt-get -y install npm

# Set up ip-address-announcer

pushd ip-address-announcer
npm install
sudo cp linkbot-hub-announcer.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start linkbot-hub-announcer
popd
