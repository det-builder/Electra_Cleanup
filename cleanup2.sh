###################################################################
#                                                                 #
# Cleanup.sh                                                      #
#                                                                 #
# This script will remove all traces of the Electra jailbreak     #
# from an iOS device.                                             #
#                                                                 #
# DIRECTIONS for use                                              #
#                                                                 #
# 1) In Cydia, un-install all tweaks that you can.                #
# 2) Respring                                                     #
# 3) Run this script.                                             #
# 4) Pray                                                         #
#                                                                 #
# Usage tips:                                                     #
# rm -rf /DT/test/*                                               #
# This command will delete all files and directories inside of    #
# the /DT/test directory, but, will not delete the test directory #
# itself that resides in /DT                                      #
#                                                                 #
# rm -rf /DT/test                                                 #
# rm -rf /DT/test/                                                #
# Either of these command will delete all files and directories   #
# inside of the /DT/test directory.  AND, it will also delete the #
# test directory inside of the /DT directory.  Be careful         #
#                                                                 #
# Manual deletions:                                               #
# You will need to look through some directories on your own to   #
# find some more files and directories to delete.  These are:     #
#                                                                 #
# /private/var/containers                                         #
# /private/var/mobile/Containers/Data                             #
# /private/var/mobile/Containers/Shared                           #
#                                                                 #
# NOTE:                                                           #
# Apple Watch backups are stored here:                            #
# /private/var/mobile/Library/NanoBackup                          #
###################################################################

# Ensure the user is logged in as root.
if [ "$EUID" -ne 0 ]; then
	echo "ERROR!!!!!  You MUST be logged in as root.  Please"
	echo "logoff and then re-login as root." 
	exit
fi

# Confirm user wishes to continue.
echo "WARNING!!!!  This script will attempt to remove the Electra jailbreak"
echo "from this device.  Please think long and hard before continuing since it"
echo "could cause you to loose your jailbreak!!!"
echo ""
echo "WARNING!!!!! Be sure you fill in the section just below to delete the"
echo "directories related to the bundles.  These will need to be deleted"
echo "for completeness."
echo ""
read -p "Press enter to continue, or, press Control + C to exit"

# Ensure Cydia is not running.
killall Cydia

########################################################################
#                                                                      #
# Delete the directories that contain data for the bundles of the apps #
# that are installed.  These are most likely going to be the apps      #
# installed via Impactor or tweaks that install apps.                  #
#                                                                      #
########################################################################

# /var/containers/Bundle/Application (Appears to be only app store apps & those installed via Impactor.)
rm -rf /var/containers/Bundle/Application/F766716D-477B-412E-B044-2E86980D8A64 # This is electra on my device
rm -rf /var/containers/Bundle/Application/B69DBC41-AB6A-42BC-AE0E-293128D3B0C2 # This is Filzaescaped on my device

# /var/mobile/Containers/Data/Application (Appears to be only app store apps & those installed via Impactor.)
rm -rf /var/mobile/Containers/Data/Application/929C82CD-1F4D-46E4-A384-00C917274341 # This is Anemonetheming on my device
rm -rf /var/mobile/Containers/Data/Application/5A10E5C8-D754-48B0-A01C-AD3AD41A9591 # This is Cydia Extender on my device
rm -rf /var/mobile/Containers/Data/Application/5EBF403E-0CFE-48DA-A580-13CC8BC1F80A # This is ICleaner on my device
rm -rf /var/mobile/Containers/Data/Application/8B0AA03E-BF95-4F6A-B1A9-CC1FA24A9EDF # This is Saurik.Cydia on my device
rm -rf /var/mobile/Containers/Data/Application/CDA801B2-FF27-4756-9A79-0E07C521380F # This is Filza on my device
rm -rf /var/mobile/Containers/Data/Application/71D548F1-E6EE-4D46-A0DD-A07D47DA247F # This is Filza electrocuted on my device
rm -rf /var/mobile/Containers/Data/Application/1472FBB3-AEA8-44C5-B074-26F0F279C0DF # This is Filza Escaped on my device
rm -rf /var/mobile/Containers/Data/Application/C78DDACB-0A46-4111-A4D5-7C5C1379FE17 # This is Apps manager on my device
rm -rf /var/mobile/Containers/Data/Application/4FAC484E-1B14-4F20-B7F7-9442A7FEC8E1 # This is crash reporter on my device
rm -rf /var/mobile/Containers/Data/Application/8DDE304D-1B24-4511-952B-B340D3D2969C # This is iDevice Walls App on my device
rm -rf /var/mobile/Containers/Data/Application/456D23FE-0F72-46A4-96C7-79C43F391034 # This is iWidgetApp on my device
rm -rf /var/mobile/Containers/Data/Application/37CEAFB2-90B3-409B-A2C0-F4CBC195F27C # This is libActivator on my device
rm -rf /var/mobile/Containers/Data/Application/C064C600-B0EB-4618-8BE2-02F6D1676FE3 # This is opwapp on my device
rm -rf /var/mobile/Containers/Data/Application/A2006909-A1AE-44F9-A6F6-77683CCCA67A # This is Electra on my device
rm -rf /var/mobile/Containers/Data/Application/BC495204-985B-4B2F-967D-8A7680C6F115 # This is Electra Safe MOde on my device
rm -rf /var/mobile/Containers/Data/Application/B61C48AB-7AFF-441E-8ACD-0AF39CF5FE03 # This is CocoaTop on my device

# /var/mobile/Containers/Shared/AppGroup (Appears to be only app store apps & those installed via Impactor.)
rm -rf /var/mobile/Containers/Shared/AppGroup/4DCC536E-0471-4D19-BA15-5C4B52C87E3C # This is Cydia Extender on my device

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
rm -rf /lib/*
rm -rf /mnt/*
rm -rf /tmp/* 

# Delete directories off of the /etc folder.
rm -rf /etc/apt
rm -rf /etc/default
rm -rf /etc/profile.d

# Delete directories off of the /Library folder.
rm -rf /Library/Activator
rm -rf /Library/dpkg
rm -rf /Library/ControlCenter
rm -rf /Library/Flipswitch
rm -rf /Library/Frameworks/*
rm -rf /Library/LaunchDaemons
rm -rf /Library/MobileSubstrate
rm -rf /Library/PreferenceBundles
rm -rf /Library/PreferenceLoader
rm -rf /Library/Switches
rm -rf /Library/Themes
rm -rf /Library/unlimapps_tweak_resources

# Delete directories off of the /usr folder.
rm -rf /usr/games
rm -rf /usr/include/*
rm -rf /usr/lib/apt
rm -rf /usr/lib/pkgconfig
rm -rf /usr/local/lib/*

# Delete directories off of the /var folder.
rm -rf /var/db/analyticsd/*
rm -rf /var/db/diagnostics/*
rm -rf /var/DT
rm -rf /var/installd/Library/Logs/*
rm -rf /var/mobile/Library/.Trash
rm -rf /var/mobile/Library/.Trash.metadata
rm -rf /var/mobile/Library/ApplicationSync
rm -rf /var/mobile/Library/Caches/*
rm -rf /var/mobile/Library/Cookies/*
rm -rf /var/mobile/Library/WebKit/*
rm -rf /var/root/Application\ Support/*
rm -rf /var/root/Library/Caches/*
rm -rf /var/ua_tweak_resources
rm -rf /var/unlimapps_tweak_resources

# Delete misc files that don't belong to any tweak.
rm -f /.bit_of_fun
rm -f /.bootstrapped_electra
rm -f /.cydia_no_stash
rm -f /.file
rm -f /.Trashes
rm -f /bin/launchctl
rm -f /usr/lib/libjailbreak.dylib
rm -f /private/var/installd/Library/MobileInstallation/UninstalledApplications.plist
rm -f /private/var/mobile/test.txt
rm -f /private/var/mobile/Library/google*.*
rm -f /private/var/mobile/Library/Preferences/.GlobalPreferences.plist.*
rm -f /private/var/mobile/Library/Preferences/com.apple.*.plist.*
rm -f /private/var/mobile/Library/Preferences/com.smokin1337.optixprefs.plist
rm -f /private/var/mobile/Library/Preferences/com.smokin1337.optixcolorprefs.plist
rm -f /private/var/mobile/Library/Preferences/cn.tinyapps.location360pro.plist
rm -f /private/var/mobile/Library/Preferences/net.dodtweaks.mdprefs.plist
rm -f /private/var/mobile/Library/Preferences/pairedsyncd.plist
rm -f /private/var/mobile/Library/Preferences/splashboardd.plist
rm -f /private/var/mobile/Library/Preferences/xhprx.xh
rm -f /private/var/mobile/Library/SpringBoard/.HomeBackground.cpbitmap.*
rm -f /private/var/mobile/Library/SpringBoard/ApplicationShortcuts/org.coolstar.electra.plist
rm -f /private/var/mobile/Library/SpringBoard/ApplicationShortcuts/org.coolstar.electra1131-mp.plist
rm -f /private/var/mobile/Library/SpringBoard/PushStore/com.saurik.Cydia.pushstore
rm -f /private/var/mobile/MobileSoftwareUpdate/restore.log
rm -f /private/var/MobileSoftwareUpdate/restore.log
rm -f /private/var/root/.bash_history
rm -f /private/var/root/.bashrc
rm -f /private/var/root/Library/Preferences/com.apple.*.plist.*
rm -f /private/var/root/Library/Preferences/UserEventAgent.plist
rm -f /private/var/run/jailbreakd.pid
rm -f /private/var/tmp/jailbreakd.pid

# Delete misc folders that don't belong to any tweak.
rm -rf /Library/Application\ Support/SpeedOptimize
rm -rf /Library/CustomFonts
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
rm -rf /Library/Themes/Ace\ Folder.theme
rm -rf /Library/Themes/Ace\ High\ Sierra.theme
rm -rf /Library/Themes/Classic\ Icons\ 2x.theme
rm -rf /Library/Themes/Classic\ Icons\ Large.theme
rm -rf /Library/Themes/Classic\ Labels.theme
rm -rf /Library/Themes/Classic\ Respring\ Logo.theme
rm -rf /Library/Themes/Classic\ Settings\ Icons.theme
rm -rf /Library/Themes/Classic\ Status\ Bar.theme
rm -rf /Library/Themes/Classic\ UISounds.theme
rm -rf /Library/Themes/Classic\ Weather\ Icon\ -\ Celsius.theme
rm -rf /Library/Themes/Classic\ Weather\ Icon\ -\ Fahrenheit.theme
rm -rf /Library/Themes/Winterboard icon\ for\ Anemone.theme
rm -rf /Library/Themes/iPhone\ X\ 4\ Icon\ Dock.theme
rm -rf /Library/Themes/iPhone\ X\ 5\ Icon\ Dock.theme
rm -rf /Library/Themes/iPhone\ X\ Battery.theme
rm -rf /Library/Themes/iPhone\ X\ Bluetooth.theme
rm -rf /Library/Themes/iPhone\ X\ Icons.theme
rm -rf /Library/Themes/iPhone\ X\ Location.theme
rm -rf /Library/Themes/iPhone\ X\ RotationLock.theme
rm -rf /Library/Themes/iPhone\ X\ SignalBars.theme
rm -rf /Library/Themes/iPhone\ X\ VPN.theme
rm -rf /Library/Themes/iPhone\ X\ Wifi.theme
rm -rf /Library/Themes/LotusMask.theme
rm -rf /Library/Themes/minimalios11.theme
rm -rf /Library/Themes/Piksel\ Folder.theme
rm -rf /Library/Themes/Piksel\ Icons.theme
rm -rf /Library/Themes/PikselMask.theme
rm -rf /Library/Themes/SShadow\ Bagde.theme
rm -rf /Library/Themes/SShadow\ Dock.theme
rm -rf /Library/Themes/SShadow\ Folder.theme
rm -rf /Library/Themes/SShadow.theme
rm -rf /Library/Themes/Veexillum\ -\ Apps.theme
rm -rf /Library/Themes/Veexillum\ -\ Badges.theme
rm -rf /Library/Themes/Veexillum\ -\ Boot\ Logo.theme
rm -rf /Library/Themes/Veexillum\ -\ CC.theme
rm -rf /Library/Themes/Veexillum\ -\ Dock\ (line).theme
rm -rf /Library/Themes/Veexillum\ -\ Dock.theme
rm -rf /Library/Themes/Veexillum\ -\ DockEffects.theme
rm -rf /Library/Themes/Veexillum\ -\ Folder.theme
rm -rf /Library/Themes/Veexillum\ -\ IconEffects\ (unmasked).theme
rm -rf /Library/Themes/Veexillum\ -\ IconEffects.theme
rm -rf /Library/Themes/Veexillum\ -\ Mask.theme
rm -rf /Library/Themes/Veexillum\ -\ ShareSheet.theme
rm -rf /Library/Themes/Veexillum\ -\ System.theme
rm -rf /Library/Themes/Veexillum\ -\ UI.theme
rm -rf /private/var/mobile/Library/iWidgets/EW.WdgtPack.6_iW1
rm -rf /private/var/mobile/Library/iWidgets/EW.WdgtPack.6_iW2
rm -rf /private/var/mobile/Library/iWidgets/Scripted
rm -rf /private/var/mobile/Library/iWidgets/XenJA4
rm -rf /private/var/mobile/Library/LockHTML/EW.WdgtPack.6_LS1
rm -rf /private/var/mobile/Library/LockHTML/EW.WdgtPack.6_LS2
rm -rf /private/var/mobile/Library/LockHTML/EW.WdgtPack.6_LS3
rm -rf /private/var/mobile/Library/LockHTML/LS\ EW11
rm -rf /private/var/mobile/Library/LockHTML/LS\ EW33
rm -rf /private/var/mobile/Library/SBHTML/EW.WdgtPack.6_SB1
rm -rf /private/var/mobile/Library/SBHTML/EW.WdgtPack.6_SB2
rm -rf /private/var/mobile/Library/SBHTML/LL\ Stripe
rm -rf /private/var/mobile/Library/SBHTML/SB\ EW8
rm -rf /private/var/mobile/Library/SBHTML/SB\ EW9
rm -rf /private/var/mobile/Library/SBHTML/SB\ EW13
rm -rf /private/var/mobile/Library/SBHTML/SB\ EW22
rm -rf /private/var/mobile/Library/SBHTML/SB\ EW30
rm -rf /private/var/mobile/Library/SBHTML/UniAW2018_Base_2.0

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
rm -rf /System/Library/PreferenceBundles/AppList.bundle
rm -rf /usr/include/AppList
rm -f  /usr/lib/libapplist.dylib

# Cleanup files from the "Appsync Unified" package.
rm -f /Library/LaunchDaemons/net.angelxwind.asu_inject.plist
rm -f /usr/bin/asu_inject

# Cleanup files from the "APT 1.4 (apt-key)" package.
rm -f /usr/bin/apt-key

# Cleanup files from the "APT 1.4 Strict" package.
rm -f /usr/bin/apt
rm -f /usr/bin/apt-cache
rm -f /usr/bin/apt-cdrom
rm -f /usr/bin/apt-config
rm -f /usr/bin/apt-extracttemplates
rm -f /usr/bin/apt-ftparchive
rm -f /usr/bin/apt-get
rm -f /usr/bin/apt-mark
rm -f /usr/bin/apt-sortpkgs

# Cleanup files from the "APT 1.4 Strict (lib)" package.
rm -f  /etc/apt/apt.conf.d
rm -f  /etc/apt/preferences.d
rm -f  /etc/apt/sources.list.d
rm -f  /etc/apt/trusted/gpg.d
rm -rf /usr/lib/apt
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
rm -rf /usr/share/aclocal
rm -f  /usr/share/aclocal/libassuan.m4

# Cleanup files from the "Basic-Cmds" package.
rm -f /usr/bin/mesg
rm -f /usr/bin/uudecode
rm -f /usr/bin/uuencode
rm -f /usr/bin/write

# Cleanup files from the "Berkley DB" package.
rm -f /usr/bin/dbsql
rm -f /usr/bin/db_archive
rm -f /usr/bin/db_checkpoint
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
rm -rf /usr/share/bigboss/bigboss.png
rm -rf /usr/share/bigboss/planetiphones.png
rm -rf /usr/share/bigboss/touchrev.png

# Cleanup files from the "Bootstrap-Cmds" package.
rm -f /usr/bin/mig
rm -f /usr/libexec/migcom

# Cleanup files from the "Bourne-Again SHell" package.
rm -f  /bin/bash
# rm -f  /bin/sh This was moved to the bottom.
rm -f  /usr/bin/bashbug
rm -rf /usr/lib/bash

# Cleanup files from the Boxy package.
rm -rf /private/var/mobile/Documents/com.irepo.boxy3
rm -f  /private/var/mobile/Documents/Boxy3.log
rm -f  /private/var/mobile/Library/Preferences/com.irepo.boxy.plist
rm -rf /usr/lib/TweakInject/Boxy_Main.bundle

# Cleanup files from the "Bytafont 3" package.
rm -rf /Applications/BytaFont3.app
rm -f  /com.bytafont.bytafont3*.deb
rm -rf /private/var/mobile/Library/Caches/com.bytafont.BytaFont3
rm -f  /private/var/mobile/Library/Preferences/BytaFontTweakMode.plist
rm -f  /private/var/mobile/Library/Preferences/com.bytafont.BytaFont3.plist
rm -rf /private/var/mobile/Library/Preferences/BytaFontBackup

# Cleanup files from the bzip2 package.
rm -f /bin/bunzip2
rm -f /bin/bzcat
rm -f /bin/bzip2
rm -f /bin/bzip2recover

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
rm -f  /private/var/mobile/Library/Preferences/ru.domo.CocoaTop.plist

# Cleanup files from the "Confidential & Proprietary" package.
rm -f /private/var/mobile/Library/Preferences/com.neinzedd9.confidentialproprietarysettings.plist

# Cleanup files from the "Core Utilities" package.
rm -r  /etc/profile.d/coreutils.h
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
rm -f  /usr/sbin/chown
rm -f  /usr/sbin/chroot

# Cleanup files from the "Core Utilities (/bin)" package.
# IMPORTANT! Some are commented out.  Dont' delete these!  These are part of
# the model .ipsw file.
# rm -f /bin/cat
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
rm -f /bin/rmdir
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

# Cleanup files from the CrashReporter package.
rm -rf /Applications/CrashReporter.app
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
rm -f  /usr/bin/update-alternatives
rm -f  /usr/lib/libdpkg.a
rm -f  /usr/lib/libdpkg.la
rm -rf /usr/lib/pkgconfig
rm -rf /usr/share/dpkg
rm -rf /var/lib/dpkg

# Cleanup files from the "Debian Utilities" package.
rm -f /bin/run-parts

# Cleanup files from the "Debkeeper" package.
rm -f /private/var/mobile/Library/Preferences/net.tateu.debkeeper.plist

# Cleanup files from the "DetailCellularUsage" package.
rm -f /private/var/mobile/Library/Preferences/com.thecomputerwhisperer.DCUSettings.plist

# Cleanup files from the "DetailedPowerUsage" package.
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

# Cleanup files from the "EzCC" package.
rm -rf /Library/ControlCenter

# Cleanup files from the "Fake GPS Pro" package.
rm -f  /private/var/mobile/Documents/favorites.plist
rm -f  /private/var/mobile/Library/Caches/.cn.tinyapps.XGPSLite_umeng.plist
rm -f  /private/var/mobile/Library/Caches/.cn.tinyapps.XGPSPro_umeng.plist
rm -rf /private/var/mobile/Library/Caches/cn.tinyapps.XGPSLite
rm -rf /private/var/mobile/Library/Caches/cn.tinyapps.XGPSPro
rm -f  /private/var/mobile/Library/Preferences/cn.tinyapps.XGPSLite.plist
rm -f  /private/var/mobile/Library/Preferences/cn.tinyapps.XGPSPro.plist
rm -f  /private/var/mobile/Library/Preferences/net.85819.ios.OTRLocation.plist
rm -f  /private/var/mobile/Library/Preferences/otrlocation.app.85819.net.plist

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
rm -rf /private/var/mobile/Containers/Data/Application/2A9785BE-18A9-4519-BC94-8B33C3F02ACF # Filza preferences and data.
rm -rf /private/var/mobile/Library/Application\ Support/Containers/com.scroublepokemon.filzaelectrocuted
rm -rf /private/var/mobile/Library/Application\ Support/Containers/com.tigisoftware.Filza
rm -rf /private/var/mobile/Library/Caches/com.scroublepokemon.filzaelectrocuted
rm -rf /private/var/mobile/Library/Caches/com.tigisoftware.Filza
rm -rf /private/var/mobile/Library/Filza
rm -f  /private/var/root/Library/Preferences/com.scroublepokemon.filzaescaped.plist
rm -f  /private/var/root/Library/Preferences/com.scroublepokemon.filzaescaped.plist.*
rm -rf /usr/libexec/filza

# Cleanup files from the "Find Utilities" package.
rm -f /usr/bin/find
rm -f /usr/bin/locate
rm -f /usr/bin/updatedb
rm -f /usr/bin/xargs
rm -f /usr/libexec/bigram
rm -f /usr/libexec/code
rm -f /usr/libexec/frcode

# Cleanup files from the "Flame" package.
rm -f  /etc/apt/apt.conf.d/flameTimeout
rm -rf /Library/Application\ Support/Flame
rm -rf /private/var/mobile/Library/Application\ Support/Flame
rm -f  /private/var/mobile/Library/Preferences/com.aditkamath.flame.plist

# Cleanup files from the "Flex" package.
rm -rf /Applications/Flex.app
rm -f  /private/var/mobile/Documents/extraction-com.apple.springboard.flex
rm -f  /private/var/mobile/Documents/extraction-com.johncoates.Flex.flex
rm -rf /private/var/mobile/Documents/Flex
rm -rf /private/var/mobile/Library/Application\ Support/Flex3
rm -f  /private/var/mobile/Library/Application\ Support/Flex3/patches.plist
rm -rf /private/var/mobile/Library/Caches/com.johncoates.Flex
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
rm -f  /usr/bin/awk
rm -f  /usr/bin/gawk
rm -f  /usr/include/gawkapi.h
rm -rf /usr/lib/gawk
rm -rf /usr/libexec/awk
rm -rf /usr/share/awk

# Cleanup files from the "GIT" package.
rm -f  /usr/bin/git
rm -f  /usr/bin/git-cvsserver
rm -f  /usr/bin/git-receive-pack
rm -f  /usr/bin/git-shell
rm -f  /usr/bin/git-upload-archive
rm -f  /usr/bin/gitk
rm -rf /usr/libexec/git-core
rm -rf /usr/share/git-core
rm -rf /usr/share/gitk

# Cleanup files from the "GNU Cryptography" package.
rm -f  /usr/bin/dumpsexp
rm -f  /usr/bin/hmac256
rm -f  /usr/bin/libgcryptconfig
rm -f  /usr/bin/mpicalc
rm -f  /usr/include/gcrypt.h
rm -f  /usr/lib/libgcrypt.20.dylib
rm -f  /usr/lib/libgcrypt.dylib
rm -f  /usr/lib/libgcrypt.la
rm -rf /usr/share/aclocal
rm -f  /usr/share/aclocal/libgcrypt.m4

# Cleanup files from the "GNUPG Errors" package.
rm -f  /usr/bin/gpg-error
rm -f  /usr/bin/gpg-error-config
rm -f  /usr/include/gpg-error.h
rm -f  /usr/include/gpgrt.h
rm -f  /usr/lib/libgpg-error.0.dylib
rm -f  /usr/lib/libgpg-error.dylib
rm -f  /usr/lib/libgpg-error.la
rm -rf /usr/share/aclocal
rm -f  /usr/share/aclocal/gpg-error.m4
rm -rf /usr/share/common-lisp
rm -rf /usr/share/libgpg-error
rm -f  /usr/share/libgpg-error/errorref.txt

# Cleanup files from the "GnuPG 2" package.
rm -f  /usr/bin/dirmngr
rm -f  /usr/bin/dirmngr-client
rm -f  /usr/bin/gpg-agent
rm -f  /usr/bin/gpg-connect-agent
rm -f  /usr/bin/gpg2
rm -f  /usr/bin/gpgconf
rm -f  /usr/bin/gpgparsemail
rm -f  /usr/bin/gpgscm
rm -f  /usr/bin/gpgsm
rm -f  /usr/bin/gpgtar
rm -f  /usr/bin/gpgv2
rm -f  /usr/bin/kbxutil
rm -f  /usr/bin/watchgnupg
rm -f  /usr/libexec/gpg-check-pattern
rm -f  /usr/libexec/gpg-preset-passphrase
rm -f  /usr/libexec/gpg-protect-tool
rm -f  /usr/libexec/gpg-wks-client
rm -f  /usr/libexec/scdaemon
rm -f  /usr/sbin/addgnupghome
rm -f  /usr/sbin/applygnupgdefaults

# Cleanup files from the "GNU Privacy Guard" package.
rm -f  /usr/bin/gpg
rm -f  /usr/bin/gpg-zip
rm -f  /usr/bin/gpgsplit
rm -f  /usr/bin/gpgv
rm -rf /usr/libexec/gnupg

# Cleanup files from the "GPSCheat" package.
rm -rf /Library/Switches/GPSCheatSwitch.bundle
rm -f  /private/var/mobile/Documents/favorites.plist
rm -f  /private/var/mobile/Library/Preferences/com.zx.GPSCheatData.plist
rm -f  /private/var/mobile/Library/Preferences/com.zx.GPSCheatSettings.plist

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
rm -rf /private/var/mobile/Library/Application\ Support/IconSupport

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

# Cleanup files from the "iPhone Firmware (/sbin)" package.
# IMPORTANT - Don't actually run these!  These are in a stock .ipsw.
# ALL of these files must actually remain on the file system.
# rm -f /sbin/fsck
# rm -f /sbin/fsck_apfs  
# rm -f /sbin/fsck_hfs
# rm -f /sbin/fstyp
# rm -f /sbin/fstyp_hfs
# rm -f /sbin/mount
# rm -f /sbin/mount_apfs
# rm -f /sbin/mount_hfs
# rm -f /sbin/newfs_apfs
# rm -f /sbin/newfs_hfs
# rm -f /sbin/pfctl
# rm -f /sbin/umount
# rm -f /usr/sbin/nvram

# Cleanup files from the "KarenLocalizer" and "KarenPrefs" packages.
# NOTE, these two are in the Mikoto package and are deleted there.
# rm -f /usr/lib/libkarenlocalizer.dylib
# rm -f /usr/lib/libkarenprefs.dylib

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
rm -f  /usr/include/ksba.halt
rm -f  /usr/lib/libksba.8.dylib
rm -f  /usr/lib/libksba.dylib
rm -f  /usr/lib/libksba.la
rm -rf /usr/share/aclocal
rm -f  /usr/share/aclocal/ksba.m4

# Cleanup files from the "less" package.
rm -f /usr/bin/less
rm -f /usr/bin/lessecho
rm -f /usr/bin/lesskey
rm -f /usr/bin/more

# Cleanup files from the "libColorPicker" package.
rm -f /private/var/mobile/Library/Preferences/com.pixelfiredev.libcolorpicker.plist
rm -f /usr/lib/libcolorpicker.dylib

# Cleanup files from the "libCrashReport" package.
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
rm -f /private/var/mobile/Library/Preferences/com.ryleyangus.liberty.plist
rm -f /private/var/mobile/Library/Preferences/com.ryleyangus.libertylite.plist
rm -f /usr/lib/Liberty.dylib

# Cleanup files from the "libPackageInfo" package.
rm -rf /usr/include/libpackageinfo
rm -f  /usr/lib/libpackageinfo.dylib

# Cleanup files from the "libSwift4" package.
rm -rf /usr/lib/libswift

# Cleanup files from the "libSymbolicate" package.
rm -rf /usr/include/libsymbolicate
rm -f  /usr/lib/libsymbolicate.dylib

# Cleanup files from the "Link Identity Editor" package.
rm -f /usr/bin/ldid

# Cleanup files from the "LittleX" package.
rm -f /private/var/mobile/Library/Preferences/com.ioscreatix.littlex.plist

# Cleanup files from the "LocalIAPStore" package.
rm -f /private/var/mobile/Library/Preferences/anondev.LocalIAPStore.plist

# Cleanup files from the "Lockplus" package.
rm -rf /Library/LockPlus
rm -rf /private/var/mobile/Documents/lockplusfonts
rm -rf /private/var/mobile/Library/LockPlus
rm -f  /private/var/mobile/Library/Preferences/com.junesiphone.lockplus.plist

# Cleanup files from the "lsof" package.
rm -f /usr/sbin/lsof

# Cleanup files from the "make" package.
rm -f /usr/bin/make
rm -f /usr/include/gnumake.h

# Cleanup files from the "Mikoto" package.
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
rm -f  /usr/bin/nano
rm -f  /usr/bin/rnano
rm -rf /usr/share/nano

# Cleanup files from the "Network-Cmds" package.
rm -f /sbin/netstat
rm -f /sbin/route
rm -f /usr/libexec/kdumpd
rm -f /usr/sbin/arp
rm -f /usr/sbin/ndp
rm -f /usr/sbin/traceroute6

# Cleanup files from the "New Curses" package.
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
rm -f  /usr/lib/libcurses.a
rm -f  /usr/lib/libform.a
rm -f  /usr/lib/libform_g.a
rm -f  /usr/lib/libmenu.a
rm -f  /usr/lib/libmenu_g.a
rm -f  /usr/lib/libncurses.a
rm -f  /usr/lib/libncurses_g.a
rm -f  /usr/lib/libpanel.a
rm -f  /usr/lib/libpanel_g.a
rm -f  /usr/lib/terminfo
rm -rf /usr/share/tabset
rm -rf /usr/share/terminfo

# Cleanup files from the "New GNU Portable Threads" package.
rm -f  /usr/bin/npth-config
rm -f  /usr/include/npth.h
rm -f  /usr/lib/libnpth.0.dylib
rm -f  /usr/lib/libnpth.dylib
rm -f  /usr/lib/libnpth.la
rm -rf /usr/share/aclocal
rm -f  /usr/share/aclocal/npth.m4

# Cleanup files from the "NFCWriter" package.
rm -rf /Applications/NFCWriter.app
rm -f  /usr/lib/NFCWritPass.dylib
rm -f  /var/mobile/Library/Preferences/net.limneos.nfcwriter.license
rm -f  /var/mobile/Library/Preferences/nfcd.plist

# Cleanup files from the "Nghttp2" package.
rm -rf /usr/include/nghttp2
rm -f  /usr/lib/libnghttp2.14.dylib
rm -f  /usr/lib/libnghttp2.dylib
rm -f  /usr/lib/libnghttp2.la
rm -f  /usr/lib/pkgconfig/libnghttp2.pc

# Cleanup files from the "noncereboot11CLI" package.
rm -f /usr/bin/noncereboot11

# Cleanup files from the "NoSubstitute (Electra)" package.
rm -f /private/var/mobile/Library/Preferences/co.vexation.nosubstitute.plist

# Cleanup files from the "OpenSSH" package.
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
rm -f  /usr/sbin/sshd
rm -rf /var/empty

# Cleanup files from the "OpenSSL" package.
rm -rf /etc/ssl
rm -f  /usr/bin/c_rehash
rm -f  /usr/bin/openssl
rm -rf /usr/include/openssl
rm -rf /usr/lib/engines
rm -f  /usr/lib/libcrypto.1.0.0.dylib
rm -f  /usr/lib/libcrypto.a
rm -f  /usr/lib/libcrypto.dylib
rm -f  /usr/lib/libssl.1.0.0.dylib
rm -f  /usr/lib/libssl.a
rm -f  /usr/lib/libssl.dylib
rm -rf /usr/lib/pkgconfig
rm -r  /usr/lib/pkgconfig/libcrypto.pc
rm -r  /usr/lib/pkgconfig/libssl.pc
rm -r  /usr/lib/pkgconfig/openssl.pc
rm -rf /usr/lib/ssl

# Cleanup files from the "Patch" package.
rm -f /usr/bin/patch

# Cleanup files from the "Pincrush" package.
rm -f /usr/bin/pincrush

# Cleanup files from the "PreferenceLoader" package.
rm -f /usr/include/libprefs/prefs.h
rm -f /usr/lib/libprefs.dylib

# Cleanup files from the "Preference Organizer 2" tweak.
rm -f /private/var/mobile/Library/Preferences/net.angelxwind.preferenceorganizer2.plist

# Cleanup files from the "PrefixUI" package.
rm -rf /Library/Frameworks/PrefixUI.framework
rm -f  /com.laughingquoll.prefixui_0.5_iphoneos-arm.deb

# Cleanup files from the "Profile Directory" package.
rm -f  /etc/profile
rm -rf /etc/profile.d

# Cleanup files from the "PullToRespring" package.
rm -f /private/var/mobile/Library/Preferences/com.sassoty.pulltorespring.plist

# Cleanup files from the "ReformX" package.
rm -rf /Applications/ReformX.app
rm -rf /Library/Application\ Support/ReformX
rm -f  /private/var/mobile/Library/Preferences/com.zestlabs.reformx.current.plist
rm -f  /private/var/mobile/Library/Preferences/com.zestlabs.reformx.plist

# Cleanup files from the "Rocketbootstrap" package.
rm -f /usr/include/rocketbootstrap.h
rm -f /usr/include/rocketbootstrap_dynamic.h
rm -f /usr/lib/librocketbootstrap.dylib
rm -r /usr/libexec/_rocketd_reenable
rm -r /usr/libexec/rocketd

# Cleanup files from the "Rsync" package.
rm -f /usr/bin/rsync

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
rm -f /usr/lib/libsubstitute.0.dylib
rm -f /usr/lib/libsubstitute.dylib

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
rm -f /bin/sync
rm -f /sbin/dmesg
rm -f /sbin/dynamic_pager
rm -f /sbin/halt
rm -f /sbin/nologin
rm -f /sbin/reboot
rm -f /usr/bin/arch
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
rm -rf /Library/Frameworks/TechSupport.framework

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
rm -f /usr/bin/gssc
rm -f /usr/bin/iomfsetgamma
rm -f /usr/bin/ldrestart
rm -f /usr/bin/sbdidlaunch
rm -f /usr/bin/sbreload
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
rm -rf /private/var/mobile/Library/iWidgets
rm -rf /private/var/mobile/Library/LockHTML
rm -f  /private/var/mobile/Library/Preferences/com.matchstic.xenhtml.plist
rm -rf /private/var/mobile/Library/SBHTML
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
echo "##" > /etc/hosts
echo "# Host Database" >> /etc/hosts
echo "#" >> /etc/hosts
echo "# localhost is used to configure the loopback interface" >> /etc/hosts
echo "# when the system is booting.  Do not change this entry." >> /etc/hosts
echo "##" >> /etc/hosts
echo "127.0.0.1	localhost" >> /etc/hosts
echo "255.255.255.255	broadcasthost" >> /etc/hosts
echo "::1             localhost" >> /etc/hosts

# Removing the last tools, clear the UI cache.
uicache
rm -f /usr/bin/uicache
rm -f /bin/sh
rm -f /bin/rm

# All Done!
echo "WARNING!!!!! All Electra jailbreak files and directories should be deleted."
echo "Rebooting... (Please pray)"
kill 1

