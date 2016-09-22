#!/bin/bash

MAC_ID_RAW=$(cat /sys/class/net/eth0/address \
    | cut -d: -f4- --output-delimiter='' )
MAC_ID=$(echo $MAC_ID_RAW | awk '{print tolower($0)}')
echo $MAC_ID

NEWHN=linkbot-hub-$MAC_ID

# Set hostname to "linkbot-hub-$MAC_ID"

sudo sed -i "s/raspberrypi/$NEWHN/g" /etc/hosts
echo $NEWHN | sudo tee /etc/hostname
sudo /etc/init.d/hostname.sh

