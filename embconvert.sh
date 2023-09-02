#!/usr/bin/bash
# EMB_Appliance_Convert2RHEL
#
# By Matt St. Onge
#
# MIT License ( https://opensource.org/license/mit/ )
# 



#######################################################
#
#  Variables used by the converter
# 
#  Do not forget to
#  Edit to meet your needs
#  All must be completed and accurate
#
#######################################################

# directory location where the tarball is extracted to
EMB_TOOL_PATH = ""

# path to the RHEL ISO
EMB_ISO_PATH = ""

# release version of RHEL you are moving to X.X  (examples: "9.2" "8.8" "7.9" )
MYRHELVER = "" 

# name of current OS (valid options: "CentOS" "Rocky" "Alma" )
MYCURRENTOSNAME = ""

# version number of current OS (examples: "9.2" "8.8" "7.9" )
MYCURRENTOSVER = ""

# directory location where backup data will be stored
MYEMBABCKUPDIR = ""

# log entry prefix 
EMBLOGGERPREF = "[EMB_APP_CONV2RHEL]"

# list of services/sockets to STOP prior to operations (example: "httpd.service cockpit.socket mariadb.service")
MYSVCLIST = ""



#######################################################
#
#  Functions
# 
#
#######################################################

function prepit1()
{
    
    MYOUTPUT = "$EMBLOGGERPREF Initiating RHEL conversion operations" 
    cat $MYOUTPUT
    cat $MYOUTPUT | logger
    prepit2

}


function prepit2()
{

    MYOUTPUT = "$EMBLOGGERPREF Stopping Services & Sockets" 
    cat $MYOUTPUT
    cat $MYOUTPUT | logger


}


function backitup()
{

    MYOUTPUT = "$EMBLOGGERPREF backing up critical files" 
    cat $MYOUTPUT
    cat $MYOUTPUT | logger



}

function rhelrepo1()
{

    MYOUTPUT = "$EMBLOGGERPREF Mounting ISO Image as loopback device" 
    cat $MYOUTPUT
    cat $MYOUTPUT | logger
    mkdir -p /mnt/conv2rhel
    mount -o loop $EMB_ISO_PATH /mnt/conv2rhel
    MYOUTPUT = "$EMBLOGGERPREF $(df -h | grep conv2rhel) "
    cat $MYOUTPUT
    cat $MYOUTPUT | logger

}

function newkernel()
{
    MYOUTPUT = "$EMBLOGGERPREF Installing a RHEL kernel and bootloader" 
    cat $MYOUTPUT
    cat $MYOUTPUT | logger
    # this will require modification based upon your ISO
    cd /mnt/conv2rhel/BaseOS/Packages
    MYOUTPUT = "$EMBLOGGERPREF $(pwd)" 
    cat $MYOUTPUT
    cat $MYOUTPUT | logger
    
    # force the kernel isntall
    rpm -ify kernel grub2* grubby*
    MYOUTPUT = "$(rpm -qa | grep kernel )"
    cat $MYOUTPUT
    cat $MYOUTPUT | logger


}

prepit1
