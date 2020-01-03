#!/bin/sh

sudo apt install ssh -y
sudo apt install net-tools -y
sudo apt install vim -y
sudo apt install git -y
sudo apt install minicom -y
sudo apt install filezilla -y
sudo apt install samba -y
sudo apt install xinetd -y
sudo apt install tftp -y
sudo apt install tftpd -y
sudo apt install nfs-common -y
sudo apt install nfs-kernel-server -y
sudo apt install rpcbind -y
sudo apt install curl -y
sudo apt install wireshark -y
sudo apt install vsftpd -y
sudo apt install u-boot-tools -y
sudo apt install tree -y
sudo apt install dos2unix -y

# 64bit Cross-compile
sudo apt install gcc-multilib -y
sudo apt install g++-multilib -y

sudo apt install lib32z1 -y

# install vs code - code_1.29.1-1542309157_amd64.deb
# install synergy - synergy-v1.8.8-stable-Linux-i686.deb
sudo apt install synergy -y
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

# thunderbird link
ln -s ~/Downloads/.thunderbird ~/.thunderbird

# vscode link
ln -s ~/Project/.vscode ~/.vscode
ln -s ~/Project/.vscode-cpptools ~/.vscode-cpptools

# setup nfs server
echo "/home/ppdha82/Project   *(rw,sync,no_root_squash,no_all_squash)" > /etc/exports
sudo /etc/init.d/rpcbind restart
sudo /etc/init.d/nfs-kernel-server restart

# setup tftpboot
sudo mkdir /tftpboot
echo "service tftp
{
    socket_type     = dgram
    protocol        = udp
    wait            = yes
    user            = root
    server          = /usr/sbin/in.tftpd
    server_args     = -s /tftpboot
    disable         = no
    per_source      = 11
    cps             = 100 2
    flags           = IPv4
}" > /etc/xinetd.d/tftp
sudo /etc/init.d/xinetd restart

echo "write_enable=YES" > /etc/vsftpd.conf
sudo service vsftpd restart

# need to login by root
echo "[ppdha82]
comment = \"Deukhyun Park\"
path = /home/ppdha82
valid user = ppdha82
writable = yes
create mask = 0644
directory mask = 0755" > /etc/samba/smb.conf
sudo /etc/init.d/smbd restart

echo "# / was on /dev/sdb1 during installation
UUID=3478d0c5-3ac6-41df-a601-edcd3adf7609 /home/ppdha82/Downloads       ext4    defaults 0       0
# / was on /dev/sdb3 during installation
UUID=c151863a-f32f-40c2-b73f-6826521ff14a /home/ppdha82/Project         ext4    defaults 0       0
# / was on /dev/sdb3 during installation
UUID=b0a79762-4a1a-4f74-8fd8-abb8f46c72b3 /opt                          ext4    defaults 0       0" >> /etc/fstab

echo "export PATH=\"/opt/hisi-linux/x86-arm/arm-hisiv500-linux/target/bin:$PATH\"" >> /etc/profile
echo "source /etc/profile" >> /etc/bash_completion
