AC_INIT(src/main.c)
AM_INIT_AUTOMAKE(lfscmd,0.5)


dnl Add our extra little libxml2 switch to configure..

AC_ARG_WITH(libxml2,
[  --with-libxml2=PREFIX   Specify the location of libxml2 installation],
    LIBXML2_PREFIX=$withval
)


AC_PROG_CC(gcc)
AC_PROG_INSTALL


dnl Let's find libxml2 and get setup.

LIBXML2_REQUIRED_VERSION=2.4.1

AC_MSG_CHECKING(for libxml2 libraries >= $LIBXML2_REQUIRED_VERSION)

if test "$LIBXML2_PREFIX" != ""
then
    XML2_CONFIG=${LIBXML2_PREFIX}/bin/xml2-config
else
    XML2_CONFIG=xml2-config
fi

if $XML2_CONFIG --libs print > /dev/null 2>&1
then
    XML2_VERSION=`$XML2_CONFIG --version`

    if test `echo $XML2_VERSION | tr -d .` -ge `echo $LIBXML2_REQUIRED_VERSION | tr -d .`
    then
	LIBXML2_LIBS=`$XML2_CONFIG --libs`
	LIBXML2_CFLAGS=`$XML2_CONFIG --cflags`
	AC_MSG_RESULT($XML2_VERSION found)
    else
	AC_MSG_ERROR(Version $XML2_VERSION found.  You need at least libxml2 $LIBXML2_REQUIRED VERSION for this version of lfscmd.)
    fi
else
    AC_MSG_ERROR([Could not find libxml2 anywhere, download a copy from ftp://xmlsoft.org/.])
fi


AC_SUBST(LIBXML2_CFLAGS)
AC_SUBST(LIBXML2_LIBS)

AC_OUTPUT(Makefile)
