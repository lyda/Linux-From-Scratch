bin_PROGRAMS = lfscmd
lfscmd_SOURCES = src/main.c src/file.c src/stringfun.c src/xml.c
INCLUDES = -I/usr/include/libxml2
LDADD = -lxml2 -lm -lz $(LIBXML2_LIBS)
AM_CFLAGS = -s -Os -W -Wall $(LIBXML2_CFLAGS)
man_MANS = doc/lfscmd.1
EXTRA_DIST = $(man_MANS) FAQ BUGS src/main.h src/file.h src/stringfun.h src/xml.h
