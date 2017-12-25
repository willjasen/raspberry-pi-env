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
sudo apt-get install git mdadm cryptsetup

# Configure git
echo "Setting up git.."
git config --global color.ui true
git config --global user.name willjasen
git config --global user.email willjasen@gmail.com

# Setup encrypted RAID 0 span
echo "Setting up encrypted RAID 0 as /mnt/secure"
sudo mdadm --create /dev/md0 --level=0 --raid-devices=2 /dev/sda1 /dev/sdb1
sudo mkdir -p /mnt/md0
sudo modprobe dm-crypt sha256 aes
sudo cryptsetup --verify-passphrase luksFormat /dev/md0 -c aes -s 256 -h sha256
sudo cryptsetup luksOpen /dev/md0 raid0
sudo mkfs -t ext4 -m 1 /dev/mapper/raid0
sudo mkdir /mnt/secure
sudo mount /dev/mapper/raid0 /mnt/secure/
sudo chown pi:pi /mnt/secure/
df -h | grep /mnt/secure

# Setup SSH with public key
echo "Setting up SSH with public key"
mkdir ~/.ssh
curl -o ~/.ssh/authorized_keys https://willjasen.keybase.pub/authorized_keys
chmod 600 ~/.ssh/authorized_keys

# Update the password for pi
echo "Change the password for user pi"
passwd pi
