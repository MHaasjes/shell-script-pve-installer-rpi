# Proxmox VE (Virtual Environment) on Raspberry Pi 4 and Raspberry Pi 5

This tool is provided without warranty. Any damage caused is your own responsibility.
-

Proxmox Auto Installer for Raspberry Pi 4 and 5:
-
Successfully tested this scripts on a Raspberry Pi 5 8GB model on an NVMe SSD (NVMe HAT).<br>
Successfully tested this scripts on a Raspberry Pi 4 4GB model on an NVMe SSD (NVMe USB adapter).


Requirements:
-

A Raspberry Pi 4 or 5

Prepare your Raspberry Pi:
-

Install the Raspberry Pi OS image: 2024-03-15-raspios-bookworm-arm64-lite.img on an SD card, NVMe drive, or USB device with enough storage for the OS.
Boot your Raspberry Pi from the prepared storage device.


Installation Procedure:
-

At first, you will need to install git on your system.<br>

```
sudo sudo apt install git -y
```
<br><br>Once git is installed, you are ready to clone the script.<br>

```
git clone https://github.com/MHaasjes/pve-installer-rpi.git
```
<br><br>
Then, enter the directory and change the permission.<br><br>
```
cd pve-installer-rpi
```
```
sudo chmod +x pve-installer-rpi-2.3.sh
```

The script will prompt you to set your IP address. (You need to set your IP, DHCP makes it crash after a reboot)

Now, let's install Proxmox VE:

```
sudo ./pve-installer-rpi-2.3.sh
```
<br><br>

Post-Installation:
-
Visit your web browser at https://your_ip_address:8006 for further configuration.
You will be required to authenticate using username root and the root password.


One-liner Installation (for experienced users):
-

```
sudo apt install git -y && git clone https://github.com/MHaasjes/pve-installer-rpi.git && cd pve-installer-rpi && sudo chmod +x pve-installer-rpi-2.3.sh && sudo ./pve-installer-rpi-2.3.sh
```


To do:
-
- Test on Raspberry pi 3 as witness Host
