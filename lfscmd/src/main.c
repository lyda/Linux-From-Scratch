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
#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include "main.h"
#include "xml.h"
#include "file.h"

int main (int argc, char *argv[]) {
	int option=0;
	char *xmlfile;

	opterr=0;
	while ((option=getopt(argc, argv, "xft-")) != -1) {
		switch (option) {
			case 'x':
				lfsopts.executable=1;
				break;
			case 'f':
				lfsopts.files=1;
				break;
			case 't':
				lfsopts.titles=1;
				break;
			case '-':
				usage(argv[0]);
				return(-1);
				break;
			case '?':
				usage(argv[0]);
				fprintf(stderr, "\nUnknown option: %c\n", optopt);
				return(-1);
		}
	}

	if ((argc - optind) < 1) {
		usage(argv[0]);
		return(-1);
	}

	xmlfile=argv[optind++];
	if (readable(xmlfile))
		return( parsedoc(xmlfile) );

	return(-1);
}

void usage (char *progname) {
	fprintf(stderr, "Usage: %s [-tfx] INDEX.XML\n\n-t  Print titles (as comments).\n-f  Write commands to their own file.\n-x  Give executable permission to the resulting files.\n", progname);
}
