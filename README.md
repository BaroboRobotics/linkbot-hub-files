# Linkbot Hub Configuration

#### Install and Configure Raspbian

Write Raspbian Jessie to a 4GB+ microSD card. Check to see if your card is on the [compatibility
list](http://elinux.org/RPi_SD_cards) first to avoid pain.

Boot your Raspberry Pi 3, run `raspi-config` and use it to expand the filesystem, add at least one
locale (`en_US.UTF-8`), and configure the keyboard.

#### Set the Linkbot Hub Hostname

Assign a hostname of the form `linkbot-hub-xxxx` where `xxxx` is some ID to be determined (I use
`9966` on my test unit). To change the hostname, edit `/etc/hostname`, `/etc/hosts`, execute
`sudo /etc/init.d/hostname.sh`, then (maybe?) reboot.

#### Configure Avahi

Clone this repo on the RPi into `/home/pi` and execute:

```
sudo cp linkbot-hub.service /etc/avahi/services
sudo /etc/init.d/avahi-daemon restart
```

Now you should be able to connect to your Linkbot Hub at `linkbot-hub-xxxx.local`, for some `xxxx`
chosen before. For this `.local` mDNS name to work on Windows, you must install Apple's [Bonjour
Print Services](https://support.apple.com/kb/DL999?locale=en_US) first.

#### Start the IP Announcer

Enter the `ip-address-announcer` directory in this repo and follow the instructions in its
[README](https://github.com/BaroboRobotics/linkbot-hub-files/blob/master/ip-address-announcer/README.md).

#### TODO

apt-get remove dhcpcd5 because it has trouble with wicd.

apt-get install wicd-curses
Run wicd-curses, press P for preferences and configure like so:
- always show wired interface
- always switch to wired connection when available

apt-get install linkbotd
Install Python 3.5
Install PyLinkbot3
Automatic update scripts (auto-update, etc.)

Bluetooth PAN setup (WIP):
apt-get install bridge-utils  # for brctl
wget https://raw.githubusercontent.com/mk-fg/fgtk/master/bt-pan
chmod +x bt-pan
sudo ./bt-pan --debug server bnep
Follow the instructions?
