#!/bin/sh
# crontab -e
#0 8-22   *   *  1-5   sh /home/ppdha82/Project/git_command.sh >> /home/ppdha82/crontab.log
#0  23    *   *  1-5   sh /home/ppdha82/Project/log_clean.sh >> /dev/null                  

LOG_PATH=/home/ppdha82/Downloads
PROJECT_PATH=/home/ppdha82/Project
GIT_PULL=('git pull')
LOG_FILE=${LOG_PATH}/log.txt
DIR_001=001_ipm-hi
DIR_002=002_ipm-hi
DIR_004=004_ipm-hi
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

