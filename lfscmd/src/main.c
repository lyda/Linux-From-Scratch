/*
 * Copyright (C) 2003 Timothy Bauscher <timothy@linuxfromscratch.org>
*/

#include "lfscmd.h"

/*
	In the future, symlinks will determine run mode.
	The default mode shall be docbook xml.
*/

int main (int argc, char **argv) {
    return(lfscmd(argc, argv));
}
