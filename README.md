# Proxmox Virtual Environment on Raspberry Pi 4 and 5
#



----------------------
This tool is provided without warranty. Any damage caused is your own responsibility.
----------------------

Proxmox Auto Installer for Raspberry Pi 4 and 5. 


Successfully tested this set of scripts on a  Raspberry Pi 5 8GB model on a NVME SSD (NVME HAT).

Successfully tested this set of scripts on a  Raspberry Pi 4 4GB model on a NVME SSD (NVME USB adapter).

----------------------
Installation Procedure
----------------------

Install 2024-03-15-raspios-bookworm-arm64-lite.img on a SD card, NVME or USB device and boot the raspberry pi.

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
```
```
sudo chmod +x pve-installer-rpi-2.3.sh
```
You need to set your IP (DHCP makes it crash after a reboot), the script will ask you.

Now lets install Proxmox VE:

```
sudo ./pve-installer-rpi-2.3.sh
```

<br><br>
At the end, please visit your web browser for ``https://your_ip_address:8006`` further configuration.<br>

You will be required for username and password authentication which is root and the root password.

To do:

- Cleanup scripts
- Better/more info per step in the scripts
- Cleanup README.md
- Test on Raspberry pi 3 as witness Host
- add message at end of pve-installer-rpi-set-ip.sh that you need to log back on if using ssh

