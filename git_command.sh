#!/bin/sh
# crontab -e
#0 8-22   *   *  1-5   sh /home/ppdha82/Project/LinuxProgram/git_command.sh >> /home/ppdha82/Downloads/git/log.txt
#0  23    *   *  1-5   sh /home/ppdha82/Project/LinuxProgram/log_clean.sh >> /dev/null

LOG_PATH=/home/ppdha82/Downloads/git
PROJECT_PATH=/home/ppdha82/Project
GIT_PULL=('git pull origin master')
GIT_PULL_ATM=('git pull origin sdk-v1.0.4.0')
LOG_FILE=${LOG_PATH}/log.txt
DIR_001=001_ipm-hi_VPN_build
DIR_002=002_ipm-hi_TTA
DIR_003=003_ipm-hi_VPN_build
DIR_004=004_ipm-hi
DIR_005=005_ipm-hi
DIR_006=006_ipm-hi
DIR_007=007_ipm-hi
DIR_008=008_ipm-hi
DIR_009=009_ipm-hi
DIR_010=010_ipm-hi
DIR_011=011_ipm-hi
DIR_012=012_ipm-hi
DIR_013=013_ipm-hi
DIR_014=014_ipm-hi
DIR_015=015_ipm-hi

DATE_LOG=`date`"\n"

function git_pull() {
	echo ${PWD} >> ${LOG_FILE}
	${GIT_PULL} >> ${LOG_FILE}
	echo -e ${DATE_LOG} >> ${LOG_FILE}
}

function git_pull_atm() {
	echo ${PWD} >> ${LOG_FILE}
	${GIT_PULL_ATM} >> ${LOG_FILE}
	echo -e ${DATE_LOG} >> ${LOG_FILE}
}

cd ${PROJECT_PATH}/${DIR_001}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_002}
git_pull

cd ${PROJECT_PATH}/${DIR_003}
git_pull

cd ${PROJECT_PATH}/${DIR_004}
git_pull

cd ${PROJECT_PATH}/${DIR_005}
git_pull

cd ${PROJECT_PATH}/${DIR_006}
git_pull

cd ${PROJECT_PATH}/${DIR_007}
git_pull

cd ${PROJECT_PATH}/${DIR_008}
git_pull

cd ${PROJECT_PATH}/${DIR_009}
git_pull

cd ${PROJECT_PATH}/${DIR_010}
git_pull

cd ${PROJECT_PATH}/${DIR_011}
git_pull

cd ${PROJECT_PATH}/${DIR_012}
git_pull

cd ${PROJECT_PATH}/${DIR_013}
git_pull

cd ${PROJECT_PATH}/${DIR_014}
git_pull

cd ${PROJECT_PATH}/${DIR_014}
git_pull
