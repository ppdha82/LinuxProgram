#!/bin/sh
# crontab -e
#0 8-22   *   *  1-5   sh /home/ppdha82/Project/LinuxProgram/git_command.sh >> /home/ppdha82/Downloads/git/log.txt
#0  23    *   *  1-5   sh /home/ppdha82/Project/LinuxProgram/log_clean.sh >> /dev/null

LOG_PATH=/home/ppdha82/Downloads/git
PROJECT_PATH=/home/ppdha82/Project
GIT_PULL=('git pull origin master')
LOG_FILE=${LOG_PATH}/log.txt
DIR_001=001_ipm-hi_for_generating_firmware
DIR_002=002_ipm-hi_TTA
DIR_004=004_ipm-hi_AF_module
DIR_005=005_ipm-hi
DIR_006=006_ipm-hi
DIR_007=007_ipm-hi_AF2812
DIR_008=008_ipm-hi
DIR_009=009_ipm-hi_for_generating_firmware
DIR_010=010_ipm-hi_AF2808

DATE_LOG=`date`"\n"

cd ${PROJECT_PATH}/${DIR_001}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_002}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_004}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_005}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_006}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_007}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_008}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_009}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

cd ${PROJECT_PATH}/${DIR_010}
echo ${PWD} >> ${LOG_FILE}
${GIT_PULL} >> ${LOG_FILE}
echo -e ${DATE_LOG} >> ${LOG_FILE}

