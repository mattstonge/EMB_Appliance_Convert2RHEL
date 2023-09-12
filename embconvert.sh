#!/usr/bin/bash
# EMB_Appliance_Convert2RHEL
#
# By Matt St. Onge
#
# MIT License ( https://opensource.org/license/mit/ )
# 

# name of my config file
EMB_CONF_FILE = "myappX.conf"



#######################################################
#
#  Functions
# 
#
#######################################################

function prepit1()
{
  source ./$EMB_CONF_FILE 
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
