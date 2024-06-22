#!/bin/bash

#######################################################################################
# Check if the user has root privileges
echo -e "\e[0;35m Checking if the user has root privileges. \e[0m"
if [ $(whoami) != "root" ]; then
echo -e "\e[1;31m This script must be run with root privileges. \e[0m"
exit 1
fi
echo
echo -e "\e[0;35m Root privileges, check. \e[0m"
echo
echo
#######################################################################################

#######################################################################################
# Ask the user for the new server ip address
echo -e "\e[0;35m Enter the ip address for the new server: \e[0m"
read newipserver

# Validate the user's input
if [ -z "$newipserver" ]; then
echo "\e[1;31m You did not enter a server ip address. The script is stopping. \e[0m"
exit 1
fi
#######################################################################################

#######################################################################################
# Ask the user for the new gateway ip address
echo -e "\e[0;35m Enter the ip address for the gateway: \e[0m"
read newipgateway

# Validate the user's input
if [ -z "$newipgateway" ]; then
echo "\e[1;31m You did not enter a server ip address. The script is stopping. \e[0m"
exit 1
fi
#######################################################################################

#######################################################################################
# Set IP address, subnet mask
echo
echo
echo -e "\e[0;35m Setting IP address, subnet mask and DNS. \e[0m"
echo
sudo nmcli c mod "Wired connection 1" ipv4.addresses "$newipserver"/24 ipv4.method manual
# Set gateway IP for wired connection
sudo nmcli con mod "Wired connection 1" ipv4.gateway "$newipgateway"
# Set preferred DNS server (change 8.8.8.8 if desired)
sudo nmcli con mod "Wired connection 1" ipv4.dns 8.8.8.8
#Reboot at the end will take care of this
#sudo nmcli c down "Wired connection 1" && sudo nmcli c up "Wired connection 1"
#######################################################################################

#######################################################################################
# Ask the user for the new server name
echo
echo -e "\e[0;35m Enter the new server name: \e[0m"
read newservername

# Validate the user's input
if [ -z "$newservername" ]; then
echo "You did not enter a server name. The script is stopping."
exit 1
fi
echo
#######################################################################################

#######################################################################################
# Create a backup of the /etc/hosts file
echo
echo -e "\e[0;35m Creating a backup of the /etc/hosts file. \e[0m"
echo
cp /etc/hosts /etc/hosts.bak
# Edit the /etc/hosts file with the new server name
echo
echo -e "\e[0;35m Editing the /etc/hosts file with the new server name. \e[0m"
echo
echo -e "\e[0;35m Editing /etc/hosts \e[0m"
sudo sed -i "s/orangepiplus2e/$newservername/g" /etc/hosts
echo -e "\e[0;35m Editing /etc/hostname \e[0m"
sudo sed -i "s/orangepiplus2e/$newservername/g" /etc/hostname
sudo sed -i "s/127.0.1.1/$newipserver/g" /etc/hosts
# Check if the change was successful
echo
echo -e "\e[0;35m Checking if the change was successful. \e[0m"
echo
if grep "$newservername" /etc/hosts; then
echo -e "\e[0;35m The line has been changed successfully to '$newservername'.  \e[0m"
else
echo "An error occurred while changing the line." 
# Restore the backup if there was an error
cp /etc/hosts.bak /etc/hosts
echo "\e[1;31m Restoring the backup, there was an error. The script is stopping. \e[0m"
exit 1
fi
# Remove the backup file
rm /etc/hosts.bak
#######################################################################################

#######################################################################################
# Set hostname
sudo hostname "$newservername"
#######################################################################################

#######################################################################################
#Need to test if this breaks the script
#sudo apt update -y && sudo apt upgrade -y
#######################################################################################

#######################################################################################
# You need to set the root password for access to Proxmox
echo
echo -e "\e[0;35m You need to set the root password for access to Proxmox: \e[0m"
echo
sudo passwd root
#######################################################################################

#######################################################################################
# Adding the Proxmox Ports repository
echo
echo  -e  "\e[0;35m Adding the Proxmox Ports repository. \e[0m"
echo
curl -L https://mirrors.apqa.cn/proxmox/debian/pveport.gpg | sudo tee /usr/share/keyrings/pveport.gpg >/dev/null
echo "deb [deb=arm64 signed-by=/usr/share/keyrings/pveport.gpg] https://mirrors.apqa.cn/proxmox/debian/pve bookworm port" | sudo tee  /etc/apt/sources.list.d/pveport.list
echo  -e  "\e[0;35m Running apt update. \e[0m"
sudo apt update -y
#######################################################################################

#######################################################################################
# Setting swap from 100 to 2048
echo
echo  -e  "\e[0;35m Setting swap from 100 to 2048. \e[0m"
echo
sudo dphys-swapfile swapoff
sudo sed -i "s/100/2048/g" /etc/dphys-swapfile
sudo dphys-swapfile setup
sudo dphys-swapfile swapon
#######################################################################################

#######################################################################################
# Editing /etc/network/interfaces
echo
echo  -e  "\e[0;35m Editing /etc/network/interfaces. \e[0m"
echo
sudo apt install ifupdown2 -y

sudo sed -i -e '$ a\auto lo\niface lo inet loopback \n \niface eth0 inet manual \n \nauto vmbr0 \niface vmbr0 inet static \n        address newipserver/24 \n        gateway newipgateway \n        bridge-ports eth0 \n        bridge-stp off \n        bridge-fd 0' /etc/network/interfaces
sudo sed -i "s/newipserver/$newipserver/g" /etc/network/interfaces
sudo sed -i "s/newipgateway/$newipgateway/g" /etc/network/interfaces
#######################################################################################

#######################################################################################
# apt install postfix:
echo
echo -e "\e[0;35m apt install postfix.  \e[0m"
echo
sudo debconf-set-selections <<< "postfix postfix/mailname string $newservername"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'No configuration'"
sudo apt-get install --assume-yes postfix -y
#######################################################################################

#######################################################################################
echo
echo -e "\e[0;35m apt install open-iscsi and pve-edk2-firmware-aarch64.  \e[0m"
echo
sudo apt install open-iscsi pve-edk2-firmware-aarch64 -y
#######################################################################################

#######################################################################################
# apt install proxmox-ve 
echo
echo -e "\e[0;35m apt install proxmox-ve.  \e[0m"
echo
sudo DEBIAN_FRONTEND=noninteractive apt-get install proxmox-ve -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
#######################################################################################

#######################################################################################
# Reboot
echo
echo -e "\e[0;35m Reboot.  \e[0m"
echo
sudo reboot
