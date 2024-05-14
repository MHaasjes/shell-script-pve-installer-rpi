# Proxmox Virtualisation on Raspbeerry Pi 4 and 5

Proxmox Auto Installer for Raspbeerry Pi 4 and 5. 

----------------------
Installation Procedure
----------------------

At first, you will have to install git on your system.<br>

```
sudo apt install git -y
```
<br><br>Once git is installed, you are ready to clone my script!<br>

```
git clone https://github.com/MHaasjes/<xxxxxxxxxx>.git
```
<br><br>
Then, enter to the directory and change the permission.<br><br>
```
cd proxmox

chmod +x pve-installer-rpi-xx-xx-xxxx.sh

./pve-installer-rpi-xx-xx-xxxx.sh
```
<br><br>
At the end, please visit your web browser for ``https://your_ip_address:8006`` further configuration.<br>

You will be required for username and password authentication which is same as your ssh username and password.
