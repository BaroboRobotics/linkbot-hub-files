#!/bin/bash

MAC_ID=`ifconfig eth0 | grep HWaddr | awk '{ print $5; }' | sed 's/[[:xdigit:]]*:[[:xdigit:]]*:[[:xdigit:]]*:\([[:xdigit:]]*\):\([[:xdigit:]]*\):\([[:xdigit:]]*\)/\1\2\3/g'`
echo $MAC_ID

NEWHN=linkbot-hub-$MAC_ID

# Set hostname to "linkbot-hub-$MAC_ID"

sudo sed -i "s/raspberrypi/$NEWHN/g" /etc/hosts
echo $NEWHN | sudo tee /etc/hostname
sudo /etc/init.d/hostname.sh

# Copy service file to correct location

sudo cp linkbot-hub.service /etc/avahi/services
sudo cp prex.service /etc/systemd/system

# Install necessary packages
sudo cp sources.list /etc/apt/
wget http://repo.barobo.com/barobo.public.key -O - | sudo apt-key add -
sudo apt-get update
sudo apt-get -y install npm
sudo apt-get -y install software-properties-common
sudo apt-get -y install linkbotd
sudo apt-get -y install tightvncserver
sudo apt-get -y install python3-pyqt4
sudo apt-get -y install tightvncserver
sudo apt-get -y install network-manager-gnome

# Set up linkbot-hub-announcer
sudo apt-get -y install linkbot-hub-announcer


# Run the cron jobs now.
sudo ./auto-update-pylinkbot
sudo systemctl enable prex

# Copy the cron jobs
sudo cp auto-update /etc/cron.daily/
sudo cp auto-update-pylinkbot /etc/cron.daily/

