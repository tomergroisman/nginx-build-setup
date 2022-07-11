#!/bin/bash

while getopts ":mu" opt; do
  case $opt in
    m)
      echo "Updating the package manager" && sleep 1
      brew update
      echo "Install Nginx" && sleep 1
      brew install nginx
      echo "Copy configuration file" && sleep 1
      cp mac.nginx.conf /usr/local/etc/nginx/nginx.conf
      echo "Stating Nginx" && sleep 1
      nginx -s reload
      ;;
    u)
      echo "Updating the package manager" && sleep 1
      sudo apt-get update
      echo "Install Nginx" && sleep 1
      sudo apt install nginx
      echo "Copy configuration file" && sleep 1
      cp unix.nginx.conf /etc/nginx/nginx.conf
      echo "Stating Nginx" && sleep 1
      sudo nginx -s reload
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

echo "done."
