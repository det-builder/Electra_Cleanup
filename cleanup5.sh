
########################################################################
#                                                                      #
# Copy several command line utilities from their source location into  #
# the uninstall directory so that they may be referenced to later.     #
#                                                                      #
########################################################################
rm -rf /uninstall
mkdir /uninstall
cp /bin/rm          /uninstall
cp /usr/bin/uicache /uninstall
chmod 755 /uninstall/uicache

# Cleanup "/" (DONE)
rm -f  /.bootstrapped
rm -f  /.cydia_no_stash
rm -rf /.fseventsd
rm -f  /.installed_unc0ver
rm -f  /.mount_rw
rm -rf /boot
rm -rf /lib
rm -rf /mnt

# Cleanup "/Applications" (DONE)
rm -rf /Applications/SuccessionRestore.app
rm -rf /Applications/Filza.app
rm -rf /Applications/Cydia.app

# Cleanup "/bin" (DONE)
rm -f /bash
rm -f /bunzip2
rm -f /bzcat
rm -f /bzip2
rm -f /bzip2recover
rm -f /cat
rm -f /chgrp
rm -f /chown
rm -f /date
rm -f /dd
rm -f /dir
rm -f /egrep
rm -f /false
rm -f /fgrep
rm -f /grep
rm -f /gunzip
rm -f /gzexe
rm -f /gzip
rm -f /kill
rm -f /launchctl
rm -f /ln
rm -f /mknod
rm -f /mktemp
rm -f /mv
rm -f /pwd
rm -f /readlink
rm -f /rmdir
rm -f /sed
rm -f /sh
rm -f /sh.distrib
rm -f /sleep
rm -f /stty
rm -f /su
rm -f /sync
rm -f /tar
rm -f /touch
rm -f /true
rm -f /uname
rm -f /uncompress
rm -f /vdir
rm -f /zcat
rm -f /zcmp
rm -f /zdiff
rm -f /zegrep
rm -f /zfgrep
rm -f /zforce
rm -f /zgrep
rm -f /zless
rm -f /zmore
rm -f /znew

# Cleanup "/etc" (DONE)
rm -rf /private/etc/alternatives
rm -rf /private/etc/apt
rm -rf /private/etc/default
rm -rf /private/etc/dpkg
rm -f  /private/etc/profile
rm -rf /private/etc/profile.d
rm -rf /private/etc/rc.d
# rm -rf /private/etc/ssh
# rm -rf /private/etc/ssl

# Cleanup "/Library" (DONE)
rm -rf /Library/dpkg
rm -rf /Library/PreferenceLoader
rm -rf /Library/PreferenceBundles
rm -rf /Library/MobileSubstrate
rm -rf /Library/Frameworks/*
rm -rf /Library/LaunchDaemons/*

# Cleanup "/sbin" (DONE)
rm -f  /sbin/dmesg
rm -f  /sbin/dynamic_pager
rm -f  /sbin/fsck_apfs.sbin
rm -f  /sbin/fsck_exfat.sbin
rm -f  /sbin/fsck_msdos.sbin
rm -f  /sbin/fsck.sbin
rm -f  /sbin/fstyp
rm -f  /sbin/fstyp_msdos
rm -f  /sbin/fstyp_ntfs
rm -f  /sbin/fstyp_udf
rm -f  /sbin/halt
rm -f  /sbin/launchctl
rm -f  /sbin/launchd.sbin
rm -f  /sbin/mount_apfs.sbin
rm -f  /sbin/mount_devfs
rm -f  /sbin/mount_fdesc
rm -f  /sbin/mount_hfs.sbin
rm -f  /sbin/mount.sbin
rm -f  /sbin/newfs_apfs.sbin
rm -f  /sbin/mount_hfs.sbin
rm -f  /sbin/pfctl.sbin
rm -f  /sbin/quotacheck
rm -f  /sbin/umount.distrib

# Cleanup "/usr/bin" (DONE)
rm -f /usr/bin/7z
rm -f /usr/bin/7za
rm -f /usr/bin/Filza
rm -f /usr/bin/[
rm -f /usr/bin/apt
rm -f /usr/bin/apt-cache
rm -f /usr/bin/apt-cdrom
rm -f /usr/bin/apt-config
rm -f /usr/bin/apt-extracttemplates
rm -f /usr/bin/apt-ftparchive
rm -f /usr/bin/apt-get
rm -f /usr/bin/apt-key
rm -f /usr/bin/apt-mark
rm -f /usr/bin/apt-sortpkgs
rm -f /usr/bin/arch
rm -f /usr/bin/asn1Coding
rm -f /usr/bin/asn1Decoding
rm -f /usr/bin/asn1Parser
rm -f /usr/bin/autopoint
rm -f /usr/bin/b2sum
rm -f /usr/bin/base32
rm -f /usr/bin/base64
rm -f /usr/bin/basename
rm -f /usr/bin/basenc
rm -f /usr/bin/bashbug
rm -f /usr/bin/captoinfo
rm -f /usr/bin/certtool
rm -f /usr/bin/cfversion
rm -f /usr/bin/chcon
rm -f /usr/bin/chfn
rm -f /usr/bin/chown
rm -f /usr/bin/chsh
rm -f /usr/bin/cksum
rm -f /usr/bin/clear
rm -f /usr/bin/cmp
rm -f /usr/bin/comm
rm -f /usr/bin/csplit
rm -f /usr/bin/cut
rm -f /usr/bin/cynject
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
rm -f /usr/bin/diff
rm -f /usr/bin/diff3
rm -f /usr/bin/dircolors
rm -f /usr/bin/dirmngr
rm -f /usr/bin/dirmngr-client
rm -f /usr/bin/dirname
rm -f /usr/bin/dpkg
rm -f /usr/bin/dpkg-deb
rm -f /usr/bin/dpkg-divert
rm -f /usr/bin/dpkg-maintscript-helper
rm -f /usr/bin/dpkg-query
rm -f /usr/bin/dpkg-split
rm -f /usr/bin/dpkg-statoverride
rm -f /usr/bin/dpkg-trigger
rm -f /usr/bin/dselect
rm -f /usr/bin/du
rm -f /usr/bin/dumpsexp
rm -f /usr/bin/ecidecid
rm -f /usr/bin/env
rm -f /usr/bin/envsubst
rm -f /usr/bin/expand
rm -f /usr/bin/expr
rm -f /usr/bin/factor
rm -f /usr/bin/file
rm -f /usr/bin/find
rm -f /usr/bin/fmt
rm -f /usr/bin/fold
rm -f /usr/bin/funzip
rm -f /usr/bin/getconf
rm -f /usr/bin/getopt
rm -f /usr/bin/gettext
rm -f /usr/bin/gettext.sh
rm -f /usr/bin/gettextize
rm -f /usr/bin/getty
rm -f /usr/bin/gnupg2
rm -f /usr/bin/gnutls-cli
rm -f /usr/bin/gnutls-cli-debug
rm -f /usr/bin/gnutls-serv
rm -f /usr/bin/gpg
rm -f /usr/bin/gpg-agent
rm -f /usr/bin/gpg-connect-agent
rm -f /usr/bin/gpg-error
rm -f /usr/bin/gpg-error-config
rm -f /usr/bin/gpg-wks-server
rm -f /usr/bin/gpgconf
rm -f /usr/bin/gpgparsemail
rm -f /usr/bin/gpgrt-config
rm -f /usr/bin/gpgscm
rm -f /usr/bin/gpgsm
rm -f /usr/bin/gpgtar
rm -f /usr/bin/gpgv
rm -f /usr/bin/groups
rm -f /usr/bin/gssc
rm -f /usr/bin/head
rm -f /usr/bin/hmac256
rm -f /usr/bin/hostid
rm -f /usr/bin/hostinfo
rm -f /usr/bin/id
rm -f /usr/bin/idn2
rm -f /usr/bin/infocmp
rm -f /usr/bin/infotocap
rm -f /usr/bin/install
rm -f /usr/bin/iomfsetgamma
rm -f /usr/bin/join
rm -f /usr/bin/kbxutil
rm -f /usr/bin/killall
rm -f /usr/bin/ksba-config
rm -f /usr/bin/ldid
rm -f /usr/bin/ldrestart
rm -f /usr/bin/libassuan-config
rm -f /usr/bin/libgcrypt-config
rm -f /usr/bin/link
rm -f /usr/bin/locate
rm -f /usr/bin/login
rm -f /usr/bin/logname
rm -f /usr/bin/lz4
rm -f /usr/bin/lz4c
rm -f /usr/bin/lz4cat
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
rm -f /usr/bin/md5sum
rm -f /usr/bin/mkfifo
rm -f /usr/bin/mktemp
rm -f /usr/bin/mpicalc
rm -f /usr/bin/msgattrib
rm -f /usr/bin/msgcat
rm -f /usr/bin/msgcmp
rm -f /usr/bin/msgcomm
rm -f /usr/bin/msgconv
rm -f /usr/bin/msgen
rm -f /usr/bin/msgexec
rm -f /usr/bin/msgfilter
rm -f /usr/bin/msgfmt
rm -f /usr/bin/msggrep
rm -f /usr/bin/msginit
rm -f /usr/bin/msgmerge
rm -f /usr/bin/msgunfmt
rm -f /usr/bin/msguniq
rm -f /usr/bin/ncurses6-config
rm -f /usr/bin/ncursesw6-config
rm -f /usr/bin/nettle-hash
rm -f /usr/bin/nettle-lfib-stream
rm -f /usr/bin/nettle-pbkdf2
rm -f /usr/bin/ngettext
rm -f /usr/bin/nice
rm -f /usr/bin/nl
rm -f /usr/bin/nohup
rm -f /usr/bin/nproc
rm -f /usr/bin/npth-config
rm -f /usr/bin/numfmt
rm -f /usr/bin/ocsptool
rm -f /usr/bin/od
rm -f /usr/bin/p11-kit
rm -f /usr/bin/p11tool
rm -f /usr/bin/pager
rm -f /usr/bin/pagesize
rm -f /usr/bin/passwd
rm -f /usr/bin/paste
rm -f /usr/bin/pathchk
rm -f /usr/bin/pinky
rm -f /usr/bin/pkcs1-conv
rm -f /usr/bin/plistutil
rm -f /usr/bin/pr
rm -f /usr/bin/printenv
rm -f /usr/bin/printf
rm -f /usr/bin/psktool
rm -f /usr/bin/ptx
rm -f /usr/bin/quota
rm -f /usr/bin/realpath
rm -f /usr/bin/recode-sr-latin
rm -f /usr/bin/renice
rm -f /usr/bin/reset
rm -f /usr/bin/results9.txt
rm -f /usr/bin/rsync
rm -f /usr/bin/runcon
rm -f /usr/bin/sbdidlaunch
rm -f /usr/bin/sbreload
rm -f /usr/bin/scp
rm -f /usr/bin/script
rm -f /usr/bin/sdiff
rm -f /usr/bin/seq
rm -f /usr/bin/sexp-conv
rm -f /usr/bin/sftp
rm -f /usr/bin/sha1sum
rm -f /usr/bin/sha224sum
rm -f /usr/bin/sha256sum
rm -f /usr/bin/sha384sum
rm -f /usr/bin/sha512sum
rm -f /usr/bin/shred
rm -f /usr/bin/shuf
rm -f /usr/bin/sinject
rm -f /usr/bin/sort
rm -f /usr/bin/split
rm -f /usr/bin/srptool
# rm -f /usr/bin/ssh
# rm -f /usr/bin/ssh-add
# rm -f /usr/bin/ssh-agent
# rm -f /usr/bin/ssh-keygen
# rm -f /usr/bin/ssh-keyscan
rm -f /usr/bin/stat
rm -f /usr/bin/stdbuf
rm -f /usr/bin/sum
rm -f /usr/bin/sw_vers
rm -f /usr/bin/tac
rm -f /usr/bin/tail
rm -f /usr/bin/tar
rm -f /usr/bin/tee
rm -f /usr/bin/test
rm -f /usr/bin/tic
rm -f /usr/bin/time
rm -f /usr/bin/timeout
rm -f /usr/bin/toe
rm -f /usr/bin/tput
rm -f /usr/bin/tr
rm -f /usr/bin/truncate
rm -f /usr/bin/trust
rm -f /usr/bin/tset
rm -f /usr/bin/tsort
rm -f /usr/bin/tty
rm -f /usr/bin/uicache
rm -f /usr/bin/uiduid
rm -f /usr/bin/uiopen
rm -f /usr/bin/unexpand
rm -f /usr/bin/uniq
rm -f /usr/bin/unlink
rm -f /usr/bin/unlz4
rm -f /usr/bin/unlzma
rm -f /usr/bin/unrar
rm -f /usr/bin/unxz
rm -f /usr/bin/unzip
rm -f /usr/bin/unzipsfx
rm -f /usr/bin/update-alternatives
rm -f /usr/bin/updatedb
rm -f /usr/bin/uptime
rm -f /usr/bin/users
rm -f /usr/bin/watchgnupg
rm -f /usr/bin/wc
rm -f /usr/bin/which
rm -f /usr/bin/who
rm -f /usr/bin/whoami
rm -f /usr/bin/xargs
rm -f /usr/bin/xgettext
rm -f /usr/bin/xz
rm -f /usr/bin/xzcat
rm -f /usr/bin/xzcmp
rm -f /usr/bin/xzdec
rm -f /usr/bin/xzdiff
rm -f /usr/bin/xzegrep
rm -f /usr/bin/xzfgrep
rm -f /usr/bin/xzgrep
rm -f /usr/bin/xzless
rm -f /usr/bin/xzmore
rm -f /usr/bin/yat2m
rm -f /usr/bin/yes
rm -f /usr/bin/zip
rm -f /usr/bin/zipcloak
rm -f /usr/bin/zipnote
rm -f /usr/bin/zipsplit

# Cleanup "/usr/etc" (DONE)
rm -rf /usr/etc

# Cleanup "/usr/games" (DONE)
rm -rf /usr/games

# Cleanup "/usr/include" (DONE"
rm -rf /usr/include/*

# Cleanup "/usr/lib" (DONE)
rm -f  /usr/lib/_ncurses
rm -f  /usr/lib/apt
rm -rf /usr/lib/bash
rm -rf /usr/lib/engines-1.0
rm -rf /usr/lib/engines-1.1
rm -rf /usr/lib/gettext
rm -rf /usr/lib/log/*
rm -rf /usr/lib/p7zip
rm -f  /usr/lib/p11-kit-proxy.dylib
rm -rf /usr/lib/pkcs11
rm -rf /usr/lib/pkgconfig
rm -rf /usr/lib/ssl
rm -f  /usr/lib/substitute-inserter.dylib
rm -f  /usr/lib/substitute-loader.dylib
rm -f  /usr/lib/SubstrateInjector.dylib
rm -f  /usr/lib/terminfo
rm -f  /usr/lib/tweakloader.dylib
rm -f  /usr/lib/libapt*.dylib
rm -f  /usr/lib/libarchive.dylib
rm -f  /usr/lib/libas*.*
rm -f  /usr/lib/libcrypto*.dylib
rm -f  /usr/lib/libdb-6.2.dylib
rm -f  /usr/lib/libdb-6.dylib
rm -f  /usr/lib/libdb.dylib
rm -f  /usr/lib/libdpkg.a
rm -f  /usr/lib/libform.5.dylib
rm -f  /usr/lib/libform.6.dylib
rm -f  /usr/lib/libform5.dylib
rm -f  /usr/lib/libformw.5.dylib
rm -f  /usr/lib/libformw.6.dylib
rm -f  /usr/lib/libformw.dylib
rm -f  /usr/lib/libformw5.dylib
rm -f  /usr/lib/libgcrypt*.*
rm -f  /usr/lib/libgettext*.*
rm -f  /usr/lib/libgmp*.*
rm -f  /usr/lib/libgnu*.*
rm -f  /usr/lib/libgpg*.*
rm -f  /usr/lib/libhistory*.dylib
rm -f  /usr/lib/libhogweed*.dylib
rm -f  /usr/lib/libidn*.*
rm -f  /usr/lib/libintl*.dylib
rm -f  /usr/lib/libksba*.*
rm -f  /usr/lib/liblz4*.dylib
rm -f  /usr/lib/liblzmadec*.dylib
rm -f  /usr/lib/libmagic*.*
rm -f  /usr/lib/libmenu*.dylib
rm -f  /usr/lib/libncurses.6.dylib
rm -f  /usr/lib/libncurses5.dylib
rm -f  /usr/lib/libncurses6.dylib
rm -f  /usr/lib/libncursesw.5.dylib
rm -f  /usr/lib/libncursesw.6.dylib
rm -f  /usr/lib/libncursesw.dylib
rm -f  /usr/lib/libncursesw5.dylib
rm -f  /usr/lib/libncursesw6.dylib
rm -f  /usr/lib/libnettle*.dylib
rm -f  /usr/lib/libnpth*.*
rm -f  /usr/lib/libp11*.*
rm -f  /usr/lib/libpanel*.*
rm -f  /usr/lib/libplist*.dylib
rm -f  /usr/lib/libprefs.dylib
rm -f  /usr/lib/libreadline*.dylib
rm -f  /usr/lib/libssl*.dylib
rm -f  /usr/lib/libsubstitute*.dylib
rm -f  /usr/lib/libtasn1*.*
rm -f  /usr/lib/libunistring*.*

# Cleanup "/usr/libexec" (DONE)
rm -rf /usr/libexec/apt
rm -rf /usr/libexec/coreutils
rm -rf /usr/libexec/cydia
rm -rf /usr/libexec/dpkg
rm -rf /usr/libexec/filza
rm -rf /usr/libexec/p11-kit
# rm -f  /usr/libexec/sshd-keygen-wrapper
rm -f  /usr/libexec/vndevice
rm -f  /usr/libexec/gpg-check-pattern
rm -f  /usr/libexec/gpg-preset-passphrase
rm -f  /usr/libexec/gpg-protect-tool
rm -f  /usr/libexec/gpg-wks-client
rm -f  /usr/libexec/scdaemon
rm -f  /usr/libexec/bigram
rm -f  /usr/libexec/code
rm -f  /usr/libexec/frcode
rm -f  /usr/libexec/firmware.sh
rm -f  /usr/libexec/substitute
rm -f  /usr/libexec/substituted
rm -f  /usr/libexec/substitute-reload
rm -f  /usr/libexec/ldid
rm -f  /usr/libexec/sftp-server
# rm -f  /usr/libexec/ssh-keysign
# rm -f  /usr/libexec/sshpkcs11-helper
# rm -f  /usr/libexec/ssh-sk-helper

# Cleanup "/usr/local" (DONE)
rm -rf /usr/local/lib

# Cleanup "/usr/sbin" (DONE)
rm -f /usr/sbin/absd.sbin
rm -f /usr/sbin/ac
rm -f /usr/sbin/accton
rm -f /usr/sbin/addgnupghome
rm -f /usr/sbin/addNetworkInterface.sbin
rm -f /usr/sbin/applygnupgdefaults
rm -f /usr/sbin/aslmanager.sbin
rm -f /usr/sbin/BlueTool.sbin
rm -f /usr/sbin/bluetoothd.sbin
rm -f /usr/sbin/BTAvrcp.sbin
rm -f /usr/sbin/BTLEServer.sbin
rm -f /usr/sbin/BTMap.sbin
rm -f /usr/sbin/BTPbap.sbin
rm -f /usr/sbin/cfprefsd.sbin
rm -f /usr/sbin/chown
rm -f /usr/sbin/chroot
rm -f /usr/sbin/dev_mkdb
rm -f /usr/sbin/distnoted.sbin
rm -f /usr/sbin/edquota
rm -f /usr/sbin/fdisk
rm -f /usr/sbin/filecoordinationd.sbin
rm -f /usr/sbin/ioreg.sbin
rm -f /usr/sbin/iostat
rm -f /usr/sbin/ipconfig.sbin
rm -f /usr/sbin/mDNSResponder.sbin
rm -f /usr/sbin/mDNSResponderHelper.sbin
rm -f /usr/sbin/mediaserverd.sbin
rm -f /usr/sbin/mkfile
rm -f /usr/sbin/nologin
rm -f /usr/sbin/notifyd.sbin
rm -f /usr/sbin/nvram.sbin
rm -f /usr/sbin/pppd.sbin
rm -f /usr/sbin/pwd_mkdb
rm -f /usr/sbin/quotaon
rm -f /usr/sbin/racoon.sbin
rm -f /usr/sbin/reboot
rm -f /usr/sbin/repquota
rm -f /usr/sbin/rtadvd.sbin
rm -f /usr/sbin/scutil.sbin
rm -f /usr/sbin/spindump.sbin
# rm -f /usr/sbin/sshd
rm -f /usr/sbin/startupfiletool
rm -f /usr/sbin/sysctl
rm -f /usr/sbin/syslogd.sbin
rm -f /usr/sbin/vifs
rm -f /usr/sbin/vipw
rm -f /usr/sbin/vsdbutil
rm -f /usr/sbin/wifid.sbin
rm -f /usr/sbin/wirelessproxd
rm -f /usr/sbin/WirelessRadioManagerd.sbin
rm -f /usr/sbin/zdump
rm -f /usr/sbin/zic

# Cleanup "/usr/share" (DONE)
rm -rf /usr/share/aclocal
rm -rf /usr/share/bigboss
rm -rf /usr/share/common-lisp
rm -rf /usr/share/dict
rm -rf /usr/share/dpkg
rm -rf /usr/share/entitlements
rm -rf /usr/share/gnupg
rm -rf /usr/share/libgpg-error
rm -f  /usr/share/misc/magic.mgc
rm -rf /usr/share/p11-kit
rm -rf /usr/share/polkit-1
rm -rf /usr/share/substitute
rm -rf /usr/share/tabset
rm -rf /usr/share/terminfo

# Cleanup "/var".  NOTE, anything inside "/var/mobile" can be safely deleted.  Be very careful deleting anything else
# inside "/var", as that is very dangerous.
rm -rf /var/binpack
rm -f  /var/checkra1n.dmg
rm -f  /var/dropbear_rsa_host_key
rm -f  /var/jb

# Cleanup "/var/cache"
rm -rf /var/cache/*

# Cleanup "/var/containers"
rm -rf /var/containers/Bundle/Application/F67BC349-74D3-4CB1-8191-FAED69EAA00F #uncover
rm -rf /var/containers/Bundle/Users/checkmate

# Cleanup "/var/lib"
rm -rf /var/lib/*

# Cleanup "/var/log"
rm -rf /var/log/*

# Cleanup "/var/mnt"
rm -rf /var/mnt

# Cleanup "/var/mobile".
rm -rf /var/mobile/Containers/Shared/AppGroup/2AC59189-BAB6-4974-BC68-23A4AE0EC8FD
rm -rf /var/mobile/Containers/Data/Application/1BD7FCE9-C280-4AF0-A965-64DC4DBCB74B # Cydia
rm -rf /var/mobile/Containers/Data/Application/404816C6-9123-4CEE-BB9F-ECE51CDB316A # Filza
rm -rf /var/mobile/Containers/Data/Application/9A27EDC5-D4AC-43CD-9D11-A5E6EBD3F210 # Sileo
rm -rf /var/mobile/Containers/Data/Application/8FDEAD27-158A-4098-9AF6-30DA57CC7C22 # Sileo 2
rm -rf /var/mobile/Containers/Data/Application/9640F7D2-A018-4C09-8909-120FD49CE6C7 # Uncover
rm -rf /var/mobile/Containers/Data/Application/0797C1F3-48B4-46E5-AD9F-6C5AD0841B08 # Succession
rm -rf /var/mobile/Containers/Data/PluginKitPlugin/7C7947DF-0819-4247-931B-91474E65CA00 # Save to filza
rm -rf /var/mobile/Library/Saved Application State/*
rm -rf /var/mobile/Library/Cydia
rm -rf /var/mobile/Library/Logs/*
rm -rf /var/mobile/Library/Caches/*
rm -rf /var/mobile/Library/Cookies/*
rm -rf /var/mobile/Library/Filza
rm -r  /var/mobile/Library/Preferences/anondev.LocalIAPStore.plist
rm -r  /var/mobile/Library/Preferences/com.samgisaninja.SuccessionRestore.plist
rm -r  /var/mobile/Library/Preferences/com.saurik.Cydia.plist
rm -r  /var/mobile/Library/Preferences/com.tigisoftware.Filza.plist
rm -f  /var/mobile/succession.log
rm -rf /var/mobile/Media/Succession

# Cleanup "/var/tmp"
rm -f  /var/tmp/cydia.log

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

# These are the last of the "important" files and directories.  These will 
# include SSL, SSH and Filza.

# Remove SSH Stuff.
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
rm -f  /usr/libexec/sshd-keygen-wrapper
rm -f  /usr/libexec/ssh-keysign
rm -f  /usr/libexec/sshpkcs11-helper
rm -f  /usr/libexec/ssh-sk-helper
rm -f  /usr/sbin/sshd

# Remove SSL Stuff.
rm -rf /usr/lib/engines-1.0
rm -rf /usr/lib/engines-1.1
rm -f  /usr/lib/libcrypto.1.0.0.dylib
rm -f  /usr/lib/libssl.1.0.0.dylib
rm -f  /usr/lib/libcrypto.1.1.dylib
rm -f  /usr/lib/libssl.1.1.dylib

# Clear cache and remove the last of the system files.
echo "Remember to delete these files and directories manually!" 
echo "/var/root/.bash_history"
rm -f /bin/chmod
rm -f /bin/cp
rm -f /bin/echo
rm -f /bin/ls
rm -f /bin/mkdir
rm -f /bin/rm

# do these!
rm -f  /usr/libexec/sftp-server
rm -f /usr/sbin/sshd
rm -f  /var/dropbear_rsa_host_key

/uninstall/uicache
/uninstall/rm -f  /var/root/.bash_history
/uninstall/rm -f  /uninstall

