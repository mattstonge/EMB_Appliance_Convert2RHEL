# EMB_Appliance_Convert2RHEL
## Modular framework for converting offline Embedded Systems appliances to a defined version of RHEL
## By Matt St. Onge

# DISCLAIMER #
--------------------
You MUST configure the variables & customize this framework to your use case (and TEST) to ensure it works for you.

## test, test, test in your own lab and make it your own...
--------------------

# The conversion happens in multiple steps

Here's a general outline...


## Prep PHASE 0
###   definition of place to store backup data
###   backup of critical configuration data
###   scanning of existing packages and repos - genration of package list
###   disabling of former repos
## Conversion PHASE I
###   mounting new RHEL X.X loopback iso as a repo
###   forced intallation of new kernel/kernael tools/bootloader
## Conversion PHASE II
###   foreced replacement of existing comparable rpms
## Cleanup & Config PHASE III
###   removal of loopback repo
###   installation of partner update methodology (repo/etc)
###   update/reinstall of partner packages
## Grand Finale PHASE IV
###   restore previously backed up data (if needed)
###   scripted self-tests
###   DONE

