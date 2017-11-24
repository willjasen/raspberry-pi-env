#!/bin/bash

# Gather user input
echo -n "Enter Git username: "
read git_username
echo -n "Enter Git user email: "
read git_user_email

# Prevent perl warnings with new Raspberry Pi's
export LC_ALL=C

# Setup USB drive with ext4 format
#
# umount /dev/sda1
# fdisk /dev/sda1
# (option n for new partition)
# (option p to create a primary partition)
# (option w to save the changes)
# mkfs.ext4 /dev/sda1
# mkdir /mnt/usb
# mount /dev/sda1 /mnt/usb
#
# (insert into /etc/fstab) /dev/sda1	/media/sync	ext4	defaults	0	0

# Setup 802.1q support
# sudo apt-get install vlan
# echo '8021q' | sudo tee /etc/modules
# sudo modprobe 8021q
# sudo /etc/init.d/networking restart

# Install and run BitTorrent Sync
# mkdir ~/.btsync
# curl -o ~/.btsync/BitTorrent-Sync_arm.tar.gz https://download-cdn.getsync.com/stable/linux-arm/BitTorrent-Sync_arm.tar.gz
# tar xfv ~/.btsync/BitTorrent-Sync_arm.tar.gz -C ~/.btsync
# sudo cp btsync /etc/init.d
# cp btsync.conf ~/.btsync
# sudo chmod 755 /etc/init.d/btsync
# sudo update-rc.d btsync defaults
# sudo service btsync start

# Update available packages
sudo apt-get -y update

# Install needed packages
echo "Installing packages.."
sudo apt-get git mdadm
# sudo apt-get install -y git curl zlib1g-dev
# sudo apt-get install -y openssl libreadline6-dev git-core zlib1g libssl-dev
# sudo apt-get install -y libyaml-dev libsqlite3-dev sqlite3 postgresql
# sudo apt-get install -y libxml2-dev libxslt-dev
# sudo apt-get install -y autoconf automake libtool bison
# sudo apt-get install -y nodejs libpq-dev

# Install RVM
# curl -L get.rvm.io | bash -s stable --rails
# source ~/.rvm/scripts/rvm

# echo "gem: --no-ri --no-rdoc" > ~/.gemrc
# gem install bundler
# gem install execjs

# Configure git
echo "Setting up git.."
git config --global color.ui true
git config --global user.name $git_username
git config --global user.email $git_user_email
