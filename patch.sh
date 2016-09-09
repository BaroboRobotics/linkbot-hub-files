#!/bin/sh

sudo cp crontab /etc/
cp authorized_keys /home/odroid/.ssh/
sudo apt-get update
sudo apt-get -y install linkbot-hub-files linkbot-firmware
