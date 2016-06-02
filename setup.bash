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
sudo cp sources.list /etc/apt/
wget http://repo.barobo.com/barobo.public.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install npm
sudo apt-get -y install software-properties-common
sudo apt-get -y install linkbotd
sudo apt-get install -y wicd-curses
sudo apt-get remove -y dhcpcd5

# Set up ip-address-announcer

pushd ip-address-announcer
npm install
sudo cp linkbot-hub-announcer.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl start linkbot-hub-announcer
popd

# Download and install Python 3.5
wget https://dl.dropboxusercontent.com/s/axqf613056ckt8e/python-3.5.1-armhf.tar.gz?dl=0 -O python-3.5.1-armhf.tar.gz
pushd /opt
sudo tar xf ~/linkbot-hub-files/python-3.5.1-armhf.tar.gz
popd

# Run the cron jobs now.
sudo ./auto-update-pylinkbot

# Copy the cron jobs
sudo cp auto-update /etc/cron.daily/
sudo cp auto-update-pylinkbot /etc/cron.daily/
