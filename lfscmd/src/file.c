/*
 * Copyright (C) 2003 Timothy Bauscher <timothy@linuxfromscratch.org>
*/

#include <stdio.h>

#include "string.h"
#include "file.h"

FILE *write_file (const char *fname, const char *mode) {
    FILE *file = NULL;

    if ((file = fopen(fname, mode)) == NULL)
    error("Cannot access file: %s", fname);

    return(file);
}
