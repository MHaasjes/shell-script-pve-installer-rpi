#!/bin/bash

# Check if the user has root privileges
if [ $(whoami) != "root" ]; then
  echo "This script must be run with root privileges."
  exit 1
fi

# Ask the user for the new server ip address
echo "Enter the ip address for the new server:"
read newipserver

# Validate the user's input
if [ -z "$newipserver" ]; then
  echo "You did not enter a server ip address. The script is stopping."
  exit 1
fi

# Ask the user for the new gateway ip address
echo "Enter the ip address for the new gateway:"
read newipgateway

# Validate the user's input
if [ -z "$newipgateway" ]; then
  echo "You did not enter a server ip address. The script is stopping."
  exit 1
fi

sudo nmcli c mod "Wired connection 1" ipv4.addresses "$newipserver"/24 ipv4.method manual
sudo nmcli con mod "Wired connection 1" ipv4.gateway "$newipgateway"
sudo nmcli con mod "Wired connection 1" ipv4.dns 8.8.8.8
sudo nmcli c down "Wired connection 1" && sudo nmcli c up "Wired connection 1"
