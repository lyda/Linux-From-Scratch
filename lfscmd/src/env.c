/*
 * Copyright (C) 2003 Timothy Bauscher <timothy@linuxfromscratch.org>
*/

#include <stdio.h>
#include <stdlib.h>

#include "string.h"
#include "env.h"

char *locate_book (const char *varname) {
	char *envptr, *env;
	
	envptr=getenv(varname);
	if (NULL == envptr) return(NULL);
	else {
		/* Out of memory */
		if (NULL==(env = (char *) malloc((string_len(envptr)+1) * sizeof(char)) ))
		exit(-1);

		env = string_cpy(envptr);
	}

	return(env);
}
