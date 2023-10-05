#!/usr/bin/bash
# EMB_Appliance_Convert2RHEL
#
# By Matt St. Onge
#
# MIT License ( https://opensource.org/license/mit/ )
# 
# version 1.0
# #####################################################


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
	
	date '+%T'
  source $EMB_CONF_FILE
  MYOUTPUT="$EMBLOGGERPREF Initiating RHEL conversion operations" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
  prepit2

}

function prepit2()
{

  # tests to ensure original OS is as specified
	# any failure results in an EXIT from this tool
  
  date '%T'
	MYOUTPUT="$EMBLOGGERPREF Validating this system"
	echo $MYOUTPUT
	echo $MYOUTPUT | logger
  
  case $MYCURRENTOSNAME in
	  "Rocky")
		  rockytests
			;;

		"Alma")
      almatests
			;;

	  "CentOS")
		  centostests
			;;

		*) 
		  MYOUTPUT="OS validation has failed - EXITING!!!"
			exit 0
			;;
  esac


}

function rockytests()
{
  # tests to validate OS is Rocky Linux and its version

	if [ -f /etc/os-release ]
	then
	  source /etc/os-release
		TESTOS="${ROCKY_SUPPORT_PRODUCT}"
    TESTVER="${ROCKY_SUPPORT_PRODUCT_VERSION}"
  fi

	if [ "$TESTOS" != "Rocky Linux" ]
	then 
	  MYOUTPUT="$EMBLOGGERPREF OS Settings are not correct - reconfigure then re-run this tool."
		echo $MYOUTPUT
		echo $MYOUTPUT | logger
	  exit 1
	fi

  if [ "$TESTVER" != "$MYCUURENTOSVER" ]
	then
	  MYOUTPUT="$EMBLOGGERPREF OS Settings are not correct - reconfigure then re-run this tool."
		echo $MYOUTPUT
		echo $MYOUTPUT | logger
		exit 1
	fi

  prepit3

}

function centostests()
{

	if [ -f /etc/os-release ]
  then
    source /etc/os-release
		TESTOS="${NAME}"
		TESTVER="${VERSION_ID}"
	fi

	 if [ "$TESTOS" != "CentOS Linux" ]
   then
     MYOUTPUT="$EMBLOGGERPREF OS Settings are not correct - reconfigure then re-run this tool."
     echo $MYOUTPUT
     echo $MYOUTPUT | logger
     exit 1
   fi

   if [ "$TESTVER" != "$MYCUURENTOSVER" ]
   then
     MYOUTPUT="$EMBLOGGERPREF OS Settings are not correct - reconfigure then re-run this tool."
     echo $MYOUTPUT
     echo $MYOUTPUT | logger
     exit 1
   fi

   prepit3

}

function almatests()
{

  if [ -f /etc/almalinux-release ]
	then
	  source /etc/almalinux-release
		TESTOS="${NAME}"
		TESTVER="${VERSION_ID}"
  fi

  if [ "$TESTOS" != "AlmaLinux" ]
	then
    MYOUTPUT="$EMBLOGGERPREF OS Settings are not correct - reconfigure then re-run this tool."
    echo $MYOUTPUT
    echo $MYOUTPUT | logger
  	exit 1
	fi

  if [ "$TESTVER" != "$MYCURRENTOSVER" ]
	then
     MYOUTPUT="$EMBLOGGERPREF OS Settings are not correct - reconfigure then re-run this tool."
     echo $MYOUTPUT
     echo $MYOUTPUT | logger
		 exit 1
	fi

	prepit3

}


function prepit3()
{
	
	pwd
	date '+%T'
  MYOUTPUT="$EMBLOGGERPREF Stopping Services & Sockets" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
  
	#determine system status - active services, sockets, etc.
  
	systemctl get-default > mydefault.dat
	systemctl list-units --type=service --state=active --quiet | cut -d ' ' -f 3 > services.dat
	systemctl list-units --type=socket --state=active --quiet | cut -d ' ' -f 3 > sockets.dat
	
	# compare defined to actual



	# stop services & sockets
  for MYSVC in $MYSVCLIST; do
		date '+%T'
	  echo "$EMBLOGGERPREF  Stopping $MYSVC" | logger
	  echo "Stopping $MYSVC"
	  systemctl stop $MYSVC
  done


}


function backitup()
{

  # create a backup of /etc
  
	date '+%T'
  MYOUTPUT="$EMBLOGGERPREF backing up critical files" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger

  tar cvhf $MYEMBBACKUPDIR/mybackup.tar /etc

  myoldrepos

}


function myoldrepos()
{

  # determine existing enabled dnf/yum repositories and disable them
  
	date '+%T'
	MYOUTPUT="$EMBLOGGERPREF Determining active YUM/DNF repositories..."
	echo $MYOUTPUT
	echo $MYOUTPUT | logger

	dnf repolist
  dnf repolist | logger

	MYOUTPUT="$EMBLOGGERPREF Disabling all active YUM/DNF repositories..."
	echo $MYOUTPUT
	echo $MYOUTPUT | logger

	dnf config-manager --disable *

	rhelrepo1

}


function rhelrepo1()
{
	date '+%T'
  MYOUTPUT="$EMBLOGGERPREF Mounting ISO Image as loopback device" 
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
  mkdir -p /mnt/conv2rhel
  mount -o loop $EMB_ISO_PATH /mnt/conv2rhel
  MYOUTPUT="$EMBLOGGERPREF $(df -h | grep conv2rhel) "
	date '+%T'
  echo $MYOUTPUT
  echo $MYOUTPUT | logger

}

function newkernel()
{
  MYOUTPUT="$EMBLOGGERPREF Installing a RHEL kernel and bootloader" 
	date '+%T'
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
  # this will require modification based upon your ISO
  cd /mnt/conv2rhel/BaseOS/Packages
  MYOUTPUT="$EMBLOGGERPREF $(pwd)" 
	date '+%T'
  echo $MYOUTPUT
  echo $MYOUTPUT | logger
   
  # force the kernel isntall
  rpm -ify kernel grub2* grubby*
  MYOUTPUT="$(rpm -qa | grep kernel )"
	date '+%T'
  echo $MYOUTPUT
  echo $MYOUTPUT | logger


}

prepit1
