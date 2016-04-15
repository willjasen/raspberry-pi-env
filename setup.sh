#!/bin/bash

echo -n "Enter Git username: "
read git_username
echo -n "Enter Git user email: "
read git_user_email

# Update available packages
sudo apt-get -y update

# Install needed packages
sudo apt-get install -y git curl zlib1g-dev
sudo apt-get install -y openssl libreadline6-dev git-core zlib1g libssl-dev
sudo apt-get install -y libyaml-dev libsqlite3-dev sqlite3 postgresql
sudo apt-get install -y libxml2-dev libxslt-dev
sudo apt-get install -y autoconf automake libtool bison
sudo apt-get install -y nodejs libpq-dev

# Install RVM
curl -L get.rvm.io | bash -s stable --rails
source ~/.rvm/scripts/rvm

echo "gem: --no-ri --no-rdoc" > ~/.gemrc
gem install bundler
gem install execjs

# Configure git
git config --global color.ui true
git config --global user.name $git_username
git config --global user.email $git_user_email
