#!/bin/sh

sudo apt install ssh -y
sudo apt install net-tools -y
sudo apt install vim -y
sudo apt install git -y
sudo apt install minicom -y
# install vs code - code_1.29.1-1542309157_amd64.deb
# install synergy - synergy-v1.8.8-stable-Linux-i686.deb
# install chrome - google-chrome-stable_current_amd64.deb
sudo dpkg -S libXrandr.so.2
sudo apt-cache show libxrandr2
sudo apt install libxrandr2 -y
sudo apt install libxrandr2:i386 -y

sudo apt install fcitx-hangul -y
sudo apt install gcc -y
sudo apt install make -y
sudo apt install lib32stdc++6 -y
sudo apt install lib32z1 -y

# need to login by root
echo "# / was on /dev/sdb1 during installation
UUID=3478d0c5-3ac6-41df-a601-edcd3adf7609 /home/ppdha82/Downloads       ext4    defaults 0       0
# / was on /dev/sdb3 during installation
UUID=c151863a-f32f-40c2-b73f-6826521ff14a /home/ppdha82/Project         ext4    defaults 0       0
# / was on /dev/sdb3 during installation
UUID=b0a79762-4a1a-4f74-8fd8-abb8f46c72b3 /opt                          ext4    defaults 0       0" >> /etc/fstab

echo "export PATH=\"/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin:$PATH\"" >> /etc/profile
echo "source /etc/profile" >> /etc/bash_completion
