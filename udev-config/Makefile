# Makefile to install udev rules and documentation

PREFIX = /usr
RULES_DIR = /etc/udev/rules.d
INSTALL = install
INSTALL_DATA = $(INSTALL) -m644
RULES_FILES = \
	51-lfs.rules \
	61-cdrom.rules \
	81-firmware.rules
DOC_FILES = $(RULES_FILES:.rules=.txt)

EXTRA_DOC_FILES = \
	05-udev-early.txt \
	60-persistent-input.txt \
	60-persistent-storage.txt \
	80-drivers.txt \
	95-udev-late.txt

# Figure out where to install the docs
UDEV_VERSION = $(shell udevd --version)
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
