#!/bin/bash

while getopts ":s:hm" opt; do
  case $opt in
    s)
      sh install-from-source/setup.sh "$OPTARG"
      exit
      ;;
    m)
      sh install/setup.sh -m
      exit
      ;;
    h)
      echo "Usage: sh setup.sh [OPTIONS] [ARGS]"
      echo
      echo "  Nginx setup helper"
      echo
      echo "Options"
      echo "  -s,   Builds nginx from source"
      echo
      echo "Arguments"
      echo "  link-to-nginx-download (mandatory if -s flag is on)"
      exit
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

sh install/setup.sh -u
