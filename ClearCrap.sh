###################################################################
#                                                                 #
# ClearCrap.sh                                                    #
#                                                                 #
# This script will remove all temporary files and directories     #
# from an iOS device.                                             #
#                                                                 #
# DIRECTIONS for use                                              #
#                                                                 #
# 1) Run this script.                                             #
# 2) Pray                                                         #
#                                                                 #
###################################################################

# Ensure the user is logged in as root.
if [ "$EUID" -ne 0 ]; then
	echo "ERROR!!!!!  You MUST be logged in as root.  Please"
	echo "logoff and then re-login as root." 
	exit
fi

# Delete contents of these directories.
rm -rf /tmp/* 
rm -rf /var/tmp/*
rm -rf /var/db/analyticsd/*
rm -rf /var/db/diagnostics/*
rm -rf /var/installd/Library/Logs/*
rm -f  /var/installd/Library/Preferences/*.plist.*
rm -rf /var/log/*
rm -rf /var/logs/*
rm -rf /var/mobile/Downloads/Cydia/*
rm -rf /var/mobile/Library/.Trash
rm -rf /var/mobile/Library/.Trash.metadata
rm -rf /var/mobile/Library/Caches/*
rm -rf /var/mobile/Library/Cookies/*
rm -rf /var/mobile/Library/Filza/.Trash/*
rm -rf /var/mobile/Library/Filza/.Trash.metadata/*
rm -rf /var/mobile/Library/Logs/*
rm -rf /var/mobile/Library/Logs/CrashReporter/*.*
rm -f  /var/mobile/Library/Preferences/com.apple.*.plist.*
rm -f  /var/networkd/Library/Preferences/*.plist.*
rm -rf /var/root/Library/Caches/*
rm -rf /var/wireless/Library/Logs/*

# Delete these useless files.
rm -f  /var/mobile/.bash_history
rm -f  /var/root/.bash_history
rm -f  /var/mobile/MobileSoftwareUpdate/last_update_result.plist
rm -f  /var/mobile/MobileSoftwareUpdate/restore.log
rm -rf /var/mobile/MobileSoftwareUpdate/mnt1
rm -f  /var/MobileSoftwareUpdate/restore.log

# This commands shows all of the non-Apple preference files to cleanup.
cd /private/var/mobile/Library/Preferences
ls -al -I "com.apple.*.plist" -I "com.apple*"

