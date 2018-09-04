#!/bin/sh
#/sbin/udhcpc &&
#mount -t nfs -o nolock -o tcp 192.168.0.108:/home/ppdha82/Project/007_ipm-hi/app/_output/hi3516cv300 /home &&
#/edvr/start.sh
ETH_DEV_eth0="eth0"
ETH_DEV_enp3s0="enp3s0"
IP_ADDR_DEV=`ifconfig ${ETH_DEV_enp3s0} | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
echo "IP_ADDR_DEV= $IP_ADDR_DEV"
IP_ADDR=${IP_ADDR_DEV}

TARGET_DIRECTORY="/home"
SRC_DIRECTORY_KEY="_output"

MODEL=$(grep DEVELOP_MODEL app/Makefile | grep -v '\$' | grep -v '\#')
echo ${MODEL}
if [[ "${MODEL}" =~ "IPC-2090" || "${MODEL}" =~ "IPC-2100" ]]; then
PLATFORM="hi3519v101"
elif [[ "${MODEL}" =~ "MON-2076" ]]; then
PLATFORM="hi3516av200"
else
PLATFORM="hi3516cv300"
fi

directory=`find -name ${SRC_DIRECTORY_KEY}`
cd ${directory}
SOURCE_DIRECTORY="$PWD"
echo "src = ${SOURCE_DIRECTORY}"

echo "mount -t nfs -o nolock -o tcp ${IP_ADDR}:${SOURCE_DIRECTORY}/${PLATFORM} ${TARGET_DIRECTORY} &&"
