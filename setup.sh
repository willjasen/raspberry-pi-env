#!/bin/bash

# Gather user input
# echo -n "Enter Git username: "
# read git_username
# echo -n "Enter Git user email: "
# read git_user_email

# Prevent perl warnings with new Raspberry Pi's
export LC_ALL=C

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

# Configure git
echo "Setting up git.."
git config --global color.ui true
git config --global user.name willjasen
git config --global user.email willjasen@gmail.com

# Setup RAID 0 span
echo "Setting up RAID 0"
sudo mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sda1 /dev/sdb1
sudo mkdir -p /mnt/raid0
sudo mkfs.ext4 /dev/md0
sudo mount /dev/md0 /mnt/raid1/

# Setup SSH with public key
echo "Setting up SSH with public key"
mkdir .ssh
curl -o .ssh/authorized_keys https://willjasen.keybase.pub/authorized_keys
chmod 600 .ssh/authorized_keys

# Update the password for pi
echo "Change the password for user pi"
passwd pi
