#!/bin/sh

print=echo
#print_dbg=echo
#$print_dbg "merong"

EXECUTABLE_FILE="emount.sh"
print "#!/bin/sh" > ${EXECUTABLE_FILE}
print "/sbin/udhcpc &&" >> ${EXECUTABLE_FILE}

ETH_DEV_eth0="eth0"
ETH_DEV_enp3s0="enp3s0"
IP_ADDR_DEV=`ifconfig ${ETH_DEV_enp3s0} | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
#print_dbg "IP_ADDR_DEV= $IP_ADDR_DEV"
IP_ADDR=${IP_ADDR_DEV}

TARGET_DIRECTORY="/home"
KEY_DIRECTORY="_output"

MODEL=$(grep DEVELOP_MODEL app/Makefile | grep -v '\$' | grep -v '\#')
#print_dbg ${MODEL}
if [[ "${MODEL}" =~ "IPC-2090" || "${MODEL}" =~ "IPC-2100" || "${MODEL}" =~ "IPC-8080" ]]; then
	PLATFORM="hi3519v101"
elif [[ "${MODEL}" =~ "MON-2076" ]]; then
	PLATFORM="hi3516av200"
else
	PLATFORM="hi3516cv300"
fi

directory=`find -name ${KEY_DIRECTORY}`
cd ${directory}
SOURCE_DIRECTORY="$PWD"
cd -
#print_dbg "src = ${SOURCE_DIRECTORY}"


print "mount -t nfs -o nolock -o tcp ${IP_ADDR}:${SOURCE_DIRECTORY}/${PLATFORM} ${TARGET_DIRECTORY} &&" >> ${EXECUTABLE_FILE}
print "edvr/start.sh" >> ${EXECUTABLE_FILE}
#print_dbg "directory = ${SOURCE_DIRECTORY}/${PLATFORM}"
cp ${EXECUTABLE_FILE} ${SOURCE_DIRECTORY}/${PLATFORM}
