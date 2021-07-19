#!/bin/sh

sudo apt install ssh -y
sudo apt install net-tools -y
sudo apt install vim -y
sudo apt install git -y
sudo apt install samba -y
sudo apt install nfs-common -y
sudo apt install nfs-kernel-server -y
sudo apt install rpcbind -y
sudo apt install curl -y
sudo apt install vsftpd -y
sudo apt install u-boot-tools -y
sudo apt install tree -y
sudo apt install dos2unix -y
sudo apt install bc -y

# NOVATEK ubuntu v16.04-server
sudo apt install bison -y
sudo apt install flex -y
sudo apt install device-tree-compiler -y
sudo apt install libssl-dev -y
sudo apt install liblz4-tool -y

# before ubuntu v20.04
sudo apt install xinetd -y
sudo apt install tftp -y
sudo apt install tftpd -y
# until ubuntu v20.04
sudo apt install tftpd-hpa -y

# 64bit Cross-compile
sudo apt install gcc-multilib -y
sudo apt install g++-multilib -y

sudo apt install lib32z1 -y

sudo apt install libxrandr2 -y

sudo apt install gcc -y
sudo apt install make -y
sudo apt install lib32stdc++6 -y
sudo apt install lib32z1 -y

# setup nfs server
echo "/home/ppdha82/Project   *(rw,sync,no_root_squash,no_all_squash)" > /etc/exports
sudo /etc/init.d/rpcbind restart
sudo /etc/init.d/nfs-kernel-server restart

# setup tftpboot until ubuntu v18.10
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
# setup tftpboot from ubuntu v20.04
sudo chown tftp:tftp /srv/tftp
# echo "TFTP_OPTIONS="--secure --create" >> /etc/default/tftpd-hpa
systemctl restart tftpd-hpa
systemctl status tftpd-hpa

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
