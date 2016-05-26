To make a Linkbot Hub image:

Raspbian Jessie
raspi-config
apt-get remove dhcpcd5
apt-get install wicd-curses
Switch wicd to use dhclient
apt-get install linkbotd
Install Python 3.5
Install PyLinkbot3
Set up Avahi
Automatic update scripts (auto-update, etc.)
