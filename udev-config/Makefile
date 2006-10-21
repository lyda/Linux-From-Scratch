# Makefile to install udev rules and documentation

PREFIX = /usr
RULES_DIR = /etc/udev/rules.d
INSTALL = install
INSTALL_DATA = $(INSTALL) -m644
RULES_FILES = \
	25-lfs.rules \
	26-modprobe.rules \
	27-firmware.rules \
	81-cdrom.rules
DOC_FILES = $(RULES_FILES:.rules=.txt)

EXTRA_DOC_FILES = \
	05-udev-early.txt \
	60-persistent-input.txt \
	60-persistent-storage.txt \
	95-udev-late.txt

# Figure out where to install the docs
UDEVINFO = udevinfo
UDEV_VERSION = $(shell $(UDEVINFO) -V 2>/dev/null | awk '{print $$NF}')
DOC_DIR = $(PREFIX)/share/doc/udev-$(UDEV_VERSION)

all:

install: install-rules

install-rules:
	$(INSTALL) -d $(DESTDIR)$(RULES_DIR)
	for rule in $(RULES_FILES); do \
		$(INSTALL_DATA) $$rule $(DESTDIR)$(RULES_DIR) || exit 1; \
	done;

install-doc:
	@if [ -z "$(UDEV_VERSION)" ]; then \
		echo "Error: Can't get udev version from udevinfo" >&2; \
		exit 1; \
	fi
	$(INSTALL) -d $(DESTDIR)$(DOC_DIR)
	for doc in $(DOC_FILES); do \
		$(INSTALL_DATA) doc/$$doc $(DESTDIR)$(DOC_DIR) || exit 1; \
	done

install-extra-doc:
	@if [ -z "$(UDEV_VERSION)" ]; then \
		echo "Error: Can't get udev version from udevinfo" >&2; \
		exit 1; \
	fi
	$(INSTALL) -d $(DESTDIR)$(DOC_DIR)
	for doc in $(EXTRA_DOC_FILES); do \
		$(INSTALL_DATA) doc/$$doc $(DESTDIR)$(DOC_DIR) || exit 1; \
	done
