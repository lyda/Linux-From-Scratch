ETCDIR=/etc
EXTDIR=${DESTDIR}${ETCDIR}

all: install

create-dirs:
	install -d -m 755 ${EXTDIR}/rc.d/rc0.d
	install -d -m 755 ${EXTDIR}/rc.d/rc1.d
	install -d -m 755 ${EXTDIR}/rc.d/rc2.d
	install -d -m 755 ${EXTDIR}/rc.d/rc3.d
	install -d -m 755 ${EXTDIR}/rc.d/rc4.d
	install -d -m 755 ${EXTDIR}/rc.d/rc5.d
	install -d -m 755 ${EXTDIR}/rc.d/rc6.d
	install -d -m 755 ${EXTDIR}/rc.d/rcsysinit.d
	install -d -m 755 ${EXTDIR}/rc.d/init.d
	install -d -m 755 ${EXTDIR}/sysconfig

create-service-dir:
	install -d -m 755 ${EXTDIR}/sysconfig/network-devices/services

install: create-dirs create-service-dir
	install -m 754 lfs/init.d/checkfs      ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/cleanfs      ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/hotplug      ${EXTDIR}/rc.d/init.d
	install -m 644 lfs/init.d/functions    ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/halt         ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/console      ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/localnet     ${EXTDIR}/rc.d/init.d/
	install -m 754 lfs/init.d/modules      ${EXTDIR}/rc.d/init.d
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
	install -m 754 lfs/init.d/udev         ${EXTDIR}/rc.d/init.d
	ln -sf ../init.d/sysklogd    ${EXTDIR}/rc.d/rc0.d/K90sysklogd
	ln -sf ../init.d/network     ${EXTDIR}/rc.d/rc0.d/K80network
	ln -sf ../init.d/hotplug     ${EXTDIR}/rc.d/rc0.d/S50hotplug
	ln -sf ../init.d/sendsignals ${EXTDIR}/rc.d/rc0.d/S60sendsignals
	ln -sf ../init.d/mountfs     ${EXTDIR}/rc.d/rc0.d/S70mountfs
	ln -sf ../init.d/swap        ${EXTDIR}/rc.d/rc0.d/S80swap
	ln -sf ../init.d/localnet    ${EXTDIR}/rc.d/rc0.d/S90localnet
	ln -sf ../init.d/halt        ${EXTDIR}/rc.d/rc0.d/S99halt
	ln -sf ../init.d/sysklogd    ${EXTDIR}/rc.d/rc1.d/K90sysklogd
	ln -sf ../init.d/network     ${EXTDIR}/rc.d/rc1.d/K80network
	ln -sf ../init.d/sysklogd    ${EXTDIR}/rc.d/rc2.d/K90sysklogd
	ln -sf ../init.d/network     ${EXTDIR}/rc.d/rc2.d/K80network
	ln -sf ../init.d/sysklogd    ${EXTDIR}/rc.d/rc3.d/S10sysklogd
	ln -sf ../init.d/network     ${EXTDIR}/rc.d/rc3.d/S20network
	ln -sf ../init.d/sysklogd    ${EXTDIR}/rc.d/rc4.d/S10sysklogd
	ln -sf ../init.d/network     ${EXTDIR}/rc.d/rc4.d/S20network
	ln -sf ../init.d/sysklogd    ${EXTDIR}/rc.d/rc5.d/S10sysklogd
	ln -sf ../init.d/network     ${EXTDIR}/rc.d/rc5.d/S20network
	ln -sf ../init.d/network     ${EXTDIR}/rc.d/rc6.d/K80network
	ln -sf ../init.d/sysklogd    ${EXTDIR}/rc.d/rc6.d/K90sysklogd
	ln -sf ../init.d/hotplug     ${EXTDIR}/rc.d/rc6.d/S50hotplug
	ln -sf ../init.d/sendsignals ${EXTDIR}/rc.d/rc6.d/S60sendsignals
	ln -sf ../init.d/mountfs     ${EXTDIR}/rc.d/rc6.d/S70mountfs
	ln -sf ../init.d/swap        ${EXTDIR}/rc.d/rc6.d/S80swap
	ln -sf ../init.d/localnet    ${EXTDIR}/rc.d/rc6.d/S90localnet
	ln -sf ../init.d/reboot      ${EXTDIR}/rc.d/rc6.d/S99reboot
	ln -sf ../init.d/mountkernfs ${EXTDIR}/rc.d/rcsysinit.d/S00mountkernfs
	ln -sf ../init.d/modules     ${EXTDIR}/rc.d/rcsysinit.d/S05modules
	ln -sf ../init.d/udev        ${EXTDIR}/rc.d/rcsysinit.d/S10udev
	ln -sf ../init.d/swap        ${EXTDIR}/rc.d/rcsysinit.d/S20swap
	ln -sf ../init.d/checkfs     ${EXTDIR}/rc.d/rcsysinit.d/S30checkfs
	ln -sf ../init.d/mountfs     ${EXTDIR}/rc.d/rcsysinit.d/S40mountfs
	ln -sf ../init.d/cleanfs     ${EXTDIR}/rc.d/rcsysinit.d/S50cleanfs
	ln -sf ../init.d/hotplug     ${EXTDIR}/rc.d/rcsysinit.d/S55hotplug
	ln -sf ../init.d/setclock    ${EXTDIR}/rc.d/rcsysinit.d/S60setclock
	ln -sf ../init.d/console     ${EXTDIR}/rc.d/rcsysinit.d/S70console
	ln -sf ../init.d/localnet    ${EXTDIR}/rc.d/rcsysinit.d/S80localnet
	install -m 644 lfs/sysconfig/console                         ${EXTDIR}/sysconfig/
	install -m 644 lfs/sysconfig/createfiles                     ${EXTDIR}/sysconfig/
	install -m 644 lfs/sysconfig/modules                         ${EXTDIR}/sysconfig
	install -m 644 lfs/sysconfig/rc                              ${EXTDIR}/sysconfig/
	install -m 644 lfs/sysconfig/sysklogd                        ${EXTDIR}/sysconfig/
	install -m 754 lfs/sysconfig/network-devices/ifup            ${EXTDIR}/sysconfig/network-devices
	install -m 754 lfs/sysconfig/network-devices/ifdown          ${EXTDIR}/sysconfig/network-devices
	install -m 754 lfs/sysconfig/network-devices/services/static ${EXTDIR}/sysconfig/network-devices/services

.PHONY: all create-dirs create-service-dir install
