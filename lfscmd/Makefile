SHELL=/bin/sh
CC=gcc -s
CFLAGS=-I/usr/include/libxml2 -W -Wall -Os
LDFLAGS=-lxml2 -lm
PREFIX=/usr

OBJS= file.o \
      help.o \
      lfscmd.o \
      main.o \
      string.o

all: lfscmd

lfscmd: file.o help.o lfscmd.o main.o string.o
	$(CC) $(CFLAGS) $(LDFLAGS) -o lfscmd file.o help.o lfscmd.o main.o string.o

install: lfscmd
	if ( test ! -d $(PREFIX)/bin ); then mkdir -p $(PREFIX)/bin; fi
	if ( test ! -d $(PREFIX)/share/man/man1 ); then mkdir -p $(PREFIX)/share/man/man1; fi
	cp -f lfscmd $(PREFIX)/bin/lfscmd
	cp -f doc/lfscmd.1 $(PREFIX)/share/man/man1/lfscmd.1
	chmod a+x $(PREFIX)/bin/lfscmd
	chmod a+r $(PREFIX)/share/man/man1/lfscmd.1

clean: cleanup
cleanup:
	rm -f *.o lfscmd

uninstall: remove
remove:
	rm -f $(PREFIX)/bin/lfscmd
	rm -f $(PREFIX)/share/man/man1/lfscmd.1

file.o: src/file.c
	$(CC) $(CFLAGS) -c src/file.c
help.o: src/help.c
	$(CC) $(CFLAGS) -c src/help.c
lfscmd.o: src/lfscmd.c
	$(CC) $(CFLAGS) -c src/lfscmd.c
main.o: src/main.o
	$(CC) $(CFLAGS) -c src/main.c
string.o: src/string.c
	$(CC) $(CFLAGS) -c src/string.c
