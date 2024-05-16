# Proxmox Virtualisation on Raspbeerry Pi 4 and 5

----------------------
Warning, still testing this.  This tool is provided without warranty. Any damage caused is your own responsibility.
----------------------

Proxmox Auto Installer for Raspbeerry Pi 4 and 5. 

----------------------
Installation Procedure
----------------------

Install 2024-03-15-raspios-bookworm-arm64-lite.img on a SD card, NVME or usb device and boot the raspberry pi.

At first, you will have to install git on your system.<br>

```
sudo sudo apt install git -y
```
<br><br>Once git is installed, you are ready to clone my script!<br>

```
git clone https://github.com/MHaasjes/pve-installer-rpi.git
```
<br><br>
Then, enter to the directory and change the permission.<br><br>
```
cd pve-installer-rpi

sudo chmod +x pve-installer-rpi.sh
```
```
sudo chmod +x pve-installer-rpi-set-ip.sh
```
You need to set your IP (DHCP makes it crash afther a reboot). Use this script or set it yourself:
```
sudo ./pve-installer-rpi-set-ip.sh
```
Now install Proxmox VE
```
sudo ./pve-installer-rpi.sh
```
<br><br>
At the end, please visit your web browser for ``https://your_ip_address:8006`` further configuration.<br>

You will be required for username and password authentication which is root and the root password.
