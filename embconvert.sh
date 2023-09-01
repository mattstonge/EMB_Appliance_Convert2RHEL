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

