/*
 * Copyright (C) 2002 Free Software Foundation, Inc.
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
 * Timothy Bauscher <timothy@linuxfromscratch.org>
*/

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include "file.h"
#include "xml.h"
#include "stringfun.h"

int readable (char *filename) {
	FILE *test;
	if ((test = fopen(filename, "r")) == NULL) {
		fprintf(stderr, "Cannot open %s for reading.\n", filename);
		return(0);
	}

	fclose(test);
	return(1);
}

FILE *openFile (char *filename) {
	FILE *output;
	if ((output = fopen(filename, "a")) == NULL) {
		fprintf(stderr, "ERROR: Cannot write to file: %s\n", filename);
		exit(1);
	}

	return(output);
}
