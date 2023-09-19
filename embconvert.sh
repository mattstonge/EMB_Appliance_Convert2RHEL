#!/usr/bin/bash
# EMB_Appliance_Convert2RHEL
#
# By Matt St. Onge
#
# MIT License ( https://opensource.org/license/mit/ )
# 

# name of my config file
EMB_CONF_FILE=myappX.conf



#######################################################
#
#  Functions
# 
#
#######################################################

function prepit1()
{
  clear
  echo "###################################"
  echo "# Embedded Appliance Convert2RHEL #"
  echo "# A Framework for Positive Change #"
	echo "#                                 #"
	echo "# Customization to your           #"
	echo "# Environment is Required...      #"
  echo "###################################"
  echo " "
  echo " "
  echo "  MIT License ( https://opensource.org/license/mit/ )"
  echo " "
  echo " "
  echo "...reading your configurtion file: "
	echo " $EMB_CONF_FILE "
	echo " "
	echo " "

  source $EMB_CONF_FILE
  MYOUTPUT="$EMBLOGGERPREF Initiating RHEL conversion operations" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
  #prepit2

}


function prepit2()
{

  MYOUTPUT="$EMBLOGGERPREF Stopping Services & Sockets" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger

  for MYSVC in $MYSVCLIST; do
	  echo "Stopping $MYSVC"
	  echo "$EMBLOGGERPREF  Stopping $MYSVC" | logger
	  systemctl stop $MYSVC
  done


}


function backitup()
{

  MYOUTPUT="$EMBLOGGERPREF backing up critical files" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger



}

function rhelrepo1()
{

  MYOUTPUT="$EMBLOGGERPREF Mounting ISO Image as loopback device" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
  mkdir -p /mnt/conv2rhel
  mount -o loop $EMB_ISO_PATH /mnt/conv2rhel
  MYOUTPUT="$EMBLOGGERPREF $(df -h | grep conv2rhel) "
  echo $MYOUTPUT
  echo $MYOUTPUT | logger

}

function newkernel()
{
  MYOUTPUT="$EMBLOGGERPREF Installing a RHEL kernel and bootloader" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
  # this will require modification based upon your ISO
  cd /mnt/conv2rhel/BaseOS/Packages
  MYOUTPUT="$EMBLOGGERPREF $(pwd)" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
   
  # force the kernel isntall
  rpm -ify kernel grub2* grubby*
  MYOUTPUT="$(rpm -qa | grep kernel )"
  echo $MYOUTPUT
  echo $MYOUTPUT | logger


}

prepit1
