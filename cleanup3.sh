###################################################################
#                                                                 #
# Cleanup3.sh                                                     #
#                                                                 #
# This script will remove all traces of the IOS13.x               #
# jailbreak from an iOS device.                                   #
#                                                                 #
# USAGE INSTRUCTIONS                                              #
#                                                                 #
# 1) These usage instructions and the actual running of this      #
#    script MUST be run as root.                                  #
#                                                                 #
# 2) An /uninstall directory will be created and several          #
#    utilities will be copied into this directory.                #
#                                                                 #
# 3) Using an FTP client copy this script into the root           #
#    directory.   Using Putty run the command:                    #
#    chmod 755 ./script2.sh                                       #
#                                                                 #
# 4) Run the following command to ensure the correct              #
#    Dos->unix characters are converted:                          #
#    sed -i 's/\r$//' ./cleanup3.sh                               #
#                                                                 #
# 5) Manual Deletions:                                            #
#    You will need to look through some directories on your own   #
#    to find some more files and directories to delete.  These    #
#    are listed below and need to be manually added to the        #
#    sections just below.                                         #
#        /var/containers                                          #
#        /var/mobile/Containers/Data                              #
#        /var/mobile/Containers/Shared                            #
#        /var/mobile/Library/SpringBoard/ApplicationShortcuts     #
#        /var/mobile/Library/SpringBoard/PushStore                # 
#                                                                 #
# 99) A few notes:                                                #
#     Apple Watch Backups are stored here and can be deleted.     #
#          /private/var/mobile/Library/NanoBackup                 #
#                                                                 #
#     Battery logs are stored here:                               #
#          /var/containers/Shared/SystemGroup/?!?!?!              #
#                search for Powerlog                              #
#                                                                 #
#     Commands to disable launch daemons in jailbroken state:     #
#         launchctl unload /System/Library/LaunchDaemons/??.plist #
#                                                                 #
#     Mail.app stores mail data here:                             #
#         /private/var/mobile/Library/Mail                        #
#                                                                 #
#     Text messages are stored here:                              #
#         /private/var/mobile/Library/SMS                         #
#                                                                 # 
#     Battery Power Log details are stored here:                  #
#       /var/containers/Shared/SystemGroup/BCFADB1E-BB04-4C7E-A857-D1BBA0961C91/Library/BatteryLife
# rm -rf /var/containers/Shared/SystemGroup/BCFADB1E-BB04-4C7E-A857-D1BBA0961C91/Library/BatteryLife/Archives/*
# rm -rf /var/containers/Shared/SystemGroup/BCFADB1E-BB04-4C7E-A857-D1BBA0961C91/Library/BatteryLife/Quarantine/*
# rm -rf /var/containers/Shared/SystemGroup/BCFADB1E-BB04-4C7E-A857-D1BBA0961C91/Library/BatteryLife/*

#                                                                 # 
###################################################################

# Ensure the user is logged in as root.
if [ "$EUID" -ne 0 ]; then
	echo "ERROR!!!!!  You MUST be logged in as root.  Please"
	echo "logoff and then re-login as root." 
	exit
fi

# Prompt user to confirm they want to continue.
asksure() {
echo "WARNING!!!!  This script will attempt to remove the Electra/Unc0ver jailbreak"
echo "from this device.  Please think long and hard before continuing since it"
echo "could cause you to loose your jailbreak!!!"
echo ""
echo "WARNING!!!!! Be sure you fill in the section just below to delete the"
echo "directories related to the bundles.  These will need to be deleted"
echo "for completeness."
echo ""
echo "Please press E to continue with this script, or N to exit the script."
while read -r -n 1 -s answer; do
  if [[ $answer = [EeNn] ]]; then
    [[ $answer = [Ee] ]] && retval=0
    [[ $answer = [Nn] ]] && retval=1
    break
  fi
done
return $retval
}
if asksure; then
  echo "Continuing..."
else
  echo "Exited..."
fi

# Second confirmation to Prompt user to confirm they want to continue.
asksure() {
echo "Are you REALLY REALLY sure you wish to continue?"
echo ""
echo "Please press U to continue with this script, or N to exit the script."
while read -r -n 1 -s answer; do
  if [[ $answer = [UuNn] ]]; then
    [[ $answer = [Uu] ]] && retval=0
    [[ $answer = [Nn] ]] && retval=1
    break
  fi
done
return $retval
}
if asksure; then
  echo "Continuing..please pray...."
else
  echo "Exited..."
fi

# Ensure Cydia is not running.
killall Cydia

########################################################################
#                                                                      #
# Copy several command line utilities from their source location into  #
# the uninstall directory so that they may be referenced to later.     #
#                                                                      #
########################################################################
rm -rf /uninstall
mkdir /uninstall
cp /bin/rm          /uninstall
cp /bin/rmdir       /uninstall
cp /bin/touch       /uninstall
cp /usr/bin/find    /uninstall
cp /usr/bin/snappy  /uninstall
cp /usr/bin/uicache /uninstall
chmod 755 /uninstall/find
chmod 755 /uninstall/rm
chmod 755 /uninstall/rmdir
chmod 755 /uninstall/snappy
chmod 755 /uninstall/touch
chmod 755 /uninstall/uicache

########################################################################
#                                                                      #
# TODO!!                                                               #
# Using Filza, you must scan through the directories below and         #
# identify those bundle's that pertain to Cydia apps and impactor      #
# apps and include them in the delete statements below.                #
#                                                                      #
########################################################################

# /var/mobile/Containers/Data/Application (Appears to be app store apps, impactor apps and Cydia apps.)
rm -rf /var/mobile/Containers/Data/Application/BC9C6E3F-D707-4876-9C61-280BE7EA58B6 # CheckRa!n
rm -rf /var/mobile/Containers/Data/Application/C2BE1A07-4C1D-4DFE-B658-88C39E6AF0AD # Flex
rm -rf /var/mobile/Containers/Data/Application/1BD7FCE9-C280-4AF0-A965-64DC4DBCB74B # Cydia
rm -rf /var/mobile/Containers/Data/Application/404816C6-9123-4CEE-BB9F-ECE51CDB316A # Filza
rm -rf /var/mobile/Containers/Data/Application/9A27EDC5-D4AC-43CD-9D11-A5E6EBD3F210 # Sileo
rm -rf /var/mobile/Containers/Data/Application/8FDEAD27-158A-4098-9AF6-30DA57CC7C22 # Sileo 2

########################################################################
#                                                                      #
# Delete the directories that aren't part of a model .ipsw file.       #
#                                                                      #
########################################################################

# Delete directories off of the / folder.
rm -rf /.fseventsd/*
rm -rf /cores/*
rm -rf /Developer/*
rm -rf /lib/*
rm -rf /mnt/*
rm -rf /tmp/* 

# Delete directories off of the /etc folder.
rm -rf /etc/alternatives
rm -rf /etc/apt
rm -rf /etc/default
rm -rf /etc/ppp
rm -rf /etc/profile.d
rm -rf /etc/rc.d
rm -rf /etc/ssh
rm -rf /etc/ssl

# Delete directories off of the /Library folder.
rm -rf /Library/dpkg
rm -rf /Library/Frameworks/*
rm -rf /Library/LaunchDaemons/*
rm -rf /Library/MobileSubstrate
rm -rf /Library/PreferenceBundles
rm -rf /Library/PreferenceLoader
rm -rf /Library/Switches
rm -rf /Library/Themes
rm -rf /Library/unlimapps_tweak_resources

# Delete directories off of the /usr folder.
rm -rf /usr/etc
rm -rf /usr/games
rm -rf /usr/include/*
rm -rf /usr/lib/bash
rm -rf /usr/lib/log/*
rm -rf /usr/lib/pkgconfig
rm -rf /usr/lib/tweaks
rm -rf /usr/local/bin
rm -rf /usr/local/lib/*
rm -rf /usr/share/aclocal
rm -rf /usr/share/man

# Delete directories off of the /var folder.
rm -rf /var/installd/Library/Logs/*
rm -rf /var/lib/*
rm -rf /var/mobile/Library/Caches/*
rm -rf /var/mobile/Library/Cookies/*
rm -rf /var/mobile/Library/Filza/.Trash/*
rm -rf /var/mobile/Library/Filza/.Trash.metadata/*
rm -rf /var/mobile/Library/NanoBackup/*
rm -rf /var/mobile/Library/WebKit/*
rm -rf /var/mobile/Library/Voicemail/* 
rm -rf /var/mobile/MobileSoftwareUpdate/mnt1
rm -rf /var/root/Application\ Support
rm -rf /var/root/Library/Caches/*
rm -rf /var/ua_tweak_resources
rm -rf /var/unlimapps_tweak_resources

# Delete misc files that don't belong to any tweak.
rm -f  /.bootstrapped
rm -f  /bin/launchctl
rm -f  /private/var/mobile/.bash_history
rm -f  /private/var/mobile/Library/Preferences/anondev.LocalIAPStore.plist
rm -f  /private/var/mobile/Library/Preferences/com.johncoates.Flex.plist
rm -f  /private/var/mobile/Library/Preferences/com.saurik.Cydia.plist
rm -f  /private/var/mobile/Library/Preferences/com.tigisoftware.Filza.plist
rm -f  /private/var/mobile/Library/Preferences/org.coolstar.SileoStore.plist
rm -f  /private/var/root/.bash_history
rm -f  /private/var/tmp/jailbreakd.pid
rm -f  /private/var/checkra1n.dmg
rm -f  /private/var/dropbear_rsa_host_key
rm -f  /private/var/jb
rm -f  /tmp/cydia.log
rm -f  /tmp/substrated*.log
rm -f  /usr/bin/debugserver
rm -f  /usr/bin/spawn
rm -f  /usr/lib/libjailbreak.dylib
rm -f  /usr/lib/pspawn_hook.dylib
rm -f  /usr/libexec/ldid
rm -f  /usr/libexec/substrate
rm -f  /usr/libexec/substrated
rm -f  /usr/sbin/repquota

# Delete misc folders that don't belong to any tweak.
rm -rf /Library/Application\ Support/SpeedOptimize
rm -rf /usr/share/bash-completion
rm -rf /usr/share/dict
rm -rf /usr/share/doc
rm -rf /usr/share/dpkg
rm -rf /usr/share/gnupg
rm -rf /var/backups
rm -rf /var/cache
rm -rf /var/db/stash
rm -rf /var/db/analyticsd/*.ips
rm -rf /var/lib/misc
rm -rf /var/local/*
rm -rf /var/lock/*
rm -rf /var/log/*
rm -rf /var/logs/*
rm -rf /var/mobile/Downloads/com.apple.AirDrop
rm -rf /var/mobile/Downloads/Cydia
rm -rf /var/mobile/Library/Cydia
rm -rf /var/mobile/Library/Logs/*
rm -rf /var/root/Application\ Support
rm -rf /var/spool/*
rm -rf /var/stash
rm -rf /var/tmp/*
rm -rf /var/wireless/Library/Logs/*

########################################################################
#                                                                      #
# Begin custom tweak uninstall area.                                   #
#                                                                      #
########################################################################

# Cleanup files from the "APT" package.
rm -f  /usr/bin/apt
rm -f  /usr/bin/apt-cache
rm -f  /usr/bin/apt-cdrom
rm -f  /usr/bin/apt-config
rm -f  /usr/bin/apt-extracttemplates
rm -f  /usr/bin/apt-ftparchive
rm -f  /usr/bin/apt-get
rm -f  /usr/bin/apt-mark
rm -f  /usr/bin/apt-sortpkgs

# Cleanup files from the "APT (apt-key)" package.
rm -f  /usr/bin/apt-key

# Cleanup files from the "APT (lib)" package. (TODO)
rm -rf /etc/apt/apt.conf.d
rm -rf /etc/apt/auth.conf.d
rm -rf /etc/apt/preferences.d
rm -rf /etc/apt/sources.list.d
rm -rf /etc/apt/trusted.gpg.d
rm -rf /usr/lib/apt
rm -f  /usr/lib/apt
rm -f  /usr/lib/libapt-inst.2.0.0.dylib
rm -f  /usr/lib/libapt-inst.2.0.dylib
rm -f  /usr/lib/libapt-private.0.0.0.dylib
rm -f  /usr/lib/libapt-private.0.0.dylib
rm -rf /usr/libexec/apt
rm -rf /usr/libexec/dpkg
rm -rf /usr/share/doc
rm -rf /var/cache/apt
rm -rf /var/lib/apt
rm -rf /var/log/apt

# Cleanup files from the "APT (libapt-pkg)" package. 
rm -f  /usr/lib/libapt-pkg.5.0.2.dylib
rm -f  /usr/lib/libapt-pkg.5.0.dylib

# Cleanup files from the "APT (1.4 Traditional)" package. 
# nothing

# Cleanup files from the "Assuan" package.
rm -f  /usr/bin/libassuan-config
rm -f  /usr/include/assuan.h
rm -f  /usr/lib/libassuan.0.dylib
rm -f  /usr/lib/libassuan.dylib
rm -f  /usr/lib/libassuan.la
rm -f  /usr/share/aclocal/libassuan.m4

# Cleanup files from the "Berkley DB" package.
rm -f /usr/bin/db_archive
rm -f /usr/bin/db_checkpoint
rm -f /usr/bin/db_convert
rm -f /usr/bin/db_deadlock
rm -f /usr/bin/db_dump
rm -f /usr/bin/db_hotbackup
rm -f /usr/bin/db_load
rm -f /usr/bin/db_log_verify
rm -f /usr/bin/db_printlog
rm -f /usr/bin/db_recover
rm -f /usr/bin/db_replicate
rm -f /usr/bin/db_stat
rm -f /usr/bin/db_tuner
rm -f /usr/bin/db_upgrade
rm -f /usr/bin/db_verify
rm -f /usr/include/db.h
rm -f /usr/include/db_cxx.h
rm -f /usr/lib/libdb-6.2.dylib
rm -f /usr/lib/libdb-6.dylib
rm -f /usr/lib/libdb.dylib

# Cleanup files from the "Bigboss Icon Set" package.
rm -rf /usr/share/bigboss/icons/bigboss.png
rm -rf /usr/share/bigboss/icons/planetiphones.png
rm -rf /usr/share/bigboss/icons/touchrev.png
rm -rf /usr/share/bigboss

# Cleanup files from the "Bourne-Again SHell" package.
rm -f  /Library/dpkg/info/bash.list
rm -f  /Library/dpkg/info/bash.md5sums
rm -f  /bin/bash
rm -f  /bin/sh
rm -f  /usr/bin/bashbug
rm -rf /usr/include/bash/include
rm -rf /usr/include/bash
rm -rf /usr/lib/bash
rm -r  /usr/lib/pkgconfig/bash.pc

# Cleanup files from the bzip2 package.
rm -f /bin/bunzip2
rm -f /bin/bzcat
rm -f /bin/bzip2
rm -f /bin/bzip2recover

# Cleanup files from the "CACerts" package.
rm -f  /etc/profile.d/cacerts.bootstrap.sh
rm -f  /etc/ssl/certs/cacert.pem
rm -f  /usr/lib/ssl/cert.pem
rm -f  /usr/lib/ssl/certs
rm -rf /usr/lib/ssl
rm -f  /usr/local/bin/curl
rm -f  /usr/local/bin/wget

# Cleanup files from the "Core Utilities" package.
rm -f  /etc/profile.d/coreutils.h
rm -f  /usr/bin/[
rm -f  /usr/bin/b2sum
rm -f  /usr/bin/base32
rm -f  /usr/bin/base64
rm -f  /usr/bin/basename
rm -f  /usr/bin/basenc
rm -f  /usr/bin/chcon
rm -f  /usr/bin/chown
rm -f  /usr/bin/cksum
rm -f  /usr/bin/comm
rm -f  /usr/bin/csplit
rm -f  /usr/bin/cut
rm -f  /usr/bin/dircolors
rm -f  /usr/bin/du
rm -f  /usr/bin/env
rm -f  /usr/bin/expand
rm -f  /usr/bin/expr
rm -f  /usr/bin/factor
rm -f  /usr/bin/fmt
rm -f  /usr/bin/fold
rm -f  /usr/bin/folders
rm -f  /usr/bin/groups
rm -f  /usr/bin/head
rm -f  /usr/bin/hostid
rm -f  /usr/bin/id
rm -f  /usr/bin/install
rm -f  /usr/bin/join
rm -f  /usr/bin/link
rm -f  /usr/bin/logname
rm -f  /usr/bin/md5sum
rm -f  /usr/bin/mkfifo
rm -f  /usr/bin/mktemp
rm -f  /usr/bin/nice
rm -f  /usr/bin/nl
rm -f  /usr/bin/nohup
rm -f  /usr/bin/nproc
rm -f  /usr/bin/numfmt
rm -f  /usr/bin/od
rm -f  /usr/bin/paste
rm -f  /usr/bin/pathchk
rm -f  /usr/bin/pinky
rm -f  /usr/bin/pr
rm -f  /usr/bin/printenv
rm -f  /usr/bin/printf
rm -f  /usr/bin/ptf
rm -f  /usr/bin/ptx
rm -f  /usr/bin/realpath
rm -f  /usr/bin/runcon
rm -f  /usr/bin/seq
rm -f  /usr/bin/sha1sum
rm -f  /usr/bin/sha224sum
rm -f  /usr/bin/sha256sum
rm -f  /usr/bin/sha384sum
rm -f  /usr/bin/sha512sum
rm -f  /usr/bin/shred
rm -f  /usr/bin/shuf
rm -f  /usr/bin/sort
rm -f  /usr/bin/split
rm -f  /usr/bin/stat
rm -f  /usr/bin/statoverride
rm -f  /usr/bin/stdbuf
rm -f  /usr/bin/sum
rm -f  /usr/bin/sync
rm -f  /usr/bin/tac
rm -f  /usr/bin/tail
rm -f  /usr/bin/tee
rm -f  /usr/bin/test
rm -f  /usr/bin/timeout
rm -f  /usr/bin/tr
rm -f  /usr/bin/truncate
rm -f  /usr/bin/tsort
rm -f  /usr/bin/tty
rm -f  /usr/bin/unexpand
rm -f  /usr/bin/uniq
rm -f  /usr/bin/unlink
rm -f  /usr/bin/uptime
rm -f  /usr/bin/users
rm -f  /usr/bin/wc
rm -f  /usr/bin/who
rm -f  /usr/bin/whoami
rm -f  /usr/bin/yes
rm -f  /usr/lib/coreutils
rm -rf /usr/libexec/coreutils
rm -f  /usr/sbin/chown
rm -f  /usr/sbin/chroot

# Cleanup files from the "Core Utilities (/bin)" package.
rm -f /bin/cat
rm -f /bin/chgrp
rm -f /bin/chmod
rm -f /bin/chown
rm -f /bin/cp
rm -f /bin/date
rm -f /bin/dd
rm -f /bin/dir
rm -f /bin/echo
rm -f /bin/false
rm -f /bin/kill
rm -f /bin/ln
rm -f /bin/ls
rm -f /bin/mkdir
rm -f /bin/mknod
rm -f /bin/mktemp
rm -f /bin/mv
rm -f /bin/pwd
rm -f /bin/readlink
# rm -f /bin/rm # This is deleted below.
# rm -f /bin/rmdir # This is deleted below.
rm -f /bin/sleep
rm -f /bin/stty
rm -f /bin/su
rm -f /bin/touch
rm -f /bin/true
rm -f /bin/uname
rm -f /bin/vdir
rm -f /usr/bin/dirname

# Cleanup files from the "Cydia Installer" package.
rm -rf /Applications/Cydia.app
rm -rf /etc/apt/apt.conf.d
rm -rf /etc/apt/preferences.d
rm -rf /etc/apt/sources.list.d
rm -rf /etc/apt/trusted.gpg.d
rm -f  /Library/LaunchDaemons/com.saurik.Cydia.Startup.plist
rm -rf /usr/libexec/cydia
rm -rf /var/lib/cydia

# Cleanup files from the "Cydia Substrate" package.
rm -rf /Library/Frameworks/CydiaSubstrate.framework
rm -rf /Library/MobileSubstrate
rm -f  /usr/bin/cycc
rm -f  /usr/bin/cynject
rm -f  /usr/include/substrate.h
rm -rf /usr/lib/cycript0.9
rm -f  /usr/lib/libsubstrate.dylib
rm -rf /usr/lib/substrate

# Cleanup files from the "Cydia Translations" package.
# nothing

# Cleanup files from the "Darwin Tools" package.
rm -f /usr/bin/sw_vers
rm -f /usr/libexec/firmware.sh
rm -f /usr/sbin/startupfiletool

# Cleanup files from the "Debian Packager" package.
rm -f  /etc/alternatives/README
rm -rf /etc/dpkg
rm -f  /usr/bin/dpkg
rm -f  /usr/bin/dpkg-deb
rm -f  /usr/bin/dpkg-divert
rm -f  /usr/bin/dpkg-maintscript-helper
rm -f  /usr/bin/dpkg-query
rm -f  /usr/bin/dpkg-split
rm -f  /usr/bin/dpkg-statoverride
rm -f  /usr/bin/dpkg-trigger
rm -f  /usr/bin/dselect
rm -f  /usr/bin/update-alternatives
rm -rf /usr/include/dpkg
rm -f  /usr/lib/libdpkg.a
rm -f  /usr/lib/pkgconfig/libdpkg.pc
rm -rf /usr/share/dpkg
rm -rf /usr/share/polkit-1
rm -rf /var/lib/dpkg/alternatives
rm -rf /var/lib/dpkg/info
rm -rf /var/lib/dpkg/parts
rm -rf /var/lib/dpkg/updates
rm -rf /var/log/dpkg

# Cleanup files from the "Debian Utilities" package.
rm -f /bin/run-parts

# Cleanup files from the "Diff Utilities" package.
rm -f /usr/bin/cmp
rm -f /usr/bin/diff
rm -f /usr/bin/diff3
rm -f /usr/bin/sdiff

# Cleanup files from the "File" package.
rm -f  /usr/bin/file
rm -f  /usr/inlude/magic.h
rm -f  /usr/lib/libmagic.1.dylib
rm -f  /usr/lib/libmagic.a
rm -rf /usr/lib/libmagic.a
rm -f  /usr/lib/ligmagic.dylib
rm -f  /usr/share/misc/magic.mgc

# Cleanup files for the "Fileza" packages.
rm -rf /Applications/Filza.app
rm -f  /Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
rm -rf /usr/libexec/filza
rm -rf /var/mobile/Library/Filza

# Cleanup files from the "Find Utilities" package.
rm -f  /usr/bin/find
rm -f  /usr/bin/locate
rm -f  /usr/bin/updatedb
rm -f  /usr/bin/xargs
rm -f  /usr/libexec/bigram
rm -f  /usr/libexec/code
rm -f  /usr/libexec/frcode
rm -rf /var/cache/findutils

# Cleanup files from the "Flex" package.
rm -rf /Applications/Flex.app
rm -f  /Library/dpkg/info/flex3beta.list
rm -f  /Library/dpkg/info/flex3beta.md5sums
rm -f  /Library/dpkg/info/flex3beta.postinst
rm -f  /Library/dpkg/info/flex3beta.prerm
rm -f  /private/var/mobile/Documents/extraction-com.apple.springboard.flex
rm -f  /private/var/mobile/Documents/extraction-com.johncoates.Flex.flex
rm -rf /private/var/mobile/Documents/Flex
rm -rf /private/var/mobile/Library/Application\ Support/Flex3
rm -f  /private/var/mobile/Library/Application\ Support/Flex3/patches.plist
rm -rf /private/var/mobile/Library/Caches/com.johncoates.Flex
rm -rf /private/var/mobile/Library/Caches/Snapshots/com.johncoates.Flex
rm -rf /private/var/mobile/Library/Flex3
rm -f  /private/var/mobile/Library/Preferences/com.johncoates.Flex.plist
rm -f  /private/var/mobile/Library/UserConfigurationProfiles/PublicInfo/Flex3Patches.plist

# Cleanup files from the "GetText" package.
rm -f  /usr/bin/autopoint
rm -f  /usr/bin/envsubst
rm -f  /usr/bin/gettext
rm -f  /usr/bin/gettext.sh
rm -f  /usr/bin/gettextize
rm -f  /usr/bin/msgattrib
rm -f  /usr/bin/msgcat
rm -f  /usr/bin/msgcmp
rm -f  /usr/bin/msgcomm
rm -f  /usr/bin/msgconv
rm -f  /usr/bin/msgen
rm -f  /usr/bin/msgexec
rm -f  /usr/bin/msgfilter
rm -f  /usr/bin/msgfmt
rm -f  /usr/bin/msggrep
rm -f  /usr/bin/msginit
rm -f  /usr/bin/msgmerge
rm -f  /usr/bin/msgunfmt
rm -f  /usr/bin/msguniq
rm -f  /usr/bin/ngettext
rm -f  /usr/bin/recode-sr-latin
rm -f  /usr/bin/xgettext 
rm -f  /usr/include/autosprintf.h
rm -f  /usr/include/gettext-po.h
rm -f  /usr/include/libintl.h
rm -rf /usr/lib/gettext
rm -f  /usr/lib/libasprintf.0.dylib
rm -f  /usr/lib/libasprintf.dylib
rm -f  /usr/lib/libgettextlib-0.19.8.dylib
rm -f  /usr/lib/libgettextlib.dylib
rm -f  /usr/lib/libgettextpo.1.dylib
rm -f  /usr/lib/libgettextpo.dylib
rm -f  /usr/lib/libgettextsrc-0.19.8.dylib
rm -f  /usr/lib/libgettextsrc.dylib
rm -f  /usr/lib/libintl.9.dylib
rm -f  /usr/lib/libintl.dylib

# Cleanup files from the "GNU Cryptography" package.
rm -f  /usr/bin/dumpsexp
rm -f  /usr/bin/hmac256
rm -f  /usr/bin/libgcrypt-config
rm -f  /usr/bin/mpicalc
rm -f  /usr/include/gcrypt.h
rm -f  /usr/lib/libgcrypt.20.dylib
rm -f  /usr/lib/libgcrypt.dylib
rm -f  /usr/lib/libgcrypt.la
rm -f  /usr/share/aclocal/libgcrypt.m4

# Cleanup files from the "GNU Multiple Precision Arithmetic" package.
rm -f  /usr/include/gmp.h
rm -f  /usr/lib/libgmp.10.dylib
rm -f  /usr/lib/libgmp.dylib
rm -f  /usr/lib/libgmp.la

# Cleanup files from the "GNUPG Errors" package.
rm -f  /usr/bin/gpg-error
rm -f  /usr/bin/gpg-error-config
rm -f  /usr/bin/gpgrt-config
rm -f  /usr/bin/yat2m
rm -f  /usr/include/gpg-error.h
rm -f  /usr/include/gpgrt.h
rm -f  /usr/lib/libgpg-error.0.dylib
rm -f  /usr/lib/libgpg-error.dylib
rm -f  /usr/lib/libgpg-error.la
rm -f  /usr/share/aclocal/gpg-error.m4
rm -f  /usr/share/aclocal/gpgrt.m4
rm -rf /usr/share/common-lisp
rm -rf /usr/share/libgpg-error

# Cleanup files from the "GNUPG & GnuPG 2" packages.
rm -f  /usr/bin/dirmngr
rm -f  /usr/bin/dirmngr-client
rm -f  /usr/bin/gpg
rm -f  /usr/bin/gpg-agent
rm -f  /usr/bin/gpg-connect-agent
rm -f  /usr/bin/gpg-zip
rm -f  /usr/bin/gpg2
rm -f  /usr/bin/gpgconf
rm -f  /usr/bin/gpgparsemail
rm -f  /usr/bin/gpgscm
rm -f  /usr/bin/gpgsm
rm -f  /usr/bin/gpgsplit
rm -f  /usr/bin/gpgtar
rm -f  /usr/bin/gpgv
rm -f  /usr/bin/gpgv2
rm -f  /usr/bin/kbxutil
rm -f  /usr/bin/watchgnupg
rm -f  /usr/libexec/gpg-check-pattern
rm -f  /usr/libexec/gpg-preset-passphrase
rm -f  /usr/libexec/gpg-protect-tool
rm -f  /usr/libexec/gpg-wks-client
rm -f  /usr/libexec/scdaemon
rm -rf /usr/libexec/gnupg
rm -f  /usr/sbin/addgnupghome
rm -f  /usr/sbin/applygnupgdefaults
rm -rf /usr/share/gnupg

# Cleanup files from the "GnuTLS" package.
rm -f  /usr/bin/certtool
rm -f  /usr/bin/gnutls-cli
rm -f  /usr/bin/gnutls-cli-debug
rm -f  /usr/bin/gnutls-serv
rm -f  /usr/bin/ocsptool
rm -f  /usr/bin/p11tool
rm -f  /usr/bin/psktool
rm -f  /usr/bin/srptool
rm -rf /usr/include/gnutls
rm -f  /usr/lib/libgnutls.30.dylib
rm -f  /usr/lib/libgnutls.dylib
rm -f  /usr/lib/libgnutlsxx.28.dylib
rm -f  /usr/lib/libgnutlsxx.dylib
rm -f  /usr/lib/pkgconfig/gnutls.pc

# Cleanup files from the "Grep" package.
rm -f /bin/egrep
rm -f /bin/fgrep
rm -f /bin/grep

# Cleanup files from the "gzip" package.
rm -f /bin/gunzip
rm -f /bin/gzexe
rm -f /bin/gzip
rm -f /bin/uncompress
rm -f /bin/zcat
rm -f /bin/zcmp
rm -f /bin/zdiff
rm -f /bin/zegrep
rm -f /bin/zfgrep
rm -f /bin/zforce
rm -f /bin/zgrep
rm -f /bin/zless
rm -f /bin/zmore
rm -f /bin/znew
rm -f /Library/dpkg/info/gzip.list

# Cleanup files from the "KSBA" package.
rm -f  /usr/bin/ksba-config
rm -f  /usr/include/ksba.h
rm -f  /usr/lib/libksba.8.dylib
rm -f  /usr/lib/libksba.dylib
rm -f  /usr/lib/libksba.la
rm -f  /usr/share/aclocal/ksba.m4

# Cleanup files from the "Launch Daemon Controller" package.
rm -f /bin/launchctl

# Cleanup files from the "libidn2" package.
rm -f /usr/bin/idn2
rm -f /usr/include/idn2.h
rm -f /usr/lib/libidn2.0.dylib
rm -f /usr/lib/libidn2.dylib
rm -f /usr/lib/libidn2.la
rm -f /usr/lib/pkgconfig/libidn2.pc

# Cleanup files from the "libplist" package.
rm -f  /usr/bin/plistutil
rm -f  /usr/include/plist/Array.h
rm -f  /usr/include/plist/Boolean.h
rm -f  /usr/include/plist/Data.h
rm -f  /usr/include/plist/Date.h
rm -f  /usr/include/plist/Dictionary.h
rm -f  /usr/include/plist/Integer.h
rm -f  /usr/include/plist/Key.h
rm -f  /usr/include/plist/Node.h
rm -f  /usr/include/plist/Real.h
rm -f  /usr/include/plist/String.h
rm -f  /usr/include/plist/Structure.h
rm -f  /usr/include/plist/Uid.h
rm -f  /usr/include/plist/plist++.h
rm -f  /usr/include/plist/plist.h
rmmdir /usr/include/plist
rm -f  /usr/lib/libplist++.3.dylib
rm -f  /usr/lib/libplist++.dylib
rm -f  /usr/lib/libplist.3.dylib
rm -f  /usr/lib/libplist.dylib
rm -f  /usr/lib/pkgconfig/libplist++.pc
rm -f  /usr/lib/pkgconfig/libplist.pc

# Cleanup files from the "libTasn1" package.
rm -f /usr/bin/asn1Coding
rm -f /usr/bin/asn1Decoding
rm -f /usr/bin/asn1Parser
rm -f /usr/include/libtasn1.h
rm -f /usr/lib/libtasn1.6.dylib
rm -f /usr/lib/libtasn1.dylib
rm -f /usr/lib/libtasn1.la
rm -f /usr/lib/pkgconfig/libtasn1.pc

# Cleanup files from the "libUnistring" package.
rm -f  /usr/include/unicase.h
rm -f  /usr/include/uniconv.h
rm -f  /usr/include/unictype.h
rm -f  /usr/include/unigbrk.h
rm -f  /usr/include/unilbrk.h
rm -f  /usr/include/uniname.h
rm -f  /usr/include/uninorm.h
rm -f  /usr/include/unistdio.h
rm -f  /usr/include/unistr.h
rm -f  /usr/include/unistring/cdefs.h
rm -f  /usr/include/unistring/iconveh.h
rm -f  /usr/include/unistring/inline.h
rm -f  /usr/include/unistring/localcharset.h
rm -f  /usr/include/unistring/stdbool.h
rm -f  /usr/include/unistring/stdint.h
rm -f  /usr/include/unistring/version.h
rm -f  /usr/include/unistring/woe32dll.h
rm -rf /usr/include/unistring
rm -f  /usr/include/unitypes.h
rm -f  /usr/include/uniwbrk.h
rm -f  /usr/include/uniwidth.h
rm -f  /usr/lib/libunistring.2.dylib
rm -f  /usr/lib/libunistring.dylib
rm -f  /usr/lib/libunistring.la

# Cleanup files from the "Link Identity Editor" package.
rm -f /usr/bin/ldid

# Cleanup files from the "lz4" package.
rm -f /usr/bin/lz4
rm -f /usr/bin/lz4c
rm -f /usr/bin/lz4cat
rm -f /usr/bin/unlz4
rm -f /usr/include/lz4.h
rm -f /usr/include/lz4frame.h
rm -f /usr/include/lz4hc.h
rm -f /usr/lib/liblz4.1.7.5.dylib
rm -f /usr/lib/liblz4.1.dylib
rm -f /usr/lib/liblz4.dylib
rm -f /usr/lib/pkgconfig/liblz4.pc

# Cleanup files from the "lzma utils" package.
rm -f /usr/bin/lzcat
rm -f /usr/bin/lzcmp
rm -f /usr/bin/lzdiff
rm -f /usr/bin/lzegrep
rm -f /usr/bin/lzfgrep
rm -f /usr/bin/lzgrep
rm -f /usr/bin/lzless
rm -f /usr/bin/lzma
rm -f /usr/bin/lzmadec
rm -f /usr/bin/lzmainfo
rm -f /usr/bin/lzmore
rm -f /usr/bin/unlzma
rm -f /usr/include/lzmadec.h
rm -f /usr/lib/liblzmadec.0.dylib
rm -f /usr/lib/liblzmadec.dylib

# Cleanup files from the "make" package.
rm -f /Library/dpkg/info/make.list
rm -f /Library/dpkg/info/make.md5sums
rm -f /usr/bin/make
rm -f /usr/include/gnumake.h

# Cleanup files from the "Nettle" package.
rm -f  /usr/bin/nettle-hash
rm -f  /usr/bin/nettle-lfib-stream
rm -f  /usr/bin/nettle-pbkdf2
rm -f  /usr/bin/pkcs1-conv
rm -f  /usr/bin/sexp-conv
rm -rf /usr/include/nettle
rm -f  /usr/lib/libhogweed.4.5.dylib
rm -f  /usr/lib/libhogweed.4.dylib
rm -f  /usr/lib/libhogweed.dylib
rm -f  /usr/lib/libnettle.6.5.dylib
rm -f  /usr/lib/libnettle.6.dylib
rm -f  /usr/lib/libnettle.dylib
rm -f  /usr/lib/pkgconfig/hogweed.pc
rm -f  /usr/lib/pkgconfig/nettle.pc

# Cleanup files from the "New Curses" packages.
rm -f  /usr/bin/captoinfo
rm -f  /usr/bin/clear
rm -f  /usr/bin/infocmp
rm -f  /usr/bin/infotocap
rm -f  /usr/bin/ncurses6-config
rm -f  /usr/bin/ncursesw6-config
rm -f  /usr/bin/reset
rm -f  /usr/bin/tabs
rm -f  /usr/bin/tic
rm -f  /usr/bin/toe
rm -f  /usr/bin/tput
rm -f  /usr/bin/tset
rm -f  /usr/include/curses.h
rm -f  /usr/include/eti.h
rm -f  /usr/include/form.h
rm -f  /usr/include/menu.h
rm -f  /usr/include/nc_tparm.h
rm -f  /usr/include/ncurses.h
rm -f  /usr/include/ncurses_dll.h
rm -f  /usr/include/panel.h
rm -f  /usr/include/term.h
rm -f  /usr/include/term_entry.h
rm -f  /usr/include/termcap.h
rm -f  /usr/include/tic.h
rm -f  /usr/include/unctrl.h
rm -rf /usr/include/ncursesw
rm -rf /usr/lib/_ncurses
rm -f  /usr/lib/libcurses.a
rm -f  /usr/lib/libform.6.dylib
rm -f  /usr/lib/libform.a
rm -f  /usr/lib/libform.dylib
rm -f  /usr/lib/libform_g.a
rm -f  /usr/lib/libformw.6.dylib
rm -f  /usr/lib/libformw.dylib
rm -f  /usr/lib/libmenu.6.dylib
rm -f  /usr/lib/libmenu.a
rm -f  /usr/lib/libmenu.dylib
rm -f  /usr/lib/libmenu_g.a
rm -f  /usr/lib/libmenuw.6.dylib
rm -f  /usr/lib/libmenuw.dylib
rm -f  /usr/lib/libncurses.6.dylib
rm -f  /usr/lib/libncurses.a
rm -f  /usr/lib/libncurses_g.a
rm -f  /usr/lib/libncurses.dylib
rm -f  /usr/lib/libncurses6.dylib
rm -f  /usr/lib/libncursesw.6.dylib
rm -f  /usr/lib/libncursesw.dylib
rm -f  /usr/lib/libncursesw6.dylib
rm -f  /usr/lib/libpanel.6.dylib
rm -f  /usr/lib/libpanel.a
rm -f  /usr/lib/libpanel.dylib
rm -f  /usr/lib/libpanel_g.a
rm -f  /usr/lib/libpanelw.6.dylib
rm -f  /usr/lib/libpanelw.dylib
rm -f  /usr/lib/pkgconfig/form.pc
rm -f  /usr/lib/pkgconfig/formw.pc
rm -f  /usr/lib/pkgconfig/menu.pc
rm -f  /usr/lib/pkgconfig/menuw.pc
rm -f  /usr/lib/pkgconfig/ncurses.pc
rm -f  /usr/lib/pkgconfig/ncursesw.pc
rm -f  /usr/lib/pkgconfig/panel.pc
rm -f  /usr/lib/pkgconfig/panelw.pc
rm -f  /usr/lib/terminfo
rm -rf /usr/lib/terminfo
rm -f  /usr/lib/libform.5.dylib
rm -f  /usr/lib/libform5.dylib
rm -f  /usr/lib/libformw.5.dylib
rm -f  /usr/lib/libformw5.dylib
rm -f  /usr/lib/libmenu.5.dylib
rm -f  /usr/lib/libmenu5.dylib
rm -f  /usr/lib/libmenuw.5.dylib
rm -f  /usr/lib/libmenuw5.dylib
rm -f  /usr/lib/libncurses.5.dylib
rm -f  /usr/lib/libncurses5.dylib
rm -f  /usr/lib/libncursesw.5.dylib
rm -f  /usr/lib/libncursesw5.dylib
rm -f  /usr/lib/libpanel.5.dylib
rm -f  /usr/lib/libpanel5.dylib
rm -f  /usr/lib/libpanelw.5.dylib
rm -f  /usr/lib/libpanelw5.dylib
rm -rf /usr/share/tabset
rm -rf /usr/share/terminfo

# Cleanup files from the "New GNU Portable Threads" package.
rm -f  /usr/bin/npth-config
rm -f  /usr/include/npth.h
rm -f  /usr/lib/libnpth.0.dylib
rm -f  /usr/lib/libnpth.dylib
rm -f  /usr/lib/libnpth.la
rm -f  /usr/share/aclocal/npth.m4

# Cleanup files from the "OpenSSH" package.
rm -f  /Library/LaunchDaemons/com.openssh.sshd.plist
rm -f  /etc/ssh/moduli
rm -f  /etc/ssh/ssh_config
rm -f  /etc/ssh/sshd_config
rm -f  /usr/bin/scp
rm -f  /usr/bin/sftp
rm -f  /usr/bin/ssh
rm -f  /usr/bin/ssh-add
rm -f  /usr/bin/ssh-agent
rm -f  /usr/bin/ssh-keygen
rm -f  /usr/bin/ssh-keyscan
rm -f  /usr/libexec/sftp-server
rm -f  /usr/libexec/ssh-keysign
rm -f  /usr/libexec/ssh-pkcs11-helper
rm -f  /usr/libexec/sshd-keygen-wrapper
rm -f  /usr/sbin/sshd
rm -rf /var/empty/*

# Cleanup files from the "OpenSSL 1.0/1.1 Libraries" package.
rm -rf /usr/lib/engines-1.0
rm -rf /usr/lib/engines-1.1
rm -f  /usr/lib/libcrypto.1.0.0.dylib
rm -f  /usr/lib/libssl.1.0.0.dylib
rm -f  /usr/lib/libcrypto.1.1.dylib
rm -f  /usr/lib/libssl.1.1.dylib

# Cleanup files from the "P11Kit" package.
rm -f  /usr/bin/p11-kit
rm -f  /usr/bin/trust
rm -rf /usr/etc/pkcs11
rm -rf /usr/include/p11-kit-1
rm -f  /usr/lib/libp11-kit.0.dylib
rm -f  /usr/lib/libp11-kit.dylib
rm -f  /usr/lib/libp11-kit.la
rm -f  /usr/lib/p11-kit-proxy.dylib
rm -rf /usr/lib/pkcs11
rm -f  /usr/lib/pkgconfig/p11-kit-1.pc
rm -rf /usr/libexec/p11-kit
rm -rf /usr/share/p11-kit

# Cleanup files from the "PreferenceLoader" package.
rm -f /usr/include/libprefs/prefs.h
rmdir /usr/include/libprefs
rm -f /usr/lib/libprefs.dylib

# Cleanup files from the "Profile Directory" package.
rm -f  /etc/profile
rm -f  /etc/profile.d/terminal.sh

# Cleanup files from the "Readline" package.
rm -rf /usr/include/readline
rm -f  /usr/lib/libhistory.5.2.dylib
rm -f  /usr/lib/libhistory.5.dylib
rm -f  /usr/lib/libhistory.6.0.dylib
rm -f  /usr/lib/libhistory.7.0.dylib
rm -f  /usr/lib/libhistory.7.dylib
rm -f  /usr/lib/libhistory.8.0.dylib
rm -f  /usr/lib/libhistory.8.dylib
rm -f  /usr/lib/libhistory.dylib
rm -f  /usr/lib/libreadline.5.2.dylib
rm -f  /usr/lib/libreadline.5.dylib
rm -f  /usr/lib/libreadline.6.0.dylib
rm -f  /usr/lib/libreadline.7.0.dylib
rm -f  /usr/lib/libreadline.7.dylib
rm -f  /usr/lib/libreadline.8.0.dylib
rm -f  /usr/lib/libreadline.8.dylib
rm -f  /usr/lib/libreadline.dylib
rm -f  /usr/lib/pkgconfig/readline.pc

# Cleanup files from the "Sed" package.
rm -f /bin/sed

# Cleanup files from the "ShellCmds" package.
rm -f /usr/bin/getopt
rm -f /usr/bin/killall
rm -f /usr/bin/renice
rm -f /usr/bin/script
rm -f /usr/bin/time
rm -f /usr/bin/which

# Cleanup files from the "Snappy" package (Deleted below)
# rm -f /usr/bin/snappy
# rm -f /usr/include/snappy.h
# rm -f /usr/lib/libsnappy.dylib

# Cleanup files from the "System-Cmds" package.
rm -f /bin/sync
rm -f /sbin/dmesg
rm -f /sbin/dynamic_pager
rm -f /sbin/halt
rm -f /usr/bin/arch
rm -f /usr/bin/chfn
rm -f /usr/bin/chsh
rm -f /usr/bin/getconf
rm -f /usr/bin/getty
rm -f /usr/bin/hostinfo
rm -f /usr/bin/login
rm -f /usr/bin/pagesize
rm -f /usr/bin/passwd
rm -f /usr/sbin/ac
rm -f /usr/sbin/accton
rm -f /usr/sbin/iostat
rm -f /usr/sbin/mkfile
rm -f /usr/sbin/nologin
rm -f /usr/sbin/pwd_mkdb
rm -f /usr/sbin/reboot
rm -f /usr/sbin/sysctl
rm -f /usr/sbin/vifs
rm -f /usr/sbin/vipw
rm -f /usr/sbin/zdump
rm -f /usr/sbin/zic

# Cleanup files from the "Tape Archive" package.
rm -f /bin/tar
rm -f /usr/bin/tar

# Cleanup files from the "UIKit Tools" package.
rm -f /usr/bin/cfversion
rm -f /usr/bin/ecidecid
rm -f /usr/bin/gssc
rm -f /usr/bin/iomfsetgamma
rm -f /usr/bin/ldrestart
rm -f /usr/bin/sbdidlaunch
rm -f /usr/bin/sbreload
rm -f /usr/bin/uicache
rm -f /usr/bin/uiduid
rm -f /usr/bin/uiopen

# Cleanup files from the "Unrar" package.
rm -f /usr/bin/unrar

# Cleanup files from the "Unzip" package.
rm -f /usr/bin/funzip
rm -f /usr/bin/unzip
rm -f /usr/bin/unzipsfx

# Cleanup files from the "WGet" package.
rm -f /usr/bin/wget
rm -f /usr/etc/wgetrc

# Cleanup files from the "XZ Utils" package.
rm -f  /usr/bin/unxz
rm -f  /usr/bin/xz
rm -f  /usr/bin/xzcat
rm -f  /usr/bin/xzcmp
rm -f  /usr/bin/xzdec
rm -f  /usr/bin/xzdiff
rm -f  /usr/bin/xzegrep
rm -f  /usr/bin/xzfgrep
rm -f  /usr/bin/xzgrep
rm -f  /usr/bin/xzless
rm -f  /usr/bin/xzmore
rm -rf /usr/include/lzma
rm -f  /usr/include/lzma.h
rm -f  /usr/local/lib/liblzma.5.dylib
rm -f  /usr/local/lib/liblzma.dylib
rm -f  /usr/local/lib/pkgconfig/liblzma.pc
rm -f  /usr/local/lib/pkgconfig/liblzma.pce
rm -rf /usr/local/lib/pkgconfig

# Cleanup files from the "Zip" package.
rm -f /usr/bin/zip
rm -f /usr/bin/zipcloak
rm -f /usr/bin/zipnote
rm -f /usr/bin/zipsplit

# Cleanup files form the "7zip" package.
rm -f  /usr/bin/7z
rm -f  /usr/bin/7za
rm -rf /usr/lib/p7zip

########################################################################
#                                                                      #
# End custom tweak uninstall area.                                     #
#                                                                      #
########################################################################

# Put the HOSTS file back to default values.
rm -f /etc/hosts
echo "##"                                                        > /etc/hosts
echo "# Host Database"                                          >> /etc/hosts
echo "#"                                                        >> /etc/hosts
echo "# localhost is used to configure the loopback interface"  >> /etc/hosts
echo "# when the system is booting.  Do not change this entry." >> /etc/hosts
echo "##"                                                       >> /etc/hosts
echo "127.0.0.1	localhost"                                      >> /etc/hosts
echo "255.255.255.255	broadcasthost"                            >> /etc/hosts
echo "::1             localhost"                                >> /etc/hosts

# Clear cache and remove the last of the system files.
/uninstall/uicache
/uninstall/rm -f /bin/rmdir
/uninstall/rm -f /bin/rm

chmod 755 /uninstall/snappy



# Execute a series of "touch" commands to reset the last modified date of several of the directories.
/uninstall/touch -t 201804140115.47 /Applications
/uninstall/touch -t 201804140115.40 /bin
/uninstall/touch -t 201804140115.12 /boot
/uninstall/touch -t 201804140115.19 /lib
/uninstall/touch -t 201804140104.47 /Library/Application\ Support
/uninstall/touch -t 201804140105.01 /Library/Frameworks
/uninstall/touch -t 201804140104.53 /Library/LaunchDaemons
/uninstall/touch -t 201804140105.01 /Library
/uninstall/touch -t 201804140115.41 /sbin
/uninstall/touch -t 201804140115.19 /private/etc
/uninstall/touch -t 201804140109.19 /System/Library/ControlCenter/Bundles/MuteModule.bundle/Info.plist
/uninstall/touch -t 201804140109.19 /System/Library/ControlCenter/Bundles/MuteModule.bundle
/uninstall/touch -t 201804140115.00 /System/Library/PrivateFrameworks/SoftwareUpdateServices.framework/Support
/uninstall/touch -t 201804140115.00 /System/Library/PrivateFrameworks/SoftwareUpdateServices.framework
/uninstall/touch -t 201804140114.39 /System/Library/PrivateFrameworks/MobileSoftwareUpdate.framework/Support
/uninstall/touch -t 201804140114.39 /System/Library/PrivateFrameworks/MobileSoftwareUpdate.framework
/uninstall/touch -t 201804140115.19 /System/Library/Watchdog/ThermalMonitor.bundle/D11AP.bundle/Info.plist
/uninstall/touch -t 201804140112.21 /System/Library/PreferenceBundles/BatteryUsageUI.bundle/BatteryUIModeling.plist
/uninstall/touch -t 201804140112.21 /System/Library/PreferenceBundles/BatteryUsageUI.bundle/BatteryUISuggestions.plist
/uninstall/touch -t 201804140112.51 /System/Library/PreferenceBundles
/uninstall/touch -t 201804140116.56 /System/Library
/uninstall/touch -t 201804140115.43 /usr/bin
/uninstall/touch -t 201804140115.41 /usr/include
/uninstall/touch -t 201804140115.44 /usr/local
/uninstall/touch -t 201804140115.41 /usr/lib
/uninstall/touch -t 201804140115.41 /usr/libexec
/uninstall/touch -t 201804140115.40 /usr/local/lib
/uninstall/touch -t 201804140115.44 /usr/sbin
/uninstall/touch -t 201804140115.44 /usr/share
/uninstall/touch -t 201804140115.44 /usr
/uninstall/touch -t 201804140115.19 /etc/fstab
/uninstall/touch -t 201804140115.19 /etc/hosts
/uninstall/touch -t 201804140115.19 /etc/master.passwd
/uninstall/touch -t 201804140115.19 /etc
/uninstall/touch -t 201804140115.19 /bin

# Restore the original SentMessage.caf file in: /System/Library/Audio/UISounds.
# NOTE, it would be best to do this part manually.  This has to do with disabling the swoosh sounds
# when sending messages in iMessage.
# if [ -e /System/Library/Audio/UISounds/SentMessage.caf.bak ]
# then
#	/uninstall/rm -f /System/Library/Audio/UISounds/SentMessage.caf
#	/uninstall/cp    /System/Library/Audio/UISounds/SentMessage.caf.bak /System/Library/Audio/UISounds/SentMessage.caf
#	/uninstall/rm -f /System/Library/Audio/UISounds/SentMessage.caf.bak
#	/uninstall/touch -t 201804140108.03 /System/Library/Audio/UISounds
# fi

# Restore the original Assets.car file in: /System/Library/Frameworks/UIKit.framework/Artwork.bundle
# NOTE, it would be best to do this part manually.  This has to do with the signal dots I put in to 
# replace the signal bars in stock IOS11.
#if [ -e /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car.bak ]
#then
#	/uninstall/rm -f /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car
#	/uninstall/cp    /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car.bak /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car
#	/uninstall/rm -f /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car.bak
#	/uninstall/touch -t 201804140110.48 /System/Library/Frameworks/UIKit.framework/Artwork.bundle
#fi

# Exit the script and notify user they we're done.
echo ""
echo "The script has ended.  Please execute the last few commands manually via Putty being sure to go through the remaining files and"
echo "directories that were created after 4/14/2018 2am.  Before you reboot the device be sure all of the files and directories are"
echo "truly gone.  Once you reboot, your device will be fully stock and no traces of the jailbreak should"
echo "remain on the device.  Good luck."
exit

# Search through directories and files that may still have leftovers in them.
/uninstall/find / -type d -newermt '4/14/2018 02:00:00' | sort
/uninstall/find / -type f -newermt '4/14/2018 02:00:00' | sort
/uninstall/find / -type l -newermt '4/14/2018 02:00:00' | sort
/uninstall/find / -type d -mtime +210 | sort
/uninstall/find / -type f -mtime +210 | sort
/uninstall/find / -type l -mtime +210 | sort

# Delete the last of the files & directories.
/uninstall/rm -f  /cleanup2.sh
/uninstall/rm -f  /private/var/root/.bash_history
/uninstall/rm -rf /uninstall



