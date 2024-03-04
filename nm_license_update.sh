#!/bin/bash

#Author: RC
# This script is to update the NoMachine Server License on the interactive nodes if a new license is available in warewulf overlays

if [ -d /etc/NX ]
then 
NX_LOG_FILE="/var/log/czbiohub_nomachine_license_update.log" 
#redirect all output to a log file
exec >> ${NX_LOG_FILE} 2>&1
# enable debugging below 
#set -x 
#umask 0022
echo "#############################################"
echo "Checking/Updating NoMachine Server License"
date  +"%m-%d-%y|%T" 

    diff /warewulf/etc/nomachine/server.lic /usr/NX/etc/server.lic
    if [ $? -ne 0 ]
    then 
    echo "There is a difference between the our license files in warewulf and whats on the node files"
    echo "Activating new license file from warewulf"
    /etc/NX/nxserver --activate /warewulf/etc/nomachine/server.lic
    exit 0
    else
    echo "No difference between the license files"
    exit 0
    fi
echo "#############################################"
fi 


