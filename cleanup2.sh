###################################################################
#                                                                 #
# Cleanup2.sh                                                     #
#                                                                 #
# This script will remove all traces of the Electra and Unc0ver   #
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
# 3) Run the following command to ensure the correct              #
#    Dos->unix characters are converted:                          #
#    sed -i 's/\r$//' cleanup2.sh                                 #
#                                                                 #
# 4) Manual Deletions:                                            #
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
cp /usr/bin/uicache /uninstall
chmod 755 /uninstall/find
chmod 755 /uninstall/rm
chmod 755 /uninstall/rmdir
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

# /var/containers/Bundle/Application (Appears to be only app store apps & those installed via Impactor.)
rm -rf /var/containers/Bundle/Application/1F1507D3-3AC2-4551-B86C-E0107840572F # unc0ver
rm -rf /var/containers/Bundle/Application/3EBD2B2B-11EA-43D7-8470-85FB8840A672 # filzaescazped

# /var/mobile/Containers/Data/Application (Appears to be app store apps, impactor apps and Cydia apps.)
rm -rf /var/mobile/Containers/Data/Application/CCD77984-4065-4764-BD4B-AA58DFEEF0E9 # cocoatop
rm -rf /var/mobile/Containers/Data/Application/3854B68F-451C-48EA-9CC0-C1204C5BF32A # cydia
rm -rf /var/mobile/Containers/Data/Application/A0967302-40BA-493E-8933-6A26F6B18E80 # filza
rm -rf /var/mobile/Containers/Data/Application/FAD0D867-F20F-454E-B182-4BADF03A6A49 # filzaesccaped
rm -rf /var/mobile/Containers/Data/Application/CFDC337C-5241-467E-813E-31A9E875C210 # icleaner
rm -rf /var/mobile/Containers/Data/Application/2D2D01AB-097B-4581-B37D-5B4A58CE7FCD # safemode
rm -rf /var/mobile/Containers/Data/Application/0BB4706B-62B4-4337-B907-65C077A306D3 # unc0ver
rm -rf /var/mobile/Containers/Data/Application/49959A42-1AD0-49A2-BBD4-B315081CDFD6 # hbang terminal

# /var/mobile/Containers/Shared/AppGroup (Appears to be only app store apps & those installed via Impactor.)
rm -rf /var/mobile/Containers/Shared/AppGroup/xxxxx # nothing in directory.

########################################################################
#                                                                      #
# Identify files and directories that were created by App Store apps   #
# that can potentially be cleaned up and deleted.                      #
#                                                                      #
########################################################################

# Clean up files related to the robocall stuff.
# rm -f /var/mobile/Library/CallDirectory/CallDirectory.db
# rmdir /var/mobile/Library/CallDirectory

# Cleanup files Mail.app files.  Shouldn't need to do this though.
# rm -rf /var/mobile/Library/Mail

# Clean up files related to voice mail recordings.
# rm -rf /var/mobile/Library/Voicemail/*

########################################################################
#                                                                      #
# Delete the directories that aren't part of a model .ipsw file.       #
#                                                                      #
########################################################################

# Delete directories off of the / folder.
rm -rf /.fseventsd/*
rm -rf /bootstrap
rm -rf /cores/*
rm -rf /Developer/*
rm -rf /DT
rm -rf /electra
rm -rf /jb
rm -rf /lib/*
rm -rf /libexec
rm -rf /mnt/*
rm -rf /tmp/* 
rm -rf /uninstall

# Delete directories off of the /etc folder.
rm -rf /etc/apt
rm -rf /etc/default
rm -rf /etc/profile.d
rm -rf /etc/rc.d
rm -rf /etc/ssh
rm -rf /etc/ssl

# Delete directories off of the /Library folder.
rm -rf /Library/Activator
rm -rf /Library/dpkg
rm -rf /Library/ControlCenter
rm -rf /Library/Flipswitch
rm -rf /Library/Frameworks/*
rm -rf /Library/LaunchDaemons/*
rm -rf /Library/MobileSubstrate
rm -rf /Library/PreferenceBundles
rm -rf /Library/PreferenceLoader
rm -rf /Library/Switches
rm -rf /Library/Themes
rm -rf /Library/unlimapps_tweak_resources

# Delete directories off of the /usr folder.
rm -rf /usr/games
rm -rf /usr/include/*
rm -rf /usr/lib/bash
rm -rf /usr/lib/pkgconfig
rm -rf /usr/lib/tweaks
rm -rf /usr/local/bin
rm -rf /usr/local/lib/*
rm -rf /usr/share/aclocal
rm -rf /usr/share/man

# Delete directories off of the /var folder.
rm -rf /var/db/analyticsd/*
rm -rf /var/db/diagnostics/*
rm -rf /var/DT
rm -rf /var/installd/Library/Logs/*
rm -rf /var/lib
rm -rf /var/mobile/Library/.Trash
rm -rf /var/mobile/Library/.Trash.metadata
rm -rf /var/mobile/Library/ApplicationSync
rm -rf /var/mobile/Library/Caches/*
rm -rf /var/mobile/Library/Cookies/*
rm -rf /var/mobile/Library/Filza/.Trash/*
rm -rf /var/mobile/Library/Filza/.Trash.metadata/*
rm -rf /var/mobile/Library/WebKit/*
rm -rf /var/mobile/MobileSoftwareUpdate/mnt1
rm -rf /var/root/Application\ Support/*
rm -rf /var/root/Library/Caches/*
rm -rf /var/ua_tweak_resources
rm -rf /var/unlimapps_tweak_resources

# Delete misc files that don't belong to any tweak.
rm -f  /.bit_of_fun
rm -f  /.bootstrapped_electra
rm -f  /.cydia_no_stash
rm -f  /.file
rm -f  /.installed_unc0ver
rm -f  /RWTEST
rm -f  /.Trashes
rm -f  /test.txt
rm -f  /bin/launchctl
rm -f  /private/var/installd/Library/MobileInstallation/UninstalledApplications.plist
rm -f  /private/var/installd/Library/Preferences/*.plist.*
rm -f  /private/var/mobile/.bash_history
rm -f  /private/var/mobile/test.txt
rm -f  /private/var/mobile/Library/google*.*
rm -f  /private/var/mobile/Library/Preferences/.GlobalPreferences.plist.*
rm -f  /private/var/mobile/Library/Preferences/com.apple.*.plist.*
rm -f  /private/var/mobile/Library/Preferences/cn.tinyapps.location360pro.plist
rm -f  /private/var/mobile/Library/Preferences/com.dt.tweaks.plist
rm -f  /private/var/mobile/Library/Preferences/group.com.apple.weather.plist
rm -f  /private/var/mobile/Library/Preferences/xhprx.xh
rm -f  /private/var/mobile/Library/SpringBoard/ApplicationShortcuts/org.coolstar.electra.plist
rm -f  /private/var/mobile/Library/SpringBoard/ApplicationShortcuts/org.coolstar.electra1131-mp.plist
rm -f  /private/var/mobile/Library/SpringBoard/ApplicationShortcuts/science.xnu.undecimus.plist
rm -f  /private/var/mobile/Library/SpringBoard/PushStore/com.saurik.Cydia.pushstore
rm -f  /private/var/mobile/MobileSoftwareUpdate/last_update_result.plist
rm -f  /private/var/mobile/MobileSoftwareUpdate/restore.log
rm -f  /private/var/MobileSoftwareUpdate/restore.log
rm -f  /private/var/networkd/Library/Preferences/*.plist.*
rm -f  /private/var/root/.bash_history
rm -f  /private/var/root/.bashrc
rm -f  /private/var/root/.profile
rm -f  /private/var/root/master.zip
rm -f  /private/var/root/Library/Preferences/com.apple.*.plist.*
rm -f  /private/var/root/Library/Preferences/UserEventAgent.plist
rm -f  /private/var/run/jailbreakd.pid
rm -f  /private/var/run/sshd.pid
rm -f  /private/var/tmp/jailbreakd.pid
rm -f  /usr/bin/debugserver
rm -f  /usr/bin/spawn
rm -f  /usr/lib/libjailbreak.dylib
rm -f  /usr/lib/pspawn_hook.dylib
rm -f  /usr/sbin/repquota

# Delete misc folders that don't belong to any tweak.
rm -rf /Library/Application\ Support/SpeedOptimize
rm -rf /usr/share/bash-completion
rm -rf /usr/share/bigboss
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

# Cleanup files from the "7-zip (POSIX)" package.
rm -f  /Library/dpkg/info/p7zip.list
rm -f  /Library/dpkg/info/p7zip.md5sums
rm -f  /usr/bin/7z
rm -f  /usr/bin/7za
rm -rf /usr/lib/p7zip

# Cleanup files from the "Abaculus" package.
rm -f /private/var/mobile/Library/Preferences/com.shade.abaculus.plist

# Cleanup files from the "Activator" package.
rm -rf /Applications/Activator.app
rm -rf /Library/Activator/ActivatorSpringBoard.bundle
rm -rf /Library/Activator/ar.lproj
rm -rf /Library/Activator/de.lproj
rm -rf /Library/Activator/en.lproj
rm -rf /Library/Activator/en_GB.lproj
rm -rf /Library/Activator/es.lproj
rm -rf /Library/Activator/Events
rm -rf /Library/Activator/fr.lproj
rm -rf /Library/Activator/he.lproj
rm -rf /Library/Activator/it.lproj
rm -rf /Library/Activator/ja.lproj
rm -rf /Library/Activator/ko.lproj
rm -f  /Library/Activator/Listeners/bundled.plist
rm -rf /Library/Activator/Listeners/com.apple.AppStore
rm -rf /Library/Activator/Listeners/com.apple.Maps
rm -rf /Library/Activator/Listeners/com.apple.MobileAddressBook
rm -rf /Library/Activator/Listeners/com.apple.MobileSMS
rm -rf /Library/Activator/Listeners/com.apple.MobileStore
rm -rf /Library/Activator/Listeners/com.apple.Music
rm -rf /Library/Activator/Listeners/com.apple.Passbook
rm -rf /Library/Activator/Listeners/com.apple.Preferences
rm -rf /Library/Activator/Listeners/com.apple.VoiceMemos
rm -rf /Library/Activator/Listeners/com.apple.calculator
rm -rf /Library/Activator/Listeners/com.apple.camera
rm -rf /Library/Activator/Listeners/com.apple.compass
rm -rf /Library/Activator/Listeners/com.apple.facetime
rm -rf /Library/Activator/Listeners/com.apple.gamecenter
rm -rf /Library/Activator/Listeners/com.apple.mobilecal
rm -rf /Library/Activator/Listeners/com.apple.mobilemail
rm -rf /Library/Activator/Listeners/com.apple.mobilenotes
rm -rf /Library/Activator/Listeners/com.apple.mobilephone
rm -rf /Library/Activator/Listeners/com.apple.mobilesafari
rm -rf /Library/Activator/Listeners/com.apple.mobileslideshow
rm -rf /Library/Activator/Listeners/com.apple.mobiletimer
rm -rf /Library/Activator/Listeners/com.apple.nike
rm -rf /Library/Activator/Listeners/com.apple.reminders
rm -rf /Library/Activator/Listeners/com.apple.stocks
rm -rf /Library/Activator/Listeners/com.apple.store.Jolly
rm -rf /Library/Activator/Listeners/com.apple.videos
rm -rf /Library/Activator/Listeners/com.apple.weather
rm -rf /Library/Activator/Listeners/com.atebits.Tweetie2
rm -rf /Library/Activator/Listeners/com.burbn.instagram
rm -rf /Library/Activator/Listeners/com.facebook.Facebook
rm -rf /Library/Activator/Listeners/com.facebook.Messenger
rm -rf /Library/Activator/Listeners/com.foursquare.robin
rm -rf /Library/Activator/Listeners/com.getdropbox.Dropbox
rm -rf /Library/Activator/Listeners/com.google.Authenticator
rm -rf /Library/Activator/Listeners/com.google.Gmail
rm -rf /Library/Activator/Listeners/com.google.Maps
rm -rf /Library/Activator/Listeners/com.google.ios.youtube
rm -rf /Library/Activator/Listeners/com.naveenium.foursquare
rm -rf /Library/Activator/Listeners/com.saurik.Cydia
rm -rf /Library/Activator/Listeners/com.skype.skype
rm -rf /Library/Activator/Listeners/com.spotify.client
rm -rf /Library/Activator/Listeners/com.yahoo.weather
rm -rf /Library/Activator/Listeners/crash-reporter
rm -rf /Library/Activator/Listeners/libactivator
rm -rf /Library/Activator/Listeners/libactivator.audio.decrease-volume
rm -rf /Library/Activator/Listeners/libactivator.audio.increase-volume
rm -rf /Library/Activator/Listeners/libactivator.audio.launch-playing-app
rm -rf /Library/Activator/Listeners/libactivator.audio.reset-ringer-state
rm -rf /Library/Activator/Listeners/libactivator.audio.show-volume-bar
rm -rf /Library/Activator/Listeners/libactivator.camera.invoke-shutter
rm -rf /Library/Activator/Listeners/libactivator.clock.alarm
rm -rf /Library/Activator/Listeners/libactivator.clock.bedtime
rm -rf /Library/Activator/Listeners/libactivator.clock.stopwatch
rm -rf /Library/Activator/Listeners/libactivator.clock.timer
rm -rf /Library/Activator/Listeners/libactivator.clock.world-clock
rm -rf /Library/Activator/Listeners/libactivator.facebook.compose-post
rm -rf /Library/Activator/Listeners/libactivator.ipod.next-track
rm -rf /Library/Activator/Listeners/libactivator.ipod.pause-playback
rm -rf /Library/Activator/Listeners/libactivator.ipod.previous-track
rm -rf /Library/Activator/Listeners/libactivator.ipod.resume-playback
rm -rf /Library/Activator/Listeners/libactivator.ipod.toggle-playback
rm -rf /Library/Activator/Listeners/libactivator.keyboard.dictation
rm -rf /Library/Activator/Listeners/libactivator.lockscreen.dismiss
rm -rf /Library/Activator/Listeners/libactivator.lockscreen.show
rm -rf /Library/Activator/Listeners/libactivator.lockscreen.toggle
rm -rf /Library/Activator/Listeners/libactivator.mail.compose-message
rm -rf /Library/Activator/Listeners/libactivator.phone.answer-call
rm -rf /Library/Activator/Listeners/libactivator.phone.contacts
rm -rf /Library/Activator/Listeners/libactivator.phone.disconnect-call
rm -rf /Library/Activator/Listeners/libactivator.phone.favorites
rm -rf /Library/Activator/Listeners/libactivator.phone.keypad
rm -rf /Library/Activator/Listeners/libactivator.phone.recents
rm -rf /Library/Activator/Listeners/libactivator.phone.voicemail
rm -rf /Library/Activator/Listeners/libactivator.settings.about
rm -rf /Library/Activator/Listeners/libactivator.settings.accessibility
rm -rf /Library/Activator/Listeners/libactivator.settings.auto-lock
rm -rf /Library/Activator/Listeners/libactivator.settings.background-app-refresh
rm -rf /Library/Activator/Listeners/libactivator.settings.battery
rm -rf /Library/Activator/Listeners/libactivator.settings.bluetooth
rm -rf /Library/Activator/Listeners/libactivator.settings.brightness
rm -rf /Library/Activator/Listeners/libactivator.settings.brightness-and-wallpaper
rm -rf /Library/Activator/Listeners/libactivator.settings.carplay
rm -rf /Library/Activator/Listeners/libactivator.settings.cellular
rm -rf /Library/Activator/Listeners/libactivator.settings.control-center
rm -rf /Library/Activator/Listeners/libactivator.settings.date-time
rm -rf /Library/Activator/Listeners/libactivator.settings.display
rm -rf /Library/Activator/Listeners/libactivator.settings.do-not-disturb
rm -rf /Library/Activator/Listeners/libactivator.settings.equalizer
rm -rf /Library/Activator/Listeners/libactivator.settings.facebook
rm -rf /Library/Activator/Listeners/libactivator.settings.facetime
rm -rf /Library/Activator/Listeners/libactivator.settings.game-center
rm -rf /Library/Activator/Listeners/libactivator.settings.general
rm -rf /Library/Activator/Listeners/libactivator.settings.handoff
rm -rf /Library/Activator/Listeners/libactivator.settings.icloud
rm -rf /Library/Activator/Listeners/libactivator.settings.international
rm -rf /Library/Activator/Listeners/libactivator.settings.keyboard
rm -rf /Library/Activator/Listeners/libactivator.settings.location-services
rm -rf /Library/Activator/Listeners/libactivator.settings.mail
rm -rf /Library/Activator/Listeners/libactivator.settings.managed-configuration
rm -rf /Library/Activator/Listeners/libactivator.settings.maps
rm -rf /Library/Activator/Listeners/libactivator.settings.messages
rm -rf /Library/Activator/Listeners/libactivator.settings.music
rm -rf /Library/Activator/Listeners/libactivator.settings.network
rm -rf /Library/Activator/Listeners/libactivator.settings.notes
rm -rf /Library/Activator/Listeners/libactivator.settings.notifications
rm -rf /Library/Activator/Listeners/libactivator.settings.passcode
rm -rf /Library/Activator/Listeners/libactivator.settings.phone
rm -rf /Library/Activator/Listeners/libactivator.settings.photos
rm -rf /Library/Activator/Listeners/libactivator.settings.privacy
rm -rf /Library/Activator/Listeners/libactivator.settings.reminders
rm -rf /Library/Activator/Listeners/libactivator.settings.safari
rm -rf /Library/Activator/Listeners/libactivator.settings.sounds
rm -rf /Library/Activator/Listeners/libactivator.settings.store
rm -rf /Library/Activator/Listeners/libactivator.settings.tethering
rm -rf /Library/Activator/Listeners/libactivator.settings.twitter
rm -rf /Library/Activator/Listeners/libactivator.settings.usage
rm -rf /Library/Activator/Listeners/libactivator.settings.virtual-assistant
rm -rf /Library/Activator/Listeners/libactivator.settings.vpn
rm -rf /Library/Activator/Listeners/libactivator.settings.wallpaper
rm -rf /Library/Activator/Listeners/libactivator.settings.wifi
rm -rf /Library/Activator/Listeners/libactivator.sms.compose-message
rm -rf /Library/Activator/Listeners/libactivator.system.activate-control-center
rm -rf /Library/Activator/Listeners/libactivator.system.activate-notification-center
rm -rf /Library/Activator/Listeners/libactivator.system.activate-reachability
rm -rf /Library/Activator/Listeners/libactivator.system.activate-switcher
rm -rf /Library/Activator/Listeners/libactivator.system.back
rm -rf /Library/Activator/Listeners/libactivator.system.clear-switcher
rm -rf /Library/Activator/Listeners/libactivator.system.first-springboard-page
rm -rf /Library/Activator/Listeners/libactivator.system.haptic.flick
rm -rf /Library/Activator/Listeners/libactivator.system.haptic.quirk
rm -rf /Library/Activator/Listeners/libactivator.system.haptic.tap
rm -rf /Library/Activator/Listeners/libactivator.system.homebutton
rm -rf /Library/Activator/Listeners/libactivator.system.local-back
rm -rf /Library/Activator/Listeners/libactivator.system.nothing
rm -rf /Library/Activator/Listeners/libactivator.system.power-menu
rm -rf /Library/Activator/Listeners/libactivator.system.powerdown
rm -rf /Library/Activator/Listeners/libactivator.system.reboot
rm -rf /Library/Activator/Listeners/libactivator.system.respring
rm -rf /Library/Activator/Listeners/libactivator.system.safemode
rm -rf /Library/Activator/Listeners/libactivator.system.sleepbutton
rm -rf /Library/Activator/Listeners/libactivator.system.spotlight
rm -rf /Library/Activator/Listeners/libactivator.system.take-screenshot
rm -rf /Library/Activator/Listeners/libactivator.system.vibrate
rm -rf /Library/Activator/Listeners/libactivator.system.virtual-assistant
rm -rf /Library/Activator/Listeners/libactivator.system.voice-control
rm -rf /Library/Activator/Listeners/libactivator.twitter.compose-tweet
rm -rf /Library/Activator/Listeners/libactivator.watch.haptic.tap
rm -rf /Library/Activator/Listeners/libactivator.weibo.compose-post
rm -rf /Library/Activator/nl.lproj
rm -rf /Library/Activator/pl.lproj
rm -rf /Library/Activator/pt_PT.lproj
rm -rf /Library/Activator/ru.lproj
rm -rf /Library/Activator/SwitchTemplates
rm -rf /Library/Activator/tr.lproj
rm -rf /Library/Activator/zh_CN.lproj
rm -rf /Library/Activator/zh_TW.lproj
rm -f  /Library/Activator/Info.plist
rm -f  /var/mobile/Library/Caches/libactivator.plist
rm -f  /var/mobile/Library/Preferences/libactivator.plist
rm -f  /usr/bin/activator
rm -rf /usr/include/libactivator
rm -rf /usr/lib/Activator
rm -f  /usr/lib/libactivator.dylib

# Cleanup files from the "Adv-Cmds" package.
rm -f /usr/bin/cap_mkdb
rm -f /usr/bin/finger
rm -f /usr/bin/last
rm -f /usr/bin/locale
rm -f /usr/bin/ps

# Cleanup files from the Anemone package.
rm -rf /Applications/Anemone.app
rm -rf /private/var/mobile/Library/Caches/com.anemonetheming.anemone
rm -rf /private/var/mobile/Library/Caches/Snapshots/com.anemonetheming.anemone
rm -f  /private/var/mobile/Library/Caches/com.anemoneteam.themegroups.plist
rm -f  /private/var/mobile/Library/Caches/com.anemoneteam.themeidentifiers.plist
rm -f  /private/var/mobile/Library/Caches/com.anemoneteam.themelist.plist
rm -f  /private/var/mobile/Library/Caches/com.anemoneteam.themenameoverrides.plist
rm -f  /private/var/mobile/Library/Caches/com.anemoneteam.themenames.plist
rm -f  /private/var/mobile/Library/Preferences/com.anemoneteam.anemone.plist
rm -f  /private/var/mobile/Library/Preferences/com.anemoneteam.anemonedbg.plist
rm -f  /private/var/mobile/Library/Preferences/com.anemoneteam.anemoneiconsdbg.plist
rm -f  /private/var/mobile/Library/Preferences/com.anemoneteam.anemoneiconsoverride.plist
rm -f  /private/var/mobile/Library/Preferences/com.anemoneteam.anemoneordering.plist
rm -f  /private/var/mobile/Library/Preferences/com.anemoneteam.optithemereloaded
rm -rf /private/var/stash/anemonecache
rm -f  /usr/bin/AnemoneOptimizer
rm -f  /usr/bin/cardump
rm -f  /usr/bin/recache

# Cleanup files from any themes applied with Anemone or XenHTML.
rm -f  /AceHighSierra.deb
rm -f  /Library/dpkg/info/com.0neguy.piksel.list
rm -f  /Library/dpkg/info/com.0neguy.piksel.md5sums
rm -f  /Library/dpkg/info/com.ianas.acehighsierra.list
rm -f  /Library/dpkg/info/com.ianas.acehighsierra.md5sums
rm -f  /Library/dpkg/info/com.sami.sshadow.list
rm -f  /Library/dpkg/info/com.sami.sshadow.md5sums
rm -rf /Library/Themes
rm -rf /private/var/mobile/Library/iWidgets
rm -rf /private/var/mobile/Library/LockHTML
rm -rf /private/var/mobile/Library/SBHTML

# Cleanup files from the "App Admin" package.
rm -rf /Library/unlimapps_tweak_resources/uaupdatetools
rm -rf /private/var/ua_tweak_resources/uaupdatetools
rm -rf /private/var/unlimapps_tweak_resources/uaupdatetools

# Cleanup files from the "Apps Manager" package.
rm -rf /Applications/ADManager.app
rm -f  /usr/bin/ADMHelper
rm -rf /var/mobile/Library/ADManager
rm -rf /var/mobile/Library/Caches/com.tigisoftware.ADManager
rm -f  /var/mobile/Library/Preferences/com.tigisoftware.ADManager.plist

# Cleanup files from the "AppInst" package.
rm -f /usr/bin/appinst

# Cleanup files from the "Applist" package.
rm -f  /Library/dpkg/info/applist.list
rm -f  /Library/dpkg/info/applist.md5sums
rm -rf /System/Library/PreferenceBundles/AppList.bundle
rm -rf /usr/include/AppList
rm -f  /usr/lib/libapplist.dylib

# Cleanup files from the "App Store No History" package.
rm -f /var/mobile/Library/Preferences/com.julioverne.appstorenohistory.apps.plist
rm -f /var/mobile/Library/Preferences/com.julioverne.appstorenohistory.plist

# Cleanup files from the "Appsync Unified" package.
rm -f /Library/LaunchDaemons/net.angelxwind.asu_inject.plist
rm -f /usr/bin/asu_inject

# Cleanup files from the "APT 1.4 (apt-key)" package.
rm -f  /Library/dpkg/info/apt7-key.list
rm -f  /Library/dpkg/info/apt7-key.md5sums
rm -f  /usr/bin/apt-key

# Cleanup files from the "APT 0.7 Strict & 1.4 Strict" package.
rm -f  /usr/bin/apt
rm -f  /usr/bin/apt-cache
rm -f  /usr/bin/apt-cdrom
rm -f  /usr/bin/apt-config
rm -f  /usr/bin/apt-extracttemplates
rm -f  /usr/bin/apt-ftparchive
rm -f  /usr/bin/apt-get
rm -f  /usr/bin/apt-mark
rm -f  /usr/bin/apt-sortpkgs
rm -rf /usr/include/apt-pkg

# Cleanup files from the "APT 1.4 Strict (lib)" package.
rm -f  /Library/dpkg/info/apt7-lib.list
rm -f  /Library/dpkg/info/apt7-lib.md5sums
rm -f  /Library/dpkg/info/apt7-lib.preinst
rm -rf /etc/apt/apt.conf.d
rm -rf /etc/apt/preferences.d
rm -rf /etc/apt/sources.list.d
rm -rf /etc/apt/trusted.gpg.d
rm -rf /usr/lib/apt
rm -f  /usr/lib/apt
rm -f  /usr/lib/libapt-inst.2.0.0.dylib
rm -f  /usr/lib/libapt-inst.2.0.dylib
rm -f  /usr/lib/libapt-inst.dylib
rm -f  /usr/lib/libapt-pkg.5.0.1.dylib
rm -f  /usr/lib/libapt-pkg.5.0.dylib
rm -f  /usr/lib/libapt-pkg.dylib
rm -f  /usr/lib/libapt-private.0.0.0.dylib
rm -f  /usr/lib/libapt-private.0.0.dylib
rm -rf /usr/libexec/apt
rm -rf /usr/libexec/dpkg
rm -rf /usr/share/bash-completion
rm -rf /usr/share/doc
rm -rf /var/cache/apt
rm -rf /var/lib/apt
rm -rf /var/log/apt

# Cleanup files from the "Assuan" package.
rm -f  /usr/bin/libassuan-config
rm -f  /usr/include/assuan.h
rm -f  /usr/lib/libassuan.0.dylib
rm -f  /usr/lib/libassuan.dylib
rm -f  /usr/lib/libassuan.la
rm -f  /usr/share/aclocal/libassuan.m4
rmdir  /usr/share/aclocal

# Cleanup files from the "Basic-Cmds" package.
rm -f /usr/bin/mesg
rm -f /usr/bin/uudecode
rm -f /usr/bin/uuencode
rm -f /usr/bin/write

# Cleanup files from the "Berkley DB" package.
rm -f /usr/bin/dbsql
rm -f /usr/bin/db_archive
rm -f /usr/bin/db_checkpoint
rm -f /usr/bin/db_codegen
rm -f /usr/bin/db_deadlock
rm -f /usr/bin/db_dump
rm -f /usr/bin/db_hotbackup
rm -f /usr/bin/db_load
rm -f /usr/bin/db_log_verify
rm -f /usr/bin/db_printlog
rm -f /usr/bin/db_recover
rm -f /usr/bin/db_replicate
rm -f /usr/bin/db_sql_codegen
rm -f /usr/bin/db_stat
rm -f /usr/bin/db_tuner
rm -f /usr/bin/db_upgrade
rm -f /usr/bin/db_verify
rm -f /usr/include/db.h
rm -f /usr/include/db_cxx.h
rm -f /usr/include/dbsql.h
rm -f /usr/lib/libdb-4.6.dylib
rm -f /usr/lib/libdb-4.6.la
rm -f /usr/lib/libdb-4.dylib
rm -f /usr/lib/libdb-6.2.dylib
rm -f /usr/lib/libdb-6.dylib
rm -f /usr/lib/libdb.dylib
rm -f /usr/lib/libdb_sql-6.2.dylib
rm -f /usr/lib/libdb_sql-6.dylib
rm -f /usr/lib/libdb_sql.dylib

# Cleanup files from the "BetterCCXI" package.
rm -rf /Library/ControlCenter/Bundles/BCIXWeatherModule.bundle
rm -f  /private/var/mobile/Library/Preferences/com.atwiiks.betterccxi
rm -f  /private/var/mobile/Library/Preferences/com.atwiiks.betterccxi.plist

# Cleanup files from the "BetterSettings" package.
rm -rf /private/var/mobile/Library/Preferences/BetterSettings
rm -f  /private/var/mobile/Library/Preferences/com.midnightchips.bettersettings.bgimage.plist
rm -f  /private/var/mobile/Library/Preferences/com.midnightchips.bettersettings.plist
rm -f  /private/var/mobile/Library/Preferences/com.midnightchips.bettersettings*.*

# Cleanup files from the "Bigboss Icon Set" package.
rm -f  /Library/dpkg/info/org.thebigboss.repo.icons.list
rm -rf /usr/share/bigboss/bigboss.png
rm -rf /usr/share/bigboss/planetiphones.png
rm -rf /usr/share/bigboss/touchrev.png

# Cleanup files from the "Bootstrap-Cmds" package.
rm -f /usr/bin/mig
rm -f /usr/libexec/migcom

# Cleanup files from the "Bourne-Again SHell" package.
rm -f  /Library/dpkg/info/bash.list
rm -f  /Library/dpkg/info/bash.md5sums
rm -f  /bin/bash
rm -f  /bin/sh
rm -f  /usr/bin/bashbug
rm -f  /usr/lib/bash/basename
rm -f  /usr/lib/bash/dirname
rm -f  /usr/lib/bash/finfo
rm -f  /usr/lib/bash/head
rm -f  /usr/lib/bash/id
rm -f  /usr/lib/bash/ln
rm -f  /usr/lib/bash/logname
rm -f  /usr/lib/bash/mkdir
rm -f  /usr/lib/bash/mypid
rm -f  /usr/lib/bash/pathchk
rm -f  /usr/lib/bash/print
rm -f  /usr/lib/bash/printenv
rm -f  /usr/lib/bash/push
rm -f  /usr/lib/bash/realpath
rm -f  /usr/lib/bash/rmdir 
rm -f  /usr/lib/bash/setpgid
rm -f  /usr/lib/bash/sleep
rm -f  /usr/lib/bash/strftime
rm -f  /usr/lib/bash/sync
rm -f  /usr/lib/bash/tee
rm -f  /usr/lib/bash/truefalse
rm -f  /usr/lib/bash/tty
rm -f  /usr/lib/bash/uname
rm -f  /usr/lib/bash/unlink
rm -f  /usr/lib/bash/whoami
rm -rf /usr/lib/bash

# Cleanup files from the Boxy package.
rm -rf /private/var/mobile/Documents/com.irepo.boxy3
rm -f  /private/var/mobile/Documents/Boxy3.log
rm -f  /private/var/mobile/Library/Preferences/com.irepo.boxy.plist
rm -rf /usr/lib/TweakInject/Boxy_Main.bundle

# Cleanup files from the "Bytafont 3" package.
rm -rf /Applications/BytaFont3.app
rm -f  /com.bytafont.bytafont3*.deb
rm -rf /Library/CustomFonts
rm -rf /private/var/mobile/Library/Caches/com.bytafont.BytaFont3
rm -f  /private/var/mobile/Library/Preferences/BytaFontTweakMode.plist
rm -f  /private/var/mobile/Library/Preferences/com.bytafont.BytaFont3.plist
rm -rf /private/var/mobile/Library/Preferences/BytaFontBackup

# Cleanup files from the bzip2 package.
rm -f /Library/dpkg/info/bzip2.list
rm -f /bin/bunzip2
rm -f /bin/bzcat
rm -f /bin/bzip2
rm -f /bin/bzip2recover

# Cleanup files from the "CACerts" package.
rm -f /etc/profile.d/cacerts.bootstrap.sh
rmdir /etc/profile.d
rm -f /etc/ssl/certs/cacert.pem
rm -f /Library/dpkg/info/org.thebigboss.cacerts.list
rm -f /Library/dpkg/info/org.thebigboss.cacerts.md5sums
rm -f /usr/local/bin/curl
rm -f /usr/local/bin/wget
rmdir /etc/ssl/certs
rmdir /usr/local/bin

# Cleanup files from the CCModules package.
rm -rf /Library/ControlCenter/Bundles
rm -f  /private/var/mobile/Library/Preferences/com.oly.xb-ccmodules.plist

# Cleanup files from the CCSupport package.
rm -rf /Library/Application\ Support/CCSupport
rm -f  /private/var/mobile/Library/ControlCenter/ModuleConfiguration_CCSupport.plist

# Cleanup files from the "Cephei" package.
rm -rf /Library/Frameworks/Cephei.framework
rm -rf /Library/Frameworks/CepheiPrefs.framework
rm -f  /usr/bin/defaults
rm -rf /usr/lib/Cephei.framework
rm -rf /usr/lib/Cepheiprefs.framework
rm -f  /usr/lib/libcephei.dylib
rm -f  /usr/lib/libcepheiprefs.dylib
rm -f  /usr/lib/libhbangcommon.dylib
rm -f  /usr/lib/libhbangprefs.dylib

# Cleanup files from the "CertRemainTime" package.
rm -rf /Applications/CertRemainTime.app

# Cleanup files from the CircuitBreaker package.
rm -rf /Applications/circuitbreaker.app/
rm -f  /private/var/mobile/Library/Preferences/aaa.thecomputerwhisperer.fuku.plist
rm -f  /private/var/mobile/Library/Preferences/com.thecomputerwhisperer.cbtweaks.plist
rm -f  /private/var/mobile/Library/Preferences/com.thecomputerwhisperer.cbprefs.plist
rm -f  /private/var/mobile/Library/Preferences/com.thecomputerwhisperer.CBPrefsList.plist
rm -f  /private/var/mobile/Library/Preferences/com.thecomputerwhisperer.CircuitBreakerPrefs.plist

# Cleanup files from the CocoaTop app.
rm -rf /Applications/CocoaTop.app
rm -rf /private/var/mobile/Library/Caches/ru.domo.CocoaTop
rm -rf /private/var/mobile/Library/Caches/Snapshots/ru.domo.CocoaTop
rm -f  /private/var/mobile/Library/Preferences/ru.domo.CocoaTop.plist
rm -f  /private/var/root/Library/Preferences/ru.domo.CocoaTop.plist

# Cleanup files from the "Confidential & Proprietary" package.
rm -f /private/var/mobile/Library/Preferences/com.neinzedd9.confidentialproprietarysettings.plist

# Cleanup files from the "Core Utilities" package.
rm -f  /Library/dpkg/info/coreutils.list
rm -f  /Library/dpkg/info/coreutils.md5sums
rm -f  /etc/profile.d/coreutils.h
rmdir  /etc/profile.d
rm -f  /usr/bin/[
rm -f  /usr/bin/b2sum
rm -f  /usr/bin/base32
rm -f  /usr/bin/base64
rm -f  /usr/bin/basename
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
rm -f  /usr/libexec/coreutils/libstdbuf.so
rmdir  /usr/libexec/coreutils
rm -f  /usr/sbin/chown
rm -f  /usr/sbin/chroot

# Cleanup files from the "Core Utilities (/bin)" package.
rm -f /Library/dpkg/info/coreutils-bin.list
rm -f /Library/dpkg/info/coreutils-bin.md5sums
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
rm -f /usr/bin/df
rm -f /usr/bin/dirname
rm -f /usr/bin/sort

# Cleanup files from the "CrackerXI" package.
rm -rf /Applications/crackerxi.app
rm -rf /var/mobile/Documents/CrackerXI
rm -f  /var/mobile/Library/Preferences/CrackerXIPrefs.plist

# Cleanup files from the CrashReporter package.
rm -rf /Applications/CrashReporter.app
rm -f  /Library/dpkg/info/crash-reporter.crash_reporter.list
rm -f  /Library/dpkg/info/crash-reporter.extrainst_
rm -f  /Library/dpkg/info/crash-reporter.list
rm -f  /Library/dpkg/info/crash-reporter.md5sums
rm -rf /private/var/mobile/Library/CrashReporter
rm -rf /private/var/mobile/Library/Logs/CrashReporter/*.*
rm -f  /private/var/mobile/Library/Preferences/crash-reporter.plist
rm -f  /private/var/mobile/Library/Preferences/jp.ashikase.crashreporter.scanner.plist

# Cleanup files from the "cURL" package.
rm -f  /usr/bin/curl
rm -f  /usr/bin/curl-config
rm -rf /usr/include/curl
rm -f  /usr/lib/libcurl.4.dylib
rm -f  /usr/lib/libcurl.dylib
rm -f  /usr/lib/libcurl.la
rm -f  /usr/lib/pkgconfig/ligcurl.pc

# Cleanup files from the "Cydia (GUI Only)" package.
rm -rf /Applications/Cydia.app
rm -rf /etc/apt/sources.list.d
rm -rf /etc/apt/trusted.gpg.d
rm -rf /usr/libexec/cydia
rm -rf /var/lib/cydia

# Cleanup files from the "Cydia Compatibility Package" package.
rm -f /Library/LaunchDaemons/com.saurik.Cydia.Startup.plist
rm -f /private/var/mobile/Library/Preferences/com.saurik.Cydia.plist

# Cleanup files from the "Darwin CC Tools" package.
rm -f /usr/bin/ar
rm -f /usr/bin/as
rm -f /usr/bin/bitcode_strip
rm -f /usr/bin/check_dylib
rm -f /usr/bin/checksyms
rm -f /usr/bin/cmpdylib
rm -f /usr/bin/codesign_allocate
rm -f /usr/bin/ctf_insert
rm -f /usr/bin/dsymutil
rm -f /usr/bin/indr
rm -f /usr/bin/inout
rm -f /usr/bin/install_name_tool
rm -f /usr/bin/libtool
rm -f /usr/bin/lipo
rm -f /usr/bin/nm
rm -f /usr/bin/nmedit
rm -f /usr/bin/otool
rm -f /usr/bin/pagestuff
rm -f /usr/bin/ranlib
rm -f /usr/bin/redo_prebinding
rm -f /usr/bin/seg_addr_table
rm -f /usr/bin/seg_hack
rm -f /usr/bin/segedit
rm -f /usr/bin/size
rm -f /usr/bin/strings
rm -f /usr/bin/strip
rm -f /usr/bin.ipo

# Cleanup files from the "Darwin Tools" package.
rm -f /usr/bin/sw_vers
rm -f /usr/sbin/startupfiletool

# Cleanup files from the "DayNightSwitch" package.
rm -f /private/var/mobile/Library/Preferences/de.finngaida.daynightswitch.plist

# Cleanup files from the "Debian Packager" package.
rm -rf /etc/alternatives
rm -rf /etc/dpkg
rm -f  /sbin/update_dyld_shared_cache
rm -f  /usr/bin/dpkg
rm -f  /usr/bin/dpkg-architecture
rm -f  /usr/bin/dpkg-buildflags
rm -f  /usr/bin/dpkg-buildpackage
rm -f  /usr/bin/dpkg-checkbuilddeps
rm -f  /usr/bin/dpkg-deb
rm -f  /usr/bin/dpkg-distaddfile
rm -f  /usr/bin/dpkg-divert
rm -f  /usr/bin/dpkg-genbuildinfo
rm -f  /usr/bin/dpkg-genchanges
rm -f  /usr/bin/dpkg-gencontrol
rm -f  /usr/bin/dpkg-gensymbols
rm -f  /usr/bin/dpkg-maintscript-helper
rm -f  /usr/bin/dpkg-mergechangelogs
rm -f  /usr/bin/dpkg-name
rm -f  /usr/bin/dpkg-parsechangelog
rm -f  /usr/bin/dpkg-query
rm -f  /usr/bin/dpkg-scanpackages
rm -f  /usr/bin/dpkg-scansources
rm -f  /usr/bin/dpkg-shlibdeps
rm -f  /usr/bin/dpkg-source
rm -f  /usr/bin/dpkg-split
rm -f  /usr/bin/dpkg-statoverride
rm -f  /usr/bin/dpkg-trigger
rm -f  /usr/bin/dpkg-vendor
rm -f  /usr/bin/dselect
rm -f  /usr/bin/update-alternatives
rm -rf /usr/include/dpkg
rm -f  /usr/lib/libdpkg.a
rm -f  /usr/lib/libdpkg.la
rm -rf /usr/lib/pkgconfig
rm -rf /usr/share/dpkg
rm -f  /var/lib/dpkg

# Cleanup files from the "Debian Utilities" package.
rm -f /bin/run-parts

# Cleanup files from the "Debkeeper" package.
rm -f /private/var/mobile/Library/Preferences/net.tateu.debkeeper.plist

# Cleanup files from the "DetailCellularUsage" package.
rm -f /private/var/mobile/Library/Preferences/com.thecomputerwhisperer.DCUSettings.plist

# Cleanup files from the "DetailedPowerUsage" package.
rm -f  /Library/dpkg/info/com.thecomputerwhisperer.detailedpowerusage.list
rm -f  /Library/dpkg/info/com.thecomputerwhisperer.detailedpowerusage.md5sums
rm -f  /Library/dpkg/info/com.thecomputerwhisperer.detailedpowerusage.postinst
rm -rf /Library/Application\ Support/DPUTweakResources
rm -f  /private/var/mobile/Library/Preferences/com.thecomputerwhisperer.DetailedPowerUsage.plist

# Cleanup files from the "Developer-Cmds" package.
rm -f /usr/bin/ctags
rm -f /usr/bin/hexdump
rm -f /usr/bin/rpcgen
rm -f /usr/bin/unifdef

# Cleanup files from the "Diff Utilities" package.
rm -f /usr/bin/cmp
rm -f /usr/bin/diff
rm -f /usr/bin/diff3
rm -f /usr/bin/sdiff

# Cleanup files from the "DiskDev Cmds" package.
rm -f /sbin/fstyp
rm -f /sbin/fstyp_msdos
rm -f /sbin/fstyp_ntfs
rm -f /sbin/fstyp_udf
rm -f /sbin/mount_devfs
rm -f /sbin/mount_fdesc
rm -f /sbin/quotacheck
rm -f /sbin/umount
rm -f /usr/bin/quota
rm -f /usr/libexec/vndevice
rm -f /usr/sbin/dev_mkdb
rm -f /usr/sbin/edquota
rm -f /usr/sbin/fdisk
rm -f /usr/sbin/quota
rm -f /usr/sbin/quotaon
rm -f /usr/sbin/vsdbutil

# Cleanup files from the "Duo" package.
rm -f /private/var/mobile/Library/Preferences/com.muirey03.duo.plist
rm -f /private/var/mobile/Library/Preferences/com.muirey03.duoprefs.plist

# Cleanup files from the "Evelyn's Repo Icons"
rm -f /Applications/Cydia.app/Sections/Anemone_Fonts.png
rm -f /Applications/Cydia.app/Sections/CustomCovers.png
rm -f /Applications/Cydia.app/Sections/Fonts_for_Anemone.png
rm -f /Applications/Cydia.app/Sections/Homescreen_Widgets.png
rm -f /Applications/Cydia.app/Sections/Lockscreen_Widgets.png
rm -f /Applications/Cydia.app/Sections/Others.png
rm -f /Applications/Cydia.app/Sections/Tweak_Mode_Fonts.png

# Cleanup files from the Extender package.
rm -rf /Applications/Extender.app
rm -f  /bin/jtoold
rm -rf /Library/Switches/Ext3nderSwitch.bundle
rm -rf /private/var/Ext3nder-Installer
rm -rf /private/var/mobile/Documents/Ext3nder
rm -rf /private/var/mobile/Library/Caches/com.cydia.Ext3nder
rm -f  /private/var/mobile/Library/Preferences/com.cydia.Ext3nder.plist
rm -f  /private/var/mobile/Library/Preferences/com.julioverne.ext3nder.autosign.plist
rm -f  /private/var/mobile/Library/SpringBoard/ApplicationShortcuts/com.cydia.Ext3nder.plist

# Cleanup files from the "Fake GPS Pro" package.
rm -f  /Library/dpkg/info/cn.tinyapps.xgpslite.list
rm -f  /Library/dpkg/info/cn.tinyapps.xgpslite.postrm
rm -f  /private/var/mobile/Documents/favorites.plist
rm -rf /private/var/mobile/Library/.umeng
rm -f  /private/var/mobile/Library/Caches/.cn.tinyapps.XGPSLite_umeng.plist
rm -f  /private/var/mobile/Library/Caches/.cn.tinyapps.XGPSPro_umeng.plist
rm -rf /private/var/mobile/Library/Caches/cn.tinyapps.XGPSLite
rm -rf /private/var/mobile/Library/Caches/cn.tinyapps.XGPSPro
rm -f  /private/var/mobile/Library/Preferences/cn.tinyapps.XGPSLite.plist
rm -f  /private/var/mobile/Library/Preferences/cn.tinyapps.XGPSPro.plist
rm -f  /private/var/mobile/Library/Preferences/net.85819.ios.OTRLocation.plist
rm -f  /private/var/mobile/Library/Preferences/otrlocation.app.85819.net.plist
rm -rf /private/var/mobile/Library/WebKit/cn.tinyapps.XGPSLite

# Cleanup files from the "File" package.
rm -f /usr/bin/file
rm -f /usr/inlude/magic.h
rm -f /usr/lib/libmagic.1.dylib
rm -f /usr/lib/ligmagic.dylib
rm -f /usr/share/misc/magic.mgc

# Cleanup files from the "File-Cmds" package.
rm -f /usr/bin/chflags
rm -f /usr/bin/compress
rm -f /usr/bin/ipcrm
rm -f /usr/bin/ipcs
rm -f /usr/bin/pax

# Cleanup files for the "Fileza, FilzaEscaped, FilzaElectrocuted" packages.
rm -rf /Applications/Filza.app
rm -f  /Library/dpkg/info/com.tigisoftware.filza.list
rm -f  /Library/dpkg/info/com.tigisoftware.filza.md5sums
rm -f  /Library/dpkg/info/com.tigisoftware.filza.postinst
rm -f  /Library/dpkg/info/com.tigisoftware.filza.postrm
rm -f  /Library/dpkg/info/com.tigisoftware.filza.prerm
rm -f  /Library/LaunchDaemons/com.tigisoftware.filza.helper.plist
rm -rf /private/var/mobile/Library/Application\ Support/Containers/com.scroublepokemon.filzaelectrocuted
rm -rf /private/var/mobile/Library/Application\ Support/Containers/com.tigisoftware.Filza
rm -rf /private/var/mobile/Library/Caches/com.scroublepokemon.filzaelectrocuted
rm -rf /private/var/mobile/Library/Caches/com.tigisoftware.Filza
rm -rf /private/var/mobile/Library/Caches/Snapshots/com.tigisoftware.Filza
rm -rf /private/var/mobile/Library/Filza
rm -f  /private/var/mobile/Library/Preferences/com.dry05.filzaescaped*.plist
rm -f  /private/var/mobile/Library/Preferences/com.tigisoftware.Filza.plist
rm -f  /private/var/root/Library/Preferences/com.scroublepokemon.filzaescaped.plist
rm -f  /private/var/root/Library/Preferences/com.scroublepokemon.filzaescaped.plist.*
rm -f  /usr/bin/Filza
rm -rf /usr/libexec/filza

# Cleanup files from the "Find Utilities" package.
rm -f  /usr/bin/find
rm -f  /usr/bin/locate
rm -f  /usr/bin/updatedb
rm -f  /usr/bin/xargs
rm -f  /usr/libexec/bigram
rm -f  /usr/libexec/code
rm -f  /usr/libexec/frcode
rm -rf /var/cache/findutils

# Cleanup files from the "Flame" package.
rm -f  /etc/apt/apt.conf.d/flameTimeout
rm -rf /Library/Application\ Support/Flame
rm -rf /private/var/mobile/Library/Application\ Support/Flame
rm -f  /private/var/mobile/Library/Preferences/com.aditkamath.flame.plist

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

# Cleanup files from the "Flipswitch" package.
rm -f  /Library/Flipswitch/libFlipswitchSpringBoard.dylib
rm -f  /Library/Flipswitch/libFlipswitchSwitches.dylib
rm -rf /Library/Flipswitch
rm -rf /Library/Switches/3G.bundle
rm -rf /Library/Switches/AirplaneMode.bundle
rm -rf /Library/Switches/AutoBrightness.bundle
rm -rf /Library/Switches/Autolock.bundle
rm -rf /Library/Switches/Bluetooth.bundle
rm -rf /Library/Switches/Data.bundle
rm -rf /Library/Switches/DoNotDisturb.bundle
rm -rf /Library/Switches/Flashlight.bundle
rm -rf /Library/Switches/FuturemindAdBlock.bundle
rm -rf /Library/Switches/Hotspot.bundle
rm -rf /Library/Switches/Location.bundle
rm -rf /Library/Switches/LowPower.bundle
rm -rf /Library/Switches/LTE.bundle
rm -rf /Library/Switches/NightShift.bundle
rm -rf /Library/Switches/RecordScreen.bundle
rm -rf /Library/Switches/Respring.bundle
rm -rf /Library/Switches/Ringer.bundle
rm -rf /Library/Switches/Rotation.bundle
rm -rf /Library/Switches/RotationLock.bundle
rm -rf /Library/Switches/Settings.bundle
rm -rf /Library/Switches/Vibration.bundle
rm -rf /Library/Switches/VPN.bundle
rm -rf /Library/Switches/Wifi.bundle
rm -rf /Library/Switches/WifiProxy.bundle
rm -f  /usr/bin/switch
rm -rf /usr/include/flipswitch
rm -f  /usr/lib/libflpswitch.dylib

# Cleanup files from the "Floating Dock" package.
rm -f /private/var/mobile/Library/Preferences/com.imkpatil.floatingdock.plist

# Cleanup files from the "FloatyDock" package.
rm -f /private/var/mobile/Library/Preferences/com.synnyg.floatydockprefs.plist

# Cleanup files from the "FrontPage" package.
rm -rf /Library/FrontPage
rm -f  /private/var/mobile/Documents/FrontPage.plist
rm -rf /private/var/mobile/Library/FrontPage
rm -rf /private/var/mobile/Library/FrontPageCache
rm -f  /private/var/mobile/Library/Preferences/com.junesiphone.frontpage.plist

# Cleanup files from the "Gawk" package.
rm -f  /etc/profile.d/gawk.csh
rm -f  /etc/profile.d/gawk.sh
rmdir  /etc/profile.d
rm -f  /usr/bin/awk
rm -f  /usr/bin/gawk
rm -f  /usr/include/gawkapi.h
rm -rf /usr/lib/gawk
rm -rf /usr/libexec/awk
rm -rf /usr/share/awk

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

# Cleanup files from the "GIT" package.
rm -f  /usr/bin/git
rm -f  /usr/bin/git-cvsserver
rm -f  /usr/bin/git-receive-pack
rm -f  /usr/bin/git-shell
rm -f  /usr/bin/git-upload-archive
rm -f  /usr/bin/git-upload-pack
rm -f  /usr/bin/gitk
rm -rf /usr/lib/perl5/site_perl
rm -rf /usr/libexec/git-core
rm -rf /usr/Library
rm -rf /usr/share/git-core
rm -rf /usr/share/git-gui
rm -rf /usr/share/gitk
rm -rf /usr/share/gitweb
rm -f  /usr/share/man/man3/Git*.3pm
rm -f  /var/root/.gitconfig

# Cleanup files from the "GNU Cryptography" package.
rm -f  /usr/bin/dumpsexp
rm -f  /usr/bin/hmac256
rm -f  /usr/bin/libgcryptconfig
rm -f  /usr/bin/libgcrypt-config
rm -f  /usr/bin/mpicalc
rm -f  /usr/include/gcrypt.h
rm -f  /usr/lib/libgcrypt.20.dylib
rm -f  /usr/lib/libgcrypt.dylib
rm -f  /usr/lib/libgcrypt.la
rm -f  /usr/share/aclocal/libgcrypt.m4
rmdir  /usr/share/aclocal

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
rmdir  /usr/share/aclocal
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
rmdir  /usr/lib/pkgconfig

# Cleanup files from the "GPSCheat" package.
rm -rf /Library/Switches/GPSCheatSwitch.bundle
rm -f  /private/var/mobile/Documents/favorites.plist
rm -f  /private/var/mobile/Library/Preferences/com.zx.GPSCheatData.plist
rm -f  /private/var/mobile/Library/Preferences/com.zx.GPSCheatSettings.plist

# Cleanup files from the "Grep" package.
rm -f /bin/egrep
rm -f /bin/fgrep
rm -f /bin/grep
rm -f /Library/dpkg/info/grep.list

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

# Cleanup files from the "Hide Statusbar Items" package from Junes Iphone.
rm -f /private/var/mobile/Library/Preferences/com.junesiphone.hidestatusbaritems.plist

# Cleanup files from the iCleaner package.
rm -rf /Applications/iCleaner.app
rm -rf /Library/Activator/Listeners/com.exile90.icleaner.activator.clean
rm -rf /Library/Activator/Listeners/com.exile90.icleaner.activator.cleannopopup
rm -rf /Library/Switches/ICClean.bundle
rm -rf /Library/Switches/ICCleanNP.bundle
rm -f  /usr/bin/icleaner
rm -rf /var/mobile/Library/iCleaner
rm -rf /var/mobile/Library/Caches/com.exile90.icleanerpro
rm -rf /var/mobile/Library/Caches/Snapshots/com.exile90.icleanerpro
rm -rf /var/mobile/Library/WebKit/com.exile90.icleanerpro
rm -f  /var/root/Library/Preferences/com.applovin.sdk.y7Dm.plist
rm -f  /var/root/Library/Preferences/com.exile90.icleanerpro.plist
rm -rf /var/tmp/com.exile90.icleanerpro

# Cleanup files from the "Icon Renamer" package.
rm -f /private/var/mobile/Library/Preferences/ch.rpetri.iconrenamer.plist

# Cleanup files from the "Iconoclasm" package.
rm -rf /Library/Iconoclasm
rm -f  /private/var/mobile/Library/Preferences/net.r-ch.iconoclasm.plist
rm -rf /System/Library/PreferenceBundles/IconoclasmPrefs.bundle

# Cleanup files from the "Iconsupport" package.
rm -rf /Library/Application\ Support/IconSupport

# Cleanup files from the "Inet-Utils" package.
rm -f /usr/bin/dnsdomainname
rm -f /usr/bin/ftp
rm -f /usr/bin/hostname
rm -f /usr/bin/ifconfig
rm -f /usr/bin/logger
rm -f /usr/bin/ping
rm -f /usr/bin/ping6
rm -f /usr/bin/rcp
rm -f /usr/bin/rexec
rm -f /usr/bin/rlogin
rm -f /usr/bin/rsh
rm -f /usr/bin/talk
rm -f /usr/bin/telnet
rm -f /usr/bin/tftp
rm -f /usr/bin/traceroute
rm -f /usr/bin/whois
rm -f /usr/libexec/ftpd
rm -f /usr/libexec/inetd
rm -f /usr/libexec/rexecd
rm -f /usr/libexec/rlogind
rm -f /usr/libexec/rshd
rm -f /usr/libexec/syslogd
rm -f /usr/libexec/talkd
rm -f /usr/libexec/telnetd
rm -f /usr/libexec/tftpd
rm -f /usr/libexec/uucpd

# Cleanup files from the "kern-utils" package.
rm -f /usr/bin/kdump
rm -f /usr/bin/kinfo
rm -f /usr/bin/kmap
rm -f /usr/bin/kmem
rm -f /usr/bin/kpatch
rm -f /usr/bin/nvpatch

# Cleanup files from the "Kiiimo Repo Icons"
rm -f /Applications/Cydia.app/Sections/10_iOS.png
rm -f /Applications/Cydia.app/Sections/APPS_HACK.png
rm -f /Applications/Cydia.app/Sections/Applications_To.png
rm -f /Applications/Cydia.app/Sections/Apps_cracked.png
rm -f /Applications/Cydia.app/Sections/Font_for_Anemone.png
rm -f /Applications/Cydia.app/Sections/Fonts_iOS_8.png
rm -f /Applications/Cydia.app/Sections/Hacks_Game.png
rm -f /Applications/Cydia.app/Sections/IOS_10.x_64bit_10.png
rm -f /Applications/Cydia.app/Sections/IOS_Apps.png
rm -f /Applications/Cydia.app/Sections/Pp25.png
rm -f /Applications/Cydia.app/Sections/Supports_iOS_11.png
rm -f /Applications/Cydia.app/Sections/System_iOS_11.png
rm -f /Applications/Cydia.app/Sections/Theme_Lockgyph.png
rm -f /Applications/Cydia.app/Sections/Theme_lockscreen.png
rm -f /Applications/Cydia.app/Sections/Themes_10.2.1_-_10.png
rm -f /Applications/Cydia.app/Sections/Themes_bar.png
rm -f /Applications/Cydia.app/Sections/Tv10.png
rm -f /Applications/Cydia.app/Sections/i-Tweaks_Add_Language_Arabic.png
rm -f /Applications/Cydia.app/Sections/iOS_10.2.1_-__iOS_10.png
rm -f /Applications/Cydia.app/Sections/iOS_10.x_32bit_10.png
rm -f /Applications/Cydia.app/Sections/iOS_11.3x.png
rm -f /private/var/mobile/Library/Caches/com.saurik.Cydia/LocalStorage/*kiiimo*.*

# Cleanup files from the "KSBA" package.
rm -f  /usr/bin/ksba-config
rm -f  /usr/include/ksba.h
rm -f  /usr/lib/libksba.8.dylib
rm -f  /usr/lib/libksba.dylib
rm -f  /usr/lib/libksba.la
rm -f  /usr/share/aclocal/ksba.m4
rmdir  /usr/share/aclocal

# Cleanup files from the "LD64" package.
rm -f /usr/bin/ObjectDump
rm -f /usr/bin/dyldinfo
rm -f /usr/bin/ld
rm -f /usr/bin/machocheck
rm -f /usr/bin/unwinddump
rm -f /usr/lib/libtapi.dylib

# Cleanup files from the "less" package.
rm -f /usr/bin/less
rm -f /usr/bin/lessecho
rm -f /usr/bin/lesskey
rm -f /usr/bin/more

# Cleanup files from the "libColorPicker" package.
rm -f /private/var/mobile/Library/Preferences/com.pixelfiredev.libcolorpicker.plist
rm -f /usr/lib/libcolorpicker.dylib

# Cleanup files from the "libCrashReport" package.
rm -f  /Library/dpkg/info/com.ashikase.libcrashreport.list
rm -f  /Library/dpkg/info/com.ashikase.libcrashreport.md5sums
rm -rf /usr/include/libcrashreport
rm -f  /usr/lib/libcrashreport.dylib

# Cleanup files from the "libCSColorPicker" package
rm -f /usr/lib/libCSColorPicker.dylib

# Cleanup files from the "libCSPreferences" package.
rm -f /usr/bin/almighty
rm -f /usr/lib/libCSPUtilities.dylib
rm -f /usr/lib/libCSPreferences.dylib
rm -f /usr/lib/libCSPreferencesProvider.dylib

# Cleanup files from the "libImagePicker" package.
rm -f /usr/lib/libimagepicker.dylib

# Cleanup files from the "Liberty" and "Liberty Lite" package.
rm -f /Library/dpkg/info/com.ryleyangus.libertylite.list
rm -f /Library/dpkg/info/com.ryleyangus.libertylite.md5sums
rm -f /private/var/mobile/Library/Preferences/com.ryleyangus.liberty.plist
rm -f /private/var/mobile/Library/Preferences/com.ryleyangus.libertylite.plist
rm -f /usr/lib/Liberty.dylib

# Cleanup files from the "libidn2" package.
rm -f /usr/bin/idn2
rm -f /usr/include/idn2.h
rm -f /usr/lib/libidn2.0.dylib
rm -f /usr/lib/libidn2.dylib
rm -f /usr/lib/libidn2.la
rm -f /usr/lib/pkgconfig/libidn2.pc
rmdir /usr/lib/pkgconfig

# Cleanup files from the "libPackageInfo" package.
rm -f  /Library/dpkg/info/com.ashikase.libpackageinfo.list
rm -f  /Library/dpkg/info/com.ashikase.libpackageinfo.md5sums
rm -rf /usr/include/libpackageinfo
rm -f  /usr/lib/libpackageinfo.dylib

# Cleanup files from the "libResolve" package.
rm -f /usr/lib/libresolv.9.dylib
rm -f /usr/lib/libresolv.dylib

# Cleanup files from the "libRocket" package.  
rm -f  /usr/lib/libRocket.dylib
rm -rf /var/rocket_stashed

# Cleanup files from the "libSwift4" package.
rm -rf /usr/lib/libswift

# Cleanup files from the "libSymbolicate" package.
rm -f  /Library/dpkg/info/com.ashikase.libsymbolicate.list
rm -f  /Library/dpkg/info/com.ashikase.libsymbolicate.md5sums
rm -rf /usr/include/libsymbolicate
rm -f  /usr/lib/libsymbolicate.dylib

# Cleanup files from the "libTasn1" package.
rm -f /usr/bin/asn1Coding
rm -f /usr/bin/asn1Decoding
rm -f /usr/bin/asn1Parser
rm -f /usr/include/libtasn1.h
rm -f /usr/lib/libtasn1.6.dylib
rm -f /usr/lib/libtasn1.dylib
rm -f /usr/lib/libtasn1.la
rm -f /usr/lib/pkgconfig/libtasn1.pc
rmdir /usr/lib/pkgconfig

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
rm -rf /usr/include/unistring
rm -f  /usr/include/unitypes.h
rm -f  /usr/include/uniwbrk.h
rm -f  /usr/include/uniwidth.h
rm -f  /usr/lib/libunistring.2.dylib
rm -f  /usr/lib/libunistring.dylib
rm -f  /usr/lib/libunistring.la

# Cleanup files from the "Link Identity Editor" package.
rm -f /usr/bin/ldid

# Cleanup files from the "LittleX" package.
rm -f /private/var/mobile/Library/Preferences/com.ioscreatix.littlex.plist

# Cleanup files from the "LLVM+Clang (64 bit)" package.
rm -f /usr/bin/bugpoint
rm -f /usr/bin/c-index-test
rm -f /usr/bin/clang
rm -f /usr/include/clang-c
rm -f /usr/bin/clang++
rm -f /usr/bin/clang-5.0
rm -f /usr/bin/clang-check
rm -f /usr/bin/clang-cl
rm -f /usr/bin/clang-cpp
rm -f /usr/bin/clang-format
rm -f /usr/bin/clang-import-test
rm -f /usr/bin/clang-offload-bundler
rm -f /usr/bin/clang-rename
rm -f /usr/bin/git-clang-format
rm -f /usr/bin/ld.lld
rm -f /usr/bin/llc
rm -f /usr/bin/lld
rm -f /usr/bin/lld-link
rm -f /usr/bin/lli
rm -f /usr/bin/llvm-ar
rm -f /usr/bin/llvm-as
rm -f /usr/bin/llvm-bcanalyzer
rm -f /usr/bin/llvm-c-test
rm -f /usr/bin/llvm-cat
rm -f /usr/bin/llvm-config
rm -f /usr/bin/llvm-cov
rm -f /usr/bin/llvm-cvtres
rm -f /usr/bin/llvm-cxxdump
rm -f /usr/bin/llvm-cxxfilt
rm -f /usr/bin/llvm-diff
rm -f /usr/bin/llvm-dis
rm -f /usr/bin/llvm-dlltool
rm -f /usr/bin/llvm-dsymutil
rm -f /usr/bin/llvm-dwarfump
rm -f /usr/bin/llvm-dwp
rm -f /usr/bin/llvm-extract
rm -f /usr/bin/llvm-lib
rm -f /usr/bin/llvm-link
rm -f /usr/bin/llvm-lto
rm -f /usr/bin/llvm-lto2
rm -f /usr/bin/llvm-mc
rm -f /usr/bin/llvm-mcmarkup
rm -f /usr/bin/llvm-modextract
rm -f /usr/bin/llvm-mt
rm -f /usr/bin/llvm-nm
rm -f /usr/bin/llvm-objdump
rm -f /usr/bin/llvm-opt-report
rm -f /usr/bin/llvm-pdutil
rm -f /usr/bin/llvm-profdata
rm -f /usr/bin/llvm-ranlib
rm -f /usr/bin/llvm-readelf
rm -f /usr/bin/llvm-readobj
rm -f /usr/bin/llvm-rtdylid
rm -f /usr/bin/llvm-size
rm -f /usr/bin/llvm-split
rm -f /usr/bin/llvm-stress
rm -f /usr/bin/llvm-strings
rm -f /usr/bin/llvm-symbolizer
rm -f /usr/bin/llvm-tblgen
rm -f /usr/bin/llvm-xray
rm -f /usr/bin/obj2yaml
rm -f /usr/bin/opt
rm -f /usr/bin/sancov
rm -f /usr/bin/sanstats
rm -f /usr/bin/scan-build
rm -f /usr/bin/scan-view
rm -f /usr/bin/set-xcode-analyzer
rm -f /usr/bin/verify-uselistorder
rm -f /usr/bin/yaml2obj
rm -f /usr/include/BugpointPasses.dylib
rm -f /usr/include/LLVMHello.dylib
rm -f /usr/include/clang
rm -f /usr/include/clang-c
rm -f /usr/include/lld
rm -f /usr/include/llvm
rm -f /usr/include/llvm-c
rm -f /usr/include/cmake
rm -f /usr/include/libLTO.dylib
rm -f /usr/include/libclang.dylib
rm -f /usr/lib/BugpointPasses.dylib
rm -f /usr/lib/clang
rm -f /usr/lib/cmake
rm -f /usr/lib/libLTO.dylib
rm -f /usr/lib/libclang.dylib
rm -rf /usr/share/llvm

# Cleanup files from the "Locale Profiles in UTF-8" package.
rm -f  /etc/profile.d/localeutf8.sh
rmdir  /etc/profile.d
rm -rf /usr/share/locale

# Cleanup files from the "LocalIAPStore" package.
rm -f /Library/dpkg/info/com.hackyouriphone.localiapstore.list
rm -f /Library/dpkg/info/com.hackyouriphone.localiapstore.md5sums
rm -f /private/var/mobile/Library/Preferences/anondev.LocalIAPStore.plist

# Cleanup files from the "LocalSSH" package.
rm -f /usr/libexec/localssh-keygen-wrapper

# Cleanup files from the "Lockplus" package.
rm -rf /Library/LockPlus
rm -rf /private/var/mobile/Documents/lockplusfonts
rm -rf /private/var/mobile/Library/LockPlus
rm -f  /private/var/mobile/Library/Preferences/com.junesiphone.lockplus.plist

# Cleanup files from the "lsof" package.
rm -f /usr/sbin/lsof

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
rmdir /usr/lib/pkgconfig

# Cleanup files from the "lzma" package.
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

# Cleanup files from the "Midevice" tweak package.
rm -f /private/var/mobile/Library/Preferences/net.dodtweaks.mdprefs.plist

# Cleanup files from the "Mikoto" package.
rm -f  /Library/dpkg/info/net.angelxwind.mikoto.list
rm -f  /Library/dpkg/info/net.angelxwind.mikoto.md5sums
rm -f  /Library/dpkg/info/net.angelxwind.mikoto.postrm
rm -rf /Library/KarenLocalizer
rm -rf /Library/KarenRepoIcons
rm -f  /private/var/mobile/Library/Preferences/net.angelxwind.mikoto.plist
rm -f  /usr/lib/libkarenlocalizer.dylib
rm -f  /usr/lib/libkarenprefs.dylib

# Cleanup files from the "Mojito" theme.
rm -f  /private/var/mobile/Library/Preferences/eu.bednarz.eyeris.plist

# Cleanup files from the "Moveable9" package.
rm -rf /private/var/mobile/Library/Preferences/Moveable
rm -f  /private/var/mobile/Library/Preferences/net.tateu.moveable9.plist
rm -f  /private/var/mobile/Library/Preferences/net.tateu.moveable9.profileswitcher.plist
rm -f  /private/var/mobile/Library/Preferences/net.tateu.moveable9_Apps.plist
rm -f  /private/var/mobile/Library/Preferences/net.tateu.moveable9_Homescreen.plist

# Cleanup files from the Nano package.
rm -f  /etc/nanorc
rm -f  /etc/profile.d/nano.sh
rmdir  /etc/profile.d
rm -f  /Library/dpkg/info/nano.list
rm -f  /Library/dpkg/info/nano.md5sums
rm -f  /usr/bin/nano
rm -f  /usr/bin/rnano
rm -rf /usr/share/nano

# Cleanup files from the "Nettle" package.
rm -f  /usr/bin/nettle-hash
rm -f  /usr/bin/nettle-lfib-stream
rm -f  /usr/bin/nettle-pbkdf2
rm -f  /usr/bin/pkcs1-conv
rm -f  /usr/bin/sexp-conv
rm -rf /usr/include/nettle
rm -f  /usr/lib/libhogweed.4.4.dylib
rm -f  /usr/lib/libhogweed.4.dylib
rm -f  /usr/lib/libhogweed.dylib
rm -f  /usr/lib/libnettle.6.4.dylib
rm -f  /usr/lib/libnettle.6.dylib
rm -f  /usr/lib/libnettle.dylib
rm -f  /usr/lib/pkgconfig/hogweed.pc
rm -f  /usr/lib/pkgconfig/nettle.pc
rmdir  /usr/lib/pkgconfig

# Cleanup files from the "Network-Cmds" package.
rm -f /sbin/netstat
rm -f /sbin/route
rm -f /usr/libexec/kdumpd
rm -f /usr/sbin/arp
rm -f /usr/sbin/ndp
rm -f /usr/sbin/traceroute6

# Cleanup files from the "New Curses 5 and New Curses 6" packages.
rm -f  /Library/dpkg/info/ncurses.list
rm -f  /Library/dpkg/info/ncurses.md5sums
rm -f  /usr/bin/captoinfo
rm -f  /usr/bin/clear
rm -f  /usr/bin/infocmp
rm -f  /usr/bin/infotocap
rm -f  /usr/bin/ncurses5-config
rm -f  /usr/bin/ncurses6-config
rm -f  /usr/bin/ncursesw5-config
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
rm -f  /usr/lib/libform.5.dylib
rm -f  /usr/lib/libform.6.dylib
rm -f  /usr/lib/libform.a
rm -f  /usr/lib/libform.dylib
rm -f  /usr/lib/libform_g.a
rm -f  /usr/lib/libform5.dylib
rm -f  /usr/lib/libformw.5.dylib
rm -f  /usr/lib/libformw.6.dylib
rm -f  /usr/lib/libformw.dylib
rm -f  /usr/lib/libformw5.dylib
rm -f  /usr/lib/libmenu.5.dylib
rm -f  /usr/lib/libmenu.6.dylib
rm -f  /usr/lib/libmenu.a
rm -f  /usr/lib/libmenu.dylib
rm -f  /usr/lib/libmenu_g.a
rm -f  /usr/lib/libmenu5.dylib
rm -f  /usr/lib/libmenuw.5.dylib
rm -f  /usr/lib/libmenuw.6.dylib
rm -f  /usr/lib/libmenuw.dylib
rm -f  /usr/lib/libmenuw5.dylib
rm -f  /usr/lib/libncurses.5.dylib
rm -f  /usr/lib/libncurses.6.dylib
rm -f  /usr/lib/libncurses.a
rm -f  /usr/lib/libncurses_g.a
rm -f  /usr/lib/libncurses.dylib
rm -f  /usr/lib/libncurses5.dylib
rm -f  /usr/lib/libncurses6.dylib
rm -f  /usr/lib/libncursesw.5.dylib
rm -f  /usr/lib/libncursesw.6.dylib
rm -f  /usr/lib/libncursesw.dylib
rm -f  /usr/lib/libncursesw5.dylib
rm -f  /usr/lib/libncursesw6.dylib
rm -f  /usr/lib/libpanel.5.dylib
rm -f  /usr/lib/libpanel.6.dylib
rm -f  /usr/lib/libpanel.a
rm -f  /usr/lib/libpanel.dylib
rm -f  /usr/lib/libpanel_g.a
rm -f  /usr/lib/libpanel5.dylib
rm -f  /usr/lib/libpanelw.5.dylib
rm -f  /usr/lib/libpanelw.6.dylib
rm -f  /usr/lib/libpanelw.dylib
rm -f  /usr/lib/libpanelw5.dylib
rm -f  /usr/lib/pkgconfig/form.pc
rm -f  /usr/lib/pkgconfig/formw.pc
rm -f  /usr/lib/pkgconfig/menu.pc
rm -f  /usr/lib/pkgconfig/menuw.pc
rm -f  /usr/lib/pkgconfig/ncurses.pc
rm -f  /usr/lib/pkgconfig/ncursesw.pc
rm -f  /usr/lib/pkgconfig/panel.pc
rm -f  /usr/lib/pkgconfig/panelw.pc
rmdir  /usr/lib/pkgconfig
rm -f  /usr/lib/terminfo
rm -rf /usr/lib/terminfo
rm -rf /usr/share/tabset
rm -rf /usr/share/terminfo

# Cleanup files from the "New GNU Portable Threads" package.
rm -f  /usr/bin/npth-config
rm -f  /usr/include/npth.h
rm -f  /usr/lib/libnpth.0.dylib
rm -f  /usr/lib/libnpth.dylib
rm -f  /usr/lib/libnpth.la
rm -f  /usr/share/aclocal/npth.m4
rmdir  /usr/share/aclocal

# Cleanup files from the "NewTerm2" package.
rm -rf /Applications/NewTerm.app

# Cleanup files from the "NFCWriter" package.
rm -rf /Applications/NFCWriter.app
rm -f  /usr/lib/NFCWritPass.dylib
rm -f  /var/mobile/Library/Preferences/net.limneos.nfcwriter.license
rm -f  /var/mobile/Library/Preferences/nfcd.plist

# Cleanup files from the "Nghttp2" package.
rm -f  /Library/dpkg/info/nghttp2.list
rm -f  /Library/dpkg/info/nghttp2.md5sums
rm -rf /usr/include/nghttp2
rm -f  /usr/lib/libnghttp2.14.dylib
rm -f  /usr/lib/libnghttp2.dylib
rm -f  /usr/lib/libnghttp2.la
rm -f  /usr/lib/pkgconfig/libnghttp2.pc
rmdir  /usr/lib/pkgconfig

# Cleanup files from the "noncereboot11CLI" package.
rm -f /Library/dpkg/info/rocks.stek29.noncereboot11.list
rm -f /Library/dpkg/info/rocks.stek29.noncereboot11.md5sums
rm -f /usr/bin/noncereboot11

# Cleanup files from the "No-Promos" twitter package.
rm -f  /Library/dpkg/info/com.leftyfl1p.nopromostwitter.list
rm -f  /Library/dpkg/info/com.leftyfl1p.nopromostwitter.md5sums

# Cleanup files from the "NoSubstitute (Electra)" package.
rm -f /private/var/mobile/Library/Preferences/co.vexation.nosubstitute.plist

# Cleanup files from the "OpenSSH" package.
rm -f  /Library/LaunchDaemons/com.openssh.sshd.plist
rm -rf /etc/ssh
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

# Cleanup files from the "OpenSSL" package.
rm -f  /etc/ssl/openssl.cnf
rmdir  /etc/ssl/certs
rmdir  /etc/ssl/private
rm -f  /usr/bin/c_rehash
rm -f  /usr/bin/openssl
rm -rf /usr/include/openssl
rm -f  /usr/lib/libcrypto.1.0.0.dylib
rm -f  /usr/lib/libssl.1.0.0.dylib
rm -f  /usr/lib/libcrypto.dylib
rm -f  /usr/lib/libssl.dylib
rm -rf /usr/lib/engines
rm -f  /usr/lib/pkgconfig/libcrypto.pc
rm -f  /usr/lib/pkgconfig/libssl.pc
rm -f  /usr/lib/pkgconfig/openssl.pc
rmdir  /usr/lib/pkgconfig
rm -rf /usr/lib/ssl

# Cleanup files from the "P11Kit" package.
rm -f  /usr/bin/p11-kit
rm -f  /usr/bin/trust
rm -rf /usr/etc
rm -rf /usr/include/p11-kit-1
rm -f  /usr/lib/libp11-kit.0.dylib
rm -f  /usr/lib/libp11-kit.dylib
rm -f  /usr/lib/libp11-kit.la
rm -f  /usr/lib/p11-kit-proxy.dylib
rm -rf /usr/lib/pkcs11
rm -f  /usr/lib/pkgconfig/p11-kit-1.pc
rmdir  /usr/lib/pkgconfig
rm -rf /usr/libexec/p11-kit
rm -rf /usr/share/p11-kit

# Cleanup files from the "Patch" package.
rm -f /usr/bin/patch

# Cleanup files from the "Perl" package.
rm -f  /Library/dpkg/info/perl.list
rm -f  /Library/dpkg/info/perl.md5sums
rm -f  /usr/bin/corelist
rm -f  /usr/bin/cpan
rm -f  /usr/bin/enc2xs
rm -f  /usr/bin/encguess
rm -f  /usr/bin/h2ph
rm -f  /usr/bin/h2xs
rm -f  /usr/bin/instmodsh
rm -f  /usr/bin/json_pp
rm -f  /usr/bin/libnetcfg
rm -f  /usr/bin/perl
rm -f  /usr/bin/perlbug
rm -f  /usr/bin/perldoc
rm -f  /usr/bin/perlivp
rm -f  /usr/bin/perlthanks
rm -f  /usr/bin/piconv
rm -f  /usr/bin/pl2pm
rm -f  /usr/bin/pod2html
rm -f  /usr/bin/pod2man
rm -f  /usr/bin/pod2text
rm -f  /usr/bin/pod2usage
rm -f  /usr/bin/podchecker
rm -f  /usr/bin/podselec
rm -f  /usr/bin/prove
rm -f  /usr/bin/ptar
rm -f  /usr/bin/ptardiff
rm -f  /usr/bin/ptargrep
rm -f  /usr/bin/shasum
rm -f  /usr/bin/splain
rm -f  /usr/bin/xsubpp
rm -f  /usr/bin/zipdetails
rm -rf /usr/lib/perl5
rm -rf /usr/share/man/man1
rm -rf /usr/share/man/man3
rm -rf /usr/share/man/man5
rmdir  /usr/share/man

# Cleanup files from the "Pincrush" package.
rm -f /usr/bin/pincrush

# Cleanup files from the "PLUtil" package.
rm -f /usr/bin/plutil

# Cleanup files from the "PreferenceLoader" package.
rm -f /usr/include/libprefs/prefs.h
rmdir /usr/include/libprefs
rm -f /usr/lib/libprefs.dylib

# Cleanup files from the "Preference Organizer 2" tweak.
rm -f /private/var/mobile/Library/Preferences/net.angelxwind.preferenceorganizer2.plist

# Cleanup files from the "PrefixUI" package.
rm -rf /Library/Frameworks/PrefixUI.framework
rm -f  /com.laughingquoll.prefixui_0.5_iphoneos-arm.deb

# Cleanup files from the "Profile Directory" package.
rm -f  /Library/dpkg/info/profile.d.list
rm -f  /Library/dpkg/info/profile.d.md5sums
rm -f  /etc/profile
rm -f  /etc/profile.d/terminal.sh
rmdir  /etc/profile.d

# Cleanup files from the "PullToRespring" package.
rm -f /Library/dpkg/info/com.sassoty.pulltorespring.list
rm -f /Library/dpkg/info/com.sassoty.pulltorespring.md5sums
rm -f /private/var/mobile/Library/Preferences/com.sassoty.pulltorespring.plist

# Cleanup files from the "Readline" package.
rm -rf /usr/include/readline
rm -f  /usr/lib/libhistory.5.2.dylib
rm -f  /usr/lib/libhistory.5.dylib
rm -f  /usr/lib/libhistory.7.0.dylib
rm -f  /usr/lib/libhistory.7.dylib
rm -f  /usr/lib/libhistory.dylib
rm -f  /usr/lib/libreadline.5.2.dylib
rm -f  /usr/lib/libreadline.5.dylib
rm -f  /usr/lib/libreadline.7.0.dylib
rm -f  /usr/lib/libreadline.7.dylib
rm -f  /usr/lib/libreadline.dylib

# Cleanup files from the "ReformX" package.
rm -rf /Applications/ReformX.app
rm -rf /Library/Application\ Support/ReformX
rm -f  /private/var/mobile/Library/Preferences/com.zestlabs.reformx.current.plist
rm -f  /private/var/mobile/Library/Preferences/com.zestlabs.reformx.plist

# Cleanup files from the "Rocketbootstrap" package.
rm -f /Library/dpkg/info/com.rpetrich.rocketbootstrap.list
rm -f /Library/dpkg/info/com.rpetrich.rocketbootstrap.md5sums
rm -f /Library/dpkg/info/com.rpetrich.rocketbootstrap.postinst
rm -f /Library/dpkg/info/com.rpetrich.rocketbootstrap.prerm
rm -f /usr/include/rocketbootstrap.h
rm -f /usr/include/rocketbootstrap_dynamic.h
rm -f /usr/lib/librocketbootstrap.dylib
rm -r /usr/libexec/_rocketd_reenable
rm -r /usr/libexec/rocketd

# Cleanup files from the "Rocket for Instagram" package.
rm -rf /Library/Application\ Support/Rocket

# Cleanup files from the "Rsync" package.
rm -f  /Library/dpkg/info/rsync.list
rm -f  /Library/dpkg/info/rsync.md5sums
rm -f  /usr/bin/rsync
rm -rf /usr/share/man/man1
rm -rf /usr/share/man/man5

# Cleanup files from the "Screen" package.
rm -f  /usr/bin/screen
rm -rf /usr/share/screen

# Cleanup files from the "Sed" package.
rm -f /bin/sed

# Cleanup files from the "SemiRestore11-Lite" package.
rm -f /usr/bin/SemiRestore11-Lite

# Cleanup files from the "Send Test Bulletin" package.
rm -f /usr/bin/stb

# Cleanup files from the "ShellCmds" package.
rm -f /usr/bin/killall
rm -f /usr/bin/renice
rm -f /usr/bin/script
rm -f /usr/bin/time
rm -f /usr/bin/which

# Cleanup files from the "Smart Low Power Mode" package.
rm -f /private/var/mobile/Library/Preferences/com.smokin1337.smartlpm.plist

# Cleanup files from the "Snowboard" package.
rm -f /Library/dpkg/info/com.spark.snowboard.list
rm -f /Library/dpkg/info/com.spark.snowboard.md5sums
rm -f /private/var/mobile/Library/Preferences/com.spark.snowboardprefs.plist

# Cleanup files from the "Socket Cat" package.
rm -f /usr/bin/filan
rm -f /usr/bin/procan
rm -f /usr/bin/socat

# Cleanup files from the "SpringPlus" package.
rm -f /private/var/mobile/Library/Preferences/com.rishanan.springpref.plist

# Cleanup files from the "SSH Toggle and Port" package.
rm -rf /Library/ControlCenter/Bundles/SSHonCC.bundle
rm -f  /usr/bin/SSHswitch

# Cleanup files from the "Substitute" package.
rm -rf /Library/Frameworks/CydiaSubstrate.framework
rm -f  /usr/lib/libsubstitute.dylib
rm -f  /usr/lib/libsubstrate.dylib
rm -f  /usr/lib/tweakloader.dylib
rm -f  /usr/lib/libsubstitute.0.dylib
rm -f  /usr/lib/libsubstitute.dylib

# Cleanup files from the "Substrate Compatibility Layer" package.
rm -rf /Library/Frameworks/CydiaSubstrate.framework
rm -f  /usr/lib/libsubstrate.dylib

# Cleanup files from the "Sudo" package.
rm -f  /etc/sudoers
rm -rf /etc/sudoers.d
rm -f  /usr/bin/sudo
rm -f  /usr/bin/sudoedit
rm -f  /usr/bin/sudoreplay
rm -f  /usr/include/sudo_plugin.h
rm -rf /usr/libexec/sudo
rm -f  /usr/sbin/visudo
rm -rf /var/db/sudo
rm -rf /var/run/sudo

# Cleanup files from the "SwipeForMore" package.
rm -f /private/var/mobile/Library/Preferences/com.PS.SwipeForMore.plist

# Cleanup files from the "System-Cmds" package.
rm -f /Library/dpkg/info/system-cmds.list
rm -f /bin/sync
rm -f /sbin/dmesg
rm -f /sbin/dynamic_pager
rm -f /sbin/halt
rm -f /sbin/nologin
rm -f /sbin/reboot
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
rm -f /usr/sbin/halt
rm -f /usr/sbin/iostat
rm -f /usr/sbin/mkfile
rm -f /usr/sbin/nologin
rm -f /usr/sbin/pwd_mkdb
rm -f /usr/sbin/reboot
rm -f /usr/sbin/sysctl
rm -f /usr/sbin/vifs
rm -f /usr/sbin/vipw
rm -f /usr/sbin/vsdbutil
rm -f /usr/sbin/zdump
rm -f /usr/sbin/zic

# Cleanup files from the "SystemInfo" package.
rm -f /usr/bin/iofbres
rm -f /usr/bin/nvnonce
rm -f /var/mobile/Documents/ninjalog

# Cleanup files from the "Tape Archive" package.
rm -f /bin/gtar
rm -f /bin/tar
rm -f /usr/bin/tar
rm -f /usr/libexec/rmt

# Cleanup files from the "Tech Support Framework" package.
rm -f  /Library/dpkg/info/jp.ashikase.techsupport.list
rm -f  /Library/dpkg/info/jp.ashikase.techsupport.md5sums
rm -rf /Library/Frameworks/TechSupport.framework

# Cleanup files from the "Theos Dependancies" package.
rm -f /Library/dpkg/info/org.theos.dependencies.list
rm -f /Library/dpkg/info/org.theos.dependencies.md5sums

# Cleanup files from the "Top" package.
rm -f /usr/bin/top
rm -f /usr/include/libtop.h
rm -f /usr/lib/libtop.a

# Cleanup files from the "TSS Saver" app
rm -rf /Applications/TSSSaver.app
rm -rf /private/var/mobile/Library/Caches/co.dynastic.tsssaver
rm -rf /private/var/mobile/Library/Caches/Snapshots/co.dynastic.tsssaver

# Cleanup files from the "Tweak Injector" package.
rm -rf /Applications/SafeMode.app
rm -rf /Library/TweakInject
rm -f  /usr/lib/TweakInject.dylib
rm -rf /usr/lib/TweakInject

# Cleanup files from the "UASharedTools" package.
rm -rf /Library/unlimapps_tweak_resources/uasharedtools
rm -f  /usr/lib/libuasharedanaltyics.dylib
rm -f  /usr/lib/libuasharedanaltyicsflurry.dylib
rm -f  /usr/lib/libuasharedtools.dylib
rm -f  /usr/lib/libuasharedtoolsapplovin.dylib
rm -f  /usr/lib/libuasharedtoolsappnext.dylib
rm -f  /usr/lib/libuasharedtoolsfacebook.dylib
rm -f  /usr/lib/libuasharedtoolsgoogle.dylib
rm -f  /usr/lib/libuasharedtoolsinmobi.dylib
rm -rf /usr/lib/unlimapps_tweak_libs
rm -f  /var/lib/misc/libuasharedanaltyics.dylib
rm -f  /var/lib/misc/libuasharedanaltyicsflurry.dylib
rm -f  /var/lib/misc/libuasharedtools.dylib
rm -f  /var/lib/misc/libuasharedtoolsapplovin.dylib
rm -f  /var/lib/misc/libuasharedtoolsappnext.dylib
rm -f  /var/lib/misc/libuasharedtoolsfacebook.dylib
rm -f  /var/lib/misc/libuasharedtoolsgoogle.dylib
rm -f  /var/lib/misc/libuasharedtoolsinmobi.dylib

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

# Cleanup files from the "Utubed" package.
rm -f /private/var/mobile/Library/Preferences/utubedp.ws.plist
rm -f /private/var/mobile/Library/Preferences/utubedprefs.ws.plist

# Cleanup files from the "UUID Generator" package.
rm -f /usr/bin/uuid
rm -f /usr/bin/uuid-config
rm -f /usr/include/uuid.h
rm -f /usr/lib/libuuid.16.dylib
rm -f /usr/lib/libuuid.dylib
rm -f /usr/lib/pkgconfig/uuid.pc

# Cleanup files from the "Vi IMproved" package.
rm -f  /usr/bin/ex
rm -f  /usr/bin/rview
rm -f  /usr/bin/rvim
rm -f  /usr/bin/vi
rm -f  /usr/bin/view
rm -f  /usr/bin/vim
rm -f  /usr/bin/vimdiff
rm -f  /usr/bin/vimtutor
rm -f  /usr/bin/xxd
rm -rf /usr/share/vim

# Cleanup files from the "WGet" package.
rm -f /etc/wgetrc
rm -f /usr/bin/wget

# Cleanup files from the "Widget Weather GPS" app.
rm -rf /Applications/WidgetWeatherGPS.app
rm -rf /Library/Activator/Listeners/com.sddev.WWRefresh
rm -rf /Library/Activator/Listeners/com.sddev.WWSettings
rm -rf /Library/Application\ Support/WW3
rm -f  /private/var/mobile/Documents/BatteryStats.txt
rm -f  /private/var/mobile/Documents/widgetweather.xml
rm -rf /private/var/mobile/Library/LockHTML/03_WW_OFH_BASE
rm -rf /private/var/mobile/Library/LockHTML/03_WW_OFH_LS
rm -rf /private/var/mobile/Library/Stats
rm -rf /private/var/mobile/Library/WidgetWeather
rm -f  /private/var/mobile/Library/BatteryStats.txt
rm -f  /private/var/mobile/Library/RAMStats.txt

# Cleanup files from the wifiFirmwareUpdater 
rm -rf /private/var/mobile/updatedWifiFirmware
rm -f  /usr/bin/autoflashwifi
rm -f  /usr/bin/flashwifi
rm -f  /usr/bin/revertwifi

# Cleanup files from the "XB-Hide" package.
rm -rf /private/var/mobile/Library/Preferences/com.oly.xbhide.plist

# Cleanup files from the XenHTML package.
rm -rf /Library/Application\ Support/libGitHubIssues
rm -f  /private/var/mobile/Library/Preferences/com.matchstic.xenhtml.plist
rm -rf /usr/include/uaunbox
rm -f  /usr/lib/libGitHubIssues.dylib
rm -f  /usr/lib/libuaunbox.dylib
rm -f  /usr/libexec/uaunbox
rm -f  /usr/libexec/uaunboxdlaunch
rm -f  /usr/include/libGitHubIssues.h

# Cleanup files from the "XZ Utils" package.
rm -f  /usr/bin/lzcat
rm -f  /usr/bin/lzcmp
rm -f  /usr/bin/lzdiff
rm -f  /usr/bin/lzegrep
rm -f  /usr/bin/lzfgrep
rm -f  /usr/bin/lzgrep
rm -f  /usr/bin/lzless
rm -f  /usr/bin/lzma
rm -f  /usr/bin/lzmadec
rm -f  /usr/bin/lzmainfo
rm -f  /usr/bin/lzmore
rm -f  /usr/bin/unlzma
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
rm -f  /usr/lib/liblzma.a
rm -f  /usr/lib/liblzma.la
rm -rf /usr/lib/pkgconfig
rm -f  /usr/lib/pkgconfig/liblzma.pc
rm -f  /usr/local/lib/liblzma.5.dylib
rm -f  /usr/local/lib/liblzma.dylib
rm -f  /usr/local/lib/pkgconfig/liblzma.pc
rm -f  /usr/local/lib/pkgconfig/liblzma.pce
rm -rf /usr/local/lib/pkgconfig

# Cleanup files from the "Youtube Tools" package.
rm -f /private/var/mobile/Library/Preferences/com.justinpetkovic.youtubetools.plist

# Cleanup files from the "Zip" package.
rm -f /usr/bin/zip
rm -f /usr/bin/zipcloak
rm -f /usr/bin/zipnote
rm -f /usr/bin/zipsplit

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
echo "255.255.255.255	broadcasthost"                          >> /etc/hosts
echo "::1             localhost"                                >> /etc/hosts

# Clear cache and remove the last of the system files.
/uninstall/uicache
/uninstall/rm -f /bin/rmdir
/uninstall/rm -f /bin/rm

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
if [ -e /System/Library/Audio/UISounds/SentMessage.caf.bak ]
then
	/uninstall/rm -f /System/Library/Audio/UISounds/SentMessage.caf
	/uninstall/cp    /System/Library/Audio/UISounds/SentMessage.caf.bak /System/Library/Audio/UISounds/SentMessage.caf
	/uninstall/rm -f /System/Library/Audio/UISounds/SentMessage.caf.bak
	/uninstall/touch -t 201804140108.03 /System/Library/Audio/UISounds
fi

# Restore the original Assets.car file in: /System/Library/Frameworks/UIKit.framework/Artwork.bundle
# NOTE, it would be best to do this part manually.  This has to do with the signal dots I put in to 
# replace the signal bars in stock IOS11.
if [ -e /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car.bak ]
then
	/uninstall/rm -f /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car
	/uninstall/cp    /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car.bak /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car
	/uninstall/rm -f /System/Library/Frameworks/UIKit.framework/Artwork.bundle/Assets.car.bak
	/uninstall/touch -t 201804140110.48 /System/Library/Frameworks/UIKit.framework/Artwork.bundle
fi

# Exit the script and notify user they we're done.
echo ""
echo "The script has ended.  Please execute the last few commands manually being sure to go through the remaining files and"
echo "directories that were created after 4/14/2018 2am.  Before you reboot the device be sure all of the files and directories are"
echo "truly gone.  Once you reboot, your device will be fully stock and no traces of the jailbreak should"
echo "remain on the device.  Good luck."
exit

# Search through directories and files that may still have leftovers in them.
/uninstall/find / -type d -newermt '4/14/2018 02:00:00' | sort
/uninstall/find / -type f -newermt '4/14/2018 02:00:00' | sort

# Delete the last of the files & directories.
/uninstall/rm -f  /private/var/root/.bash_history
/uninstall/rm -rf /uninstall



