# Proxmox VE 9 (Virtual Environment) on Raspberry Pi 4 and Raspberry Pi 5

This tool is provided without warranty. Any damage caused is your own responsibility.
-

Proxmox Auto Installer for Raspberry Pi 4 and 5:
-
NOT tested this scripts on a Raspberry Pi 5 8GB model on an NVMe SSD (NVMe HAT). A VM will boot <br>
NOT tested this scripts on a Raspberry Pi 4 4GB model on an NVMe SSD (NVMe USB adapter) A VM will boot. <br>
NOT tested this scripts on a Raspberry Pi 3B on an SDcard. A VM will not boot. <br>
NOT tested this scripts on a Raspberry Pi CM4 1GB RAM 8GB eMMC Model. A VM will boot. <br>
<br>
ISO used for test Vm (Bios set to OVMF / UEFI): <br>
<br>
https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/

Requirements:
-

A Raspberry Pi 4, 5 or CM4

Prepare your Raspberry Pi:
-

Install the Raspberry Pi OS image: 2025-10-01-raspios-arm64-lite.img on an SD card, NVMe drive, or USB device with enough storage for the OS.
Boot your Raspberry Pi from the prepared storage device.


Installation Procedure:

One-liner Installation (for experienced users):
-

```
sudo apt install git -y && git clone https://github.com/MHaasjes/shell-script-pve-installer-rpi.git && cd shell-script-pve-installer-rpi && sudo chmod +x pve-installer-rpi-2.3.sh && sudo ./pve-installer-rpi-2.3.sh
```


To do:
-
- Test on Raspberry pi 3 as witness Host
