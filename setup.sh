#!/usr/bin/env bash

if [ -z "$1" ]
then
  echo "Error: Nginx download link argument is mandatory"
  return;
fi

echo "Updating the package manager" && sleep 1
sudo apt-get update

echo "Installing wget" && sleep 1
sudo apt install wget

echo "Downloading provided nginx version" && sleep 1
wget -O nginx-source.tar.gz $1

echo "Extracting files" && sleep 1
mkdir nginx-source
tar -zxvf nginx-source.tar.gz -C nginx-source --strip-components=1
cd nginx-source

echo "Installing compilation dependencies" && sleep 1
apt-get install libpcre3 libpcre3-dev zlib1g zlib1g-dev libssl-dev -y

echo "Compile nginx with custom configuration" && sleep 1
./configure --sbin-path=/usr/bin/nginx --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --with-pcre --pid-path=/var/run/nginx.pid --with-http_ssl_module

echo "Building nginx from source"  && sleep 1
make

echo "Installing nginx build" && sleep 1
make install
clear

echo "Verify installation files" && sleep 1
ls -l /etc/nginx/
nginx -V

echo "Setting systemd configuration" && sleep 1
cp nginx.service /lib/systemd/system/nginx.service

echo "done."
