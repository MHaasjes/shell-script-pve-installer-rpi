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


# Ask the user for the new server name
echo "Enter the new server name:"
read newservername

# Validate the user's input
if [ -z "$newservername" ]; then
  echo "You did not enter a server name. The script is stopping."
  exit 1
fi

# Create a backup of the /etc/hosts file
cp /etc/hosts /etc/hosts.bak

# Edit the /etc/hosts file with the new server name
sudo sed -i "s/localhost/$newservername/g" /etc/hosts

# Check if the change was successful
if grep "$newservername" /etc/hosts; then
  echo "The line has been changed successfully to '$newservername'."
else
  echo "An error occurred while changing the line."
  # Restore the backup if there was an error
  cp /etc/hosts.bak /etc/hosts
  exit 1
fi

# Remove the backup file
rm /etc/hosts.bak

sudo hostname $newservername

echo "The /etc/hosts file has been updated successfully."

# You need to set the root password for access to Proxmox
echo "You need to set the root password for access to Proxmox"
sudo passwd root

# Adding the Proxmox Ports repository
echt "Adding the Proxmox Ports repository"
curl -L https://mirrors.apqa.cn/proxmox/debian/pveport.gpg | sudo tee /usr/share/keyrings/pveport.gpg >/dev/null
echo "deb [deb=arm64 signed-by=/usr/share/keyrings/pveport.gpg] https://mirrors.apqa.cn/proxmox/debian/pve bookworm port" | sudo tee  /etc/apt/sources.list.d/pveport.list
echo  "apt update"
sudo apt update -y

# apt install:
echo "apt install"
sudo apt install ifupdown2 -y

sudo apt install proxmox-ve postfix open-iscsi pve-edk2-firmware-aarch64 -y

sudo reboot
