#!/bin/bash

cd /home/odroid/linkbot-hub-files
git pull origin master > /var/log/linkbot-hub-init.log 2>&1
./setup.odroid.bash >> /var/log/linkbot-hub-init.log 2>&1

rm $0
