/*
 * Copyright (C) 2003 Timothy Bauscher <timothy@linuxfromscratch.org>
*/

#include <stdio.h>
#include <stdlib.h>

#include "help.h"

void help (const char *prog)
{
fprintf(stderr, "Usage: %s [options] index.xml\n\
Options:\n\
  -e\n\
     Execute commands.\n\
  -f\n\
     Write commands to their own file.\n\
  -q query\n\
     Output pages matching regex query.\n\
  -t\n\
     Print titles (as comments).\n\
  -x\n\
     Make file output executable.\n", prog);

    exit(1);
}
