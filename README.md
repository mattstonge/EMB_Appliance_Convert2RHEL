## EMB_Appliance_Convert2RHEL
# Modular framework for converting offline Embedded Systems appliances to a defined version of RHEL
# By Matt St. Onge

# DISCLAIMER #
--------------------
You will need to customize this framework to your usecase to ensure it works for you.

test, test, test in your own lab and make it your own...
--------------------

The conversion happens in multiple steps

1) PREP PHASE
2) definition of place to store backup data
3) backup of critical configuration data
4) scanning of existing packages and repos - genration of package list
5) disabling of former repos
6) Conversion PHASE I
7) mounting new RHEL X.X loopback iso as a repo
8) forced intallation of new kernel/kernael tools/bootloader
9) reboot
10) PHASE II
11) foreced replacement of existing comparable rpms
12) reboot
13) PHASE III
14) removal of loopback repo
15) installation of partner update methodology (repo/etc)
16) update/reinstall of partner packages
17) PHASE IV
18) restore previously backed up data (if needed)
19) scripted self-tests
20) DONE

