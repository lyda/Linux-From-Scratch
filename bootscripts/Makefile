ETCDIR=/etc
EXTDIR=${DESTDIR}${ETCDIR}

all: install

create-dirs:
	install -d -m 755 ${EXTDIR}/rc.d/rc{0,1,2,3,4,5,6,sysinit}.d
	install -d -m 755 ${EXTDIR}/rc.d/init.d

create-service-dir:
	install -d -m 755 ${EXTDIR}/sysconfig/network-devices/services

install: create-dirs create-service-dir
	install -m 754 lfs/init.d/checkfs      ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/cleanfs      ${EXTDIR}/rc.d/init.d/
	install -m 644 lfs/init.d/functions    ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/halt         ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/loadkeys     ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/localnet     ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/mountfs      ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/mountkernfs  ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/network      ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/rc           ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/reboot       ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/sendsignals  ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/setclock     ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/swap         ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/sysklogd     ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/template     ${EXTDIR}/rc.d/init.d/
	ln -s ../init.d/sysklogd    ${EXTDIR}/rc.d/rc0.d/K40sysklogd
	ln -s ../init.d/network     ${EXTDIR}/rc.d/rc0.d/K50network
	ln -s ../init.d/sendsignals ${EXTDIR}/rc.d/rc0.d/K60sendsignals
	ln -s ../init.d/mountfs     ${EXTDIR}/rc.d/rc0.d/K70mountfs
	ln -s ../init.d/swap        ${EXTDIR}/rc.d/rc0.d/K80swap
	ln -s ../init.d/localnet    ${EXTDIR}/rc.d/rc0.d/K90localnet
	ln -s ../init.d/halt        ${EXTDIR}/rc.d/rc0.d/K99halt
	ln -s ../init.d/sysklogd    ${EXTDIR}/rc.d/rc1.d/K80sysklogd
	ln -s ../init.d/network     ${EXTDIR}/rc.d/rc1.d/K90network
	ln -s ../init.d/sysklogd    ${EXTDIR}/rc.d/rc2.d/K80sysklogd
	ln -s ../init.d/network     ${EXTDIR}/rc.d/rc2.d/K90network
	ln -s ../init.d/sysklogd    ${EXTDIR}/rc.d/rc3.d/S10sysklogd
	ln -s ../init.d/network     ${EXTDIR}/rc.d/rc3.d/S20network
	ln -s ../init.d/sysklogd    ${EXTDIR}/rc.d/rc4.d/S10sysklogd
	ln -s ../init.d/network     ${EXTDIR}/rc.d/rc4.d/S20network
	ln -s ../init.d/sysklogd    ${EXTDIR}/rc.d/rc5.d/S10sysklogd
	ln -s ../init.d/network     ${EXTDIR}/rc.d/rc5.d/S20network
	ln -s ../init.d/sysklogd    ${EXTDIR}/rc.d/rc6.d/K40sysklogd
	ln -s ../init.d/network     ${EXTDIR}/rc.d/rc6.d/K50network
	ln -s ../init.d/sendsignals ${EXTDIR}/rc.d/rc6.d/K60sendsignals
	ln -s ../init.d/mountfs     ${EXTDIR}/rc.d/rc6.d/K70mountfs
	ln -s ../init.d/swap        ${EXTDIR}/rc.d/rc6.d/K80swap
	ln -s ../init.d/localnet    ${EXTDIR}/rc.d/rc6.d/K90localnet
	ln -s ../init.d/reboot      ${EXTDIR}/rc.d/rc6.d/K99reboot
	ln -s ../init.d/swap        ${EXTDIR}/rc.d/rcsysinit.d/S10swap
	ln -s ../init.d/mountkernfs ${EXTDIR}/rc.d/rcsysinit.d/S20mountkernfs
	ln -s ../init.d/checkfs     ${EXTDIR}/rc.d/rcsysinit.d/S30checkfs
	ln -s ../init.d/mountfs     ${EXTDIR}/rc.d/rcsysinit.d/S40mountfs
	ln -s ../init.d/cleanfs     ${EXTDIR}/rc.d/rcsysinit.d/S50cleanfs
	ln -s ../init.d/setclock    ${EXTDIR}/rc.d/rcsysinit.d/S60setclock
	ln -s ../init.d/loadkeys    ${EXTDIR}/rc.d/rcsysinit.d/S70loadkeys
	ln -s ../init.d/localnet    ${EXTDIR}/rc.d/rcsysinit.d/S80localnet
	install -m 644 lfs/sysconfig/rc                              ${EXTDIR}/sysconfig/
	install -m 754 lfs/sysconfig/network-devices/ifup            ${EXTDIR}/sysconfig/network-devices
	install -m 754 lfs/sysconfig/network-devices/ifdown          ${EXTDIR}/sysconfig/network-devices
	install -m 754 lfs/sysconfig/network-devices/services/static ${EXTDIR}/sysconfig/network-devices/services


install-service-dhclient: create-service-dir
	install -m 754 blfs/sysconfig/network-devices/services/dhclient ${EXTDIR}/sysconfig/network-devices/services

install-service-dhcpcd: create-service-dir
	install -m 754 blfs/sysconfig/network-devices/services/dhcpcd   ${EXTDIR}/sysconfig/network-devices/services

install-service-ipx: create-service-dir
	install -m 754 blfs/sysconfig/network-devices/services/ipx      ${EXTDIR}/sysconfig/network-devices/services

install-service-pppoe: create-service-dir
	install -m 754 blfs/sysconfig/network-devices/services/pppoe    ${EXTDIR}/sysconfig/network-devices/services


install-alsa: create-dirs
	install -m 754 blfs/init.d/alsa       ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/alsa ${EXTDIR}/rc.d/rc0.d/K35alsa
	ln -s  ../init.d/alsa ${EXTDIR}/rc.d/rc1.d/K35alsa
	ln -s  ../init.d/alsa ${EXTDIR}/rc.d/rc2.d/S40alsa
	ln -s  ../init.d/alsa ${EXTDIR}/rc.d/rc3.d/S40alsa
	ln -s  ../init.d/alsa ${EXTDIR}/rc.d/rc4.d/S40alsa
	ln -s  ../init.d/alsa ${EXTDIR}/rc.d/rc5.d/S40alsa
	ln -s  ../init.d/alsa ${EXTDIR}/rc.d/rc6.d/K35alsa

install-apache: create-dirs
	install -m 754 blfs/init.d/apache     ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/apache ${EXTDIR}/rc.d/rc0.d/K28apache
	ln -s  ../init.d/apache ${EXTDIR}/rc.d/rc1.d/K28apache
	ln -s  ../init.d/apache ${EXTDIR}/rc.d/rc2.d/K28apache
	ln -s  ../init.d/apache ${EXTDIR}/rc.d/rc3.d/S32apache
	ln -s  ../init.d/apache ${EXTDIR}/rc.d/rc4.d/S32apache
	ln -s  ../init.d/apache ${EXTDIR}/rc.d/rc5.d/S32apache
	ln -s  ../init.d/apache ${EXTDIR}/rc.d/rc6.d/K28apache

install-bind: create-dirs
	install -m 754 blfs/init.d/bind       ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/bind ${EXTDIR}/rc.d/rc0.d/K49bind
	ln -s  ../init.d/bind ${EXTDIR}/rc.d/rc1.d/K49bind
	ln -s  ../init.d/bind ${EXTDIR}/rc.d/rc2.d/K49bind
	ln -s  ../init.d/bind ${EXTDIR}/rc.d/rc3.d/S22bind
	ln -s  ../init.d/bind ${EXTDIR}/rc.d/rc4.d/S22bind
	ln -s  ../init.d/bind ${EXTDIR}/rc.d/rc5.d/S22bind
	ln -s  ../init.d/bind ${EXTDIR}/rc.d/rc6.d/K49bind

install-cups: create-dirs
	install -m 754 blfs/init.d/cups       ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/cups ${EXTDIR}/rc.d/rc0.d/K00cups
	ln -s  ../init.d/cups ${EXTDIR}/rc.d/rc1.d/K00cups
	ln -s  ../init.d/cups ${EXTDIR}/rc.d/rc2.d/S99cups
	ln -s  ../init.d/cups ${EXTDIR}/rc.d/rc3.d/S99cups
	ln -s  ../init.d/cups ${EXTDIR}/rc.d/rc4.d/S99cups
	ln -s  ../init.d/cups ${EXTDIR}/rc.d/rc5.d/S99cups
	ln -s  ../init.d/cups ${EXTDIR}/rc.d/rc6.d/K00cups

install-dhcp: create-dirs
	install -m 754 blfs/init.d/dhcp       ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/dhcp ${EXTDIR}/rc.d/rc0.d/K30dhcp
	ln -s  ../init.d/dhcp ${EXTDIR}/rc.d/rc1.d/K30dhcp
	ln -s  ../init.d/dhcp ${EXTDIR}/rc.d/rc2.d/K30dhcp
	ln -s  ../init.d/dhcp ${EXTDIR}/rc.d/rc3.d/S30dhcp
	ln -s  ../init.d/dhcp ${EXTDIR}/rc.d/rc4.d/S30dhcp
	ln -s  ../init.d/dhcp ${EXTDIR}/rc.d/rc5.d/S30dhcp
	ln -s  ../init.d/dhcp ${EXTDIR}/rc.d/rc6.d/K30dhcp

install-exim: create-dirs
	install -m 754 blfs/init.d/exim       ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/exim ${EXTDIR}/rc.d/rc0.d/K25exim
	ln -s  ../init.d/exim ${EXTDIR}/rc.d/rc1.d/K25exim
	ln -s  ../init.d/exim ${EXTDIR}/rc.d/rc2.d/K25exim
	ln -s  ../init.d/exim ${EXTDIR}/rc.d/rc3.d/S35exim
	ln -s  ../init.d/exim ${EXTDIR}/rc.d/rc4.d/S35exim
	ln -s  ../init.d/exim ${EXTDIR}/rc.d/rc5.d/S35exim
	ln -s  ../init.d/exim ${EXTDIR}/rc.d/rc6.d/K25exim

install-fam: create-dirs
	install -m 754 blfs/init.d/fam      ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/fam ${EXTDIR}/rc.d/rc0.d/K37fam
	ln -s  ../init.d/fam ${EXTDIR}/rc.d/rc1.d/K37fam
	ln -s  ../init.d/fam ${EXTDIR}/rc.d/rc2.d/S23fam
	ln -s  ../init.d/fam ${EXTDIR}/rc.d/rc3.d/S23fam
	ln -s  ../init.d/fam ${EXTDIR}/rc.d/rc4.d/S23fam
	ln -s  ../init.d/fam ${EXTDIR}/rc.d/rc5.d/S23fam
	ln -s  ../init.d/fam ${EXTDIR}/rc.d/rc6.d/K39fam

install-fcron: create-dirs
	install -m 754 blfs/init.d/fcron      ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/fcron ${EXTDIR}/rc.d/rc0.d/K08fcron
	ln -s  ../init.d/fcron ${EXTDIR}/rc.d/rc1.d/K08fcron
	ln -s  ../init.d/fcron ${EXTDIR}/rc.d/rc2.d/S40fcron
	ln -s  ../init.d/fcron ${EXTDIR}/rc.d/rc3.d/S40fcron
	ln -s  ../init.d/fcron ${EXTDIR}/rc.d/rc4.d/S40fcron
	ln -s  ../init.d/fcron ${EXTDIR}/rc.d/rc5.d/S40fcron
	ln -s  ../init.d/fcron ${EXTDIR}/rc.d/rc6.d/K08fcron

install-gdm: create-dirs
	install -m 754 blfs/init.d/gdm        ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/gdm ${EXTDIR}/rc.d/rc0.d/K05gdm
	ln -s  ../init.d/gdm ${EXTDIR}/rc.d/rc1.d/K05gdm
	ln -s  ../init.d/gdm ${EXTDIR}/rc.d/rc2.d/K05gdm
	ln -s  ../init.d/gdm ${EXTDIR}/rc.d/rc3.d/K05gdm
	ln -s  ../init.d/gdm ${EXTDIR}/rc.d/rc4.d/K05gdm
	ln -s  ../init.d/gdm ${EXTDIR}/rc.d/rc5.d/S95gdm
	ln -s  ../init.d/gdm ${EXTDIR}/rc.d/rc6.d/K05gdm

install-gpm: create-dirs
	install -m 754 blfs/init.d/gpm        ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/gpm ${EXTDIR}/rc.d/rc0.d/K10gpm
	ln -s  ../init.d/gpm ${EXTDIR}/rc.d/rc1.d/K10gpm
	ln -s  ../init.d/gpm ${EXTDIR}/rc.d/rc2.d/K10gpm
	ln -s  ../init.d/gpm ${EXTDIR}/rc.d/rc3.d/S70gpm
	ln -s  ../init.d/gpm ${EXTDIR}/rc.d/rc4.d/S70gpm
	ln -s  ../init.d/gpm ${EXTDIR}/rc.d/rc5.d/S70gpm
	ln -s  ../init.d/gpm ${EXTDIR}/rc.d/rc6.d/K10gpm

install-lprng: create-dirs
	install -m 754 blfs/init.d/lprng      ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/lprng ${EXTDIR}/rc.d/rc0.d/K00lprng
	ln -s  ../init.d/lprng ${EXTDIR}/rc.d/rc1.d/K00lprng
	ln -s  ../init.d/lprng ${EXTDIR}/rc.d/rc2.d/S99lprng
	ln -s  ../init.d/lprng ${EXTDIR}/rc.d/rc3.d/S99lprng
	ln -s  ../init.d/lprng ${EXTDIR}/rc.d/rc4.d/S99lprng
	ln -s  ../init.d/lprng ${EXTDIR}/rc.d/rc5.d/S99lprng
	ln -s  ../init.d/lprng ${EXTDIR}/rc.d/rc6.d/K00lprng

install-mysql: create-dirs
	install -m 754 blfs/init.d/mysql      ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/mysql ${EXTDIR}/rc.d/rc0.d/K26mysql
	ln -s  ../init.d/mysql ${EXTDIR}/rc.d/rc1.d/K26mysql
	ln -s  ../init.d/mysql ${EXTDIR}/rc.d/rc2.d/K26mysql
	ln -s  ../init.d/mysql ${EXTDIR}/rc.d/rc3.d/S34mysql
	ln -s  ../init.d/mysql ${EXTDIR}/rc.d/rc4.d/S34mysql
	ln -s  ../init.d/mysql ${EXTDIR}/rc.d/rc5.d/S34mysql
	ln -s  ../init.d/mysql ${EXTDIR}/rc.d/rc6.d/K26mysql

install-netfs: create-dirs
	install -m 754 blfs/init.d/netfs      ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/netfs ${EXTDIR}/rc.d/rc0.d/K47netfs
	ln -s  ../init.d/netfs ${EXTDIR}/rc.d/rc1.d/K47netfs
	ln -s  ../init.d/netfs ${EXTDIR}/rc.d/rc2.d/K47netfs
	ln -s  ../init.d/netfs ${EXTDIR}/rc.d/rc3.d/S28netfs
	ln -s  ../init.d/netfs ${EXTDIR}/rc.d/rc4.d/S28netfs
	ln -s  ../init.d/netfs ${EXTDIR}/rc.d/rc5.d/S28netfs
	ln -s  ../init.d/netfs ${EXTDIR}/rc.d/rc6.d/K47netfs

install-nfs-client: create-dirs
	install -m 754 blfs/init.d/nfs-client ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/nfs-client ${EXTDIR}/rc.d/rc0.d/K48nfs-client
	ln -s  ../init.d/nfs-client ${EXTDIR}/rc.d/rc1.d/K48nfs-client
	ln -s  ../init.d/nfs-client ${EXTDIR}/rc.d/rc2.d/K48nfs-client
	ln -s  ../init.d/nfs-client ${EXTDIR}/rc.d/rc3.d/S24nfs-client
	ln -s  ../init.d/nfs-client ${EXTDIR}/rc.d/rc4.d/S24nfs-client
	ln -s  ../init.d/nfs-client ${EXTDIR}/rc.d/rc5.d/S24nfs-client
	ln -s  ../init.d/nfs-client ${EXTDIR}/rc.d/rc6.d/K48nfs-client

install-nfs-server: create-dirs
	install -m 754 blfs/init.d/nfs-server ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/nfs-server ${EXTDIR}/rc.d/rc0.d/K48nfs-server
	ln -s  ../init.d/nfs-server ${EXTDIR}/rc.d/rc1.d/K48nfs-server
	ln -s  ../init.d/nfs-server ${EXTDIR}/rc.d/rc2.d/K48nfs-server
	ln -s  ../init.d/nfs-server ${EXTDIR}/rc.d/rc3.d/S24nfs-server
	ln -s  ../init.d/nfs-server ${EXTDIR}/rc.d/rc4.d/S24nfs-server
	ln -s  ../init.d/nfs-server ${EXTDIR}/rc.d/rc5.d/S24nfs-server
	ln -s  ../init.d/nfs-server ${EXTDIR}/rc.d/rc6.d/K48nfs-server

install-ntp: create-dirs
	install -m 754 blfs/init.d/ntp        ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/ntp ${EXTDIR}/rc.d/rc0.d/K46ntp
	ln -s  ../init.d/ntp ${EXTDIR}/rc.d/rc1.d/K46ntp
	ln -s  ../init.d/ntp ${EXTDIR}/rc.d/rc2.d/K46ntp
	ln -s  ../init.d/ntp ${EXTDIR}/rc.d/rc3.d/S26ntp
	ln -s  ../init.d/ntp ${EXTDIR}/rc.d/rc4.d/S26ntp
	ln -s  ../init.d/ntp ${EXTDIR}/rc.d/rc5.d/S26npt
	ln -s  ../init.d/ntp ${EXTDIR}/rc.d/rc6.d/K46ntp

install-portmap: create-dirs
	install -m 754 blfs/init.d/portmap    ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/portmap ${EXTDIR}/rc.d/rc0.d/K49portmap
	ln -s  ../init.d/portmap ${EXTDIR}/rc.d/rc1.d/K49portmap
	ln -s  ../init.d/portmap ${EXTDIR}/rc.d/rc2.d/K49portmap
	ln -s  ../init.d/portmap ${EXTDIR}/rc.d/rc3.d/S22portmap
	ln -s  ../init.d/portmap ${EXTDIR}/rc.d/rc4.d/S22portmap
	ln -s  ../init.d/portmap ${EXTDIR}/rc.d/rc5.d/S22portmap
	ln -s  ../init.d/portmap ${EXTDIR}/rc.d/rc6.d/K49portmap

install-postfix: create-dirs
	install -m 754 blfs/init.d/postfix    ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/postfix ${EXTDIR}/rc.d/rc0.d/K25postfix
	ln -s  ../init.d/postfix ${EXTDIR}/rc.d/rc1.d/K25postfix
	ln -s  ../init.d/postfix ${EXTDIR}/rc.d/rc2.d/K25postfix
	ln -s  ../init.d/postfix ${EXTDIR}/rc.d/rc3.d/S35postfix
	ln -s  ../init.d/postfix ${EXTDIR}/rc.d/rc4.d/S35postfix
	ln -s  ../init.d/postfix ${EXTDIR}/rc.d/rc5.d/S35postfix
	ln -s  ../init.d/postfix ${EXTDIR}/rc.d/rc6.d/K25postfix

install-postgresql: create-dirs
	install -m 754 blfs/init.d/postgresql ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/postgresql ${EXTDIR}/rc.d/rc0.d/K26postgresql
	ln -s  ../init.d/postgresql ${EXTDIR}/rc.d/rc1.d/K26postgresql
	ln -s  ../init.d/postgresql ${EXTDIR}/rc.d/rc2.d/K26postgresql
	ln -s  ../init.d/postgresql ${EXTDIR}/rc.d/rc3.d/S34postgresql
	ln -s  ../init.d/postgresql ${EXTDIR}/rc.d/rc4.d/S34postgresql
	ln -s  ../init.d/postgresql ${EXTDIR}/rc.d/rc5.d/S34postgresql
	ln -s  ../init.d/postgresql ${EXTDIR}/rc.d/rc6.d/K26postgresql

install-proftpd: create-dirs
	install -m 754 blfs/init.d/proftpd    ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/proftpd ${EXTDIR}/rc.d/rc0.d/K28proftpd
	ln -s  ../init.d/proftpd ${EXTDIR}/rc.d/rc1.d/K28proftpd
	ln -s  ../init.d/proftpd ${EXTDIR}/rc.d/rc2.d/K28proftpd
	ln -s  ../init.d/proftpd ${EXTDIR}/rc.d/rc3.d/S32proftpd
	ln -s  ../init.d/proftpd ${EXTDIR}/rc.d/rc4.d/S32proftpd
	ln -s  ../init.d/proftpd ${EXTDIR}/rc.d/rc5.d/S32proftpd
	ln -s  ../init.d/proftpd ${EXTDIR}/rc.d/rc6.d/K28proftpd

install-random: create-dirs
	install -m 754 blfs/init.d/random     ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/random ${EXTDIR}/rc.d/rc0.d/K45random
	ln -s  ../init.d/random ${EXTDIR}/rc.d/rc1.d/S25random
	ln -s  ../init.d/random ${EXTDIR}/rc.d/rc2.d/S25random
	ln -s  ../init.d/random ${EXTDIR}/rc.d/rc3.d/S25random
	ln -s  ../init.d/random ${EXTDIR}/rc.d/rc4.d/S25random
	ln -s  ../init.d/random ${EXTDIR}/rc.d/rc5.d/S25random
	ln -s  ../init.d/random ${EXTDIR}/rc.d/rc6.d/K45random

install-rsyncd: create-dirs
	install -m 754 blfs/init.d/rsyncd     ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/rsyncd ${EXTDIR}/rc.d/rc0.d/K30rsyncd
	ln -s  ../init.d/rsyncd ${EXTDIR}/rc.d/rc1.d/K30rsyncd
	ln -s  ../init.d/rsyncd ${EXTDIR}/rc.d/rc2.d/K30rsyncd
	ln -s  ../init.d/rsyncd ${EXTDIR}/rc.d/rc3.d/S30rsyncd
	ln -s  ../init.d/rsyncd ${EXTDIR}/rc.d/rc4.d/S30rsyncd
	ln -s  ../init.d/rsyncd ${EXTDIR}/rc.d/rc5.d/S30rsyncd
	ln -s  ../init.d/rsyncd ${EXTDIR}/rc.d/rc6.d/K30rsyncd

install-samba: create-dirs
	install -m 754 blfs/init.d/samba      ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/samba ${EXTDIR}/rc.d/rc0.d/K48samba
	ln -s  ../init.d/samba ${EXTDIR}/rc.d/rc1.d/K48samba
	ln -s  ../init.d/samba ${EXTDIR}/rc.d/rc2.d/K48samba
	ln -s  ../init.d/samba ${EXTDIR}/rc.d/rc3.d/S24samba
	ln -s  ../init.d/samba ${EXTDIR}/rc.d/rc4.d/S24samba
	ln -s  ../init.d/samba ${EXTDIR}/rc.d/rc5.d/S24samba
	ln -s  ../init.d/samba ${EXTDIR}/rc.d/rc6.d/K48samba

install-sendmail: create-dirs
	install -m 754 blfs/init.d/sendmail   ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/sendmail ${EXTDIR}/rc.d/rc0.d/K25sendmail
	ln -s  ../init.d/sendmail ${EXTDIR}/rc.d/rc1.d/K25sendmail
	ln -s  ../init.d/sendmail ${EXTDIR}/rc.d/rc2.d/K25sendmail
	ln -s  ../init.d/sendmail ${EXTDIR}/rc.d/rc3.d/S35sendmail
	ln -s  ../init.d/sendmail ${EXTDIR}/rc.d/rc4.d/S35sendmail
	ln -s  ../init.d/sendmail ${EXTDIR}/rc.d/rc5.d/S35sendmail
	ln -s  ../init.d/sendmail ${EXTDIR}/rc.d/rc6.d/K25sendmail

install-sshd: create-dirs
	install -m 754 blfs/init.d/sshd       ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/sshd ${EXTDIR}/rc.d/rc0.d/K30sshd
	ln -s  ../init.d/sshd ${EXTDIR}/rc.d/rc1.d/K30sshd
	ln -s  ../init.d/sshd ${EXTDIR}/rc.d/rc2.d/K30sshd
	ln -s  ../init.d/sshd ${EXTDIR}/rc.d/rc3.d/S30sshd
	ln -s  ../init.d/sshd ${EXTDIR}/rc.d/rc4.d/S30sshd
	ln -s  ../init.d/sshd ${EXTDIR}/rc.d/rc5.d/S30sshd
	ln -s  ../init.d/sshd ${EXTDIR}/rc.d/rc6.d/K30sshd

install-xinetd: create-dirs
	install -m 754 blfs/init.d/xinetd     ${EXTDIR}/rc.d/init.d/
	ln -s  ../init.d/xinetd ${EXTDIR}/rc.d/rc0.d/K49xinetd
	ln -s  ../init.d/xinetd ${EXTDIR}/rc.d/rc1.d/K49xinetd
	ln -s  ../init.d/xinetd ${EXTDIR}/rc.d/rc2.d/K49xinetd
	ln -s  ../init.d/xinetd ${EXTDIR}/rc.d/rc3.d/S23xinetd
	ln -s  ../init.d/xinetd ${EXTDIR}/rc.d/rc4.d/S23xinetd
	ln -s  ../init.d/xinetd ${EXTDIR}/rc.d/rc5.d/S23xinetd
	ln -s  ../init.d/xinetd ${EXTDIR}/rc.d/rc6.d/K49xinetd

.PHONY: install install-service-dhclient install-service-dhcpcd install-service-ipx install-service-pppoe install-alsa install-apache install-bind install-cups install-dhcp install-exim install-fcron install-gdm install-gpm install-lprng install-mysql install-netfs install-nfs-client install-nfs-server install-ntp install-portmap install-postfix install-postgresql install-proftpd install-random install-rsync install-samba install-sendmail install-sshd install-xinetd
