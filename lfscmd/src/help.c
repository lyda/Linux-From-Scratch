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
