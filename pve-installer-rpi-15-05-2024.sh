#!/bin/bash

# Check if the user has root privileges
if [ $(whoami) != "root" ]; then
  echo "This script must be run with root privileges."
  exit 1
fi

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

sudo sed -i "s/raspberrypi/$newservername/g" /etc/hosts

sudo sed -i "s/raspberrypi/$newservername/g" /etc/hostname

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

sudo hostname "$newservername"


echo "The /etc/hosts file has been updated successfully."

#sudo apt update -y && sudo apt upgrade -y

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
