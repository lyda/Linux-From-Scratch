/*
 * Copyright (C) 2003 Timothy Bauscher <timothy@linuxfromscratch.org>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 *
*/

#include <stdio.h>
#include <stdlib.h>

#include "string.h"
#include "env.h"

char *locate_book (const char *varname) {
	char *envptr, *env;
	
	envptr=getenv(varname);
	if (NULL == envptr)
		return(NULL);
	else {
		/* Out of memory */
		if (NULL==(env = (char *) malloc((string_len(envptr)+1) * sizeof(char)) ))
		exit(-1);

		env = string_cpy(envptr);
	}

	return(env);
}
