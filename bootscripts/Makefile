EXTDIR=/etc

install:
	install -d -m 755 ${EXTDIR}/rc.d/rc{0,1,2,3,4,5,6,sysinit}.d
	install -d -m 755 ${EXTDIR}/rc.d/init.d
	install -m 754 rc.d/init.d/checkfs      ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/cleanfs      ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/functions    ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/halt         ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/loadkeys     ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/localnet     ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/mountfs      ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/mountproc    ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/network      ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/rc           ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/reboot       ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/rc           ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/sendsignals  ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/setclock     ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/swap         ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/sysklogd     ${EXTDIR}/rc.d/init.d/
	install -m 754 rc.d/init.d/template     ${EXTDIR}/rc.d/init.d/
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
	ln -s ../init.d/halt        ${EXTDIR}/rc.d/rc6.d/K99halt
	ln -s ../init.d/swap        ${EXTDIR}/rc.d/rcsysinit.d/S10swap
	ln -s ../init.d/mountproc   ${EXTDIR}/rc.d/rcsysinit.d/S20mountproc
	ln -s ../init.d/checkfs     ${EXTDIR}/rc.d/rcsysinit.d/S30cehckfs
	ln -s ../init.d/mountfs     ${EXTDIR}/rc.d/rcsysinit.d/S40mountfs
	ln -s ../init.d/cleanfs     ${EXTDIR}/rc.d/rcsysinit.d/S50cleanfs
	ln -s ../init.d/setclock    ${EXTDIR}/rc.d/rcsysinit.d/S60setclock
	ln -s ../init.d/loadkeys    ${EXTDIR}/rc.d/rcsysinit.d/S70loadkeys
	ln -s ../init.d/localnet    ${EXTDIR}/rc.d/rcsysinit.d/S80localnet
	install -d -m 755 ${EXTDIR}/sysconfig/network-devices/services
	install -m 644 sysconfig/rc                              ${EXTDIR}/sysconfig/
	install -m 754 sysconfig/network-devices/ifup            ${EXTDIR}/sysconfig/network-devices
	install -m 754 sysconfig/network-devices/ifdown          ${EXTDIR}/sysconfig/network-devices
	install -m 754 sysconfig/network-devices/services/static ${EXTDIR}/sysconfig/network-devices/services

.PHONY: install
