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
#include <stdarg.h>
#include <regex.h>

#include "string.h"

void error (const char *fmt, ...) {
    va_list args;
    char msg[512];

    va_start(args, fmt);
    vsnprintf(msg, sizeof msg, fmt, args);
    va_end(args);

    fprintf(stderr, "Error: %s\n", msg);
    free(msg);

    exit(1);
}

int string_cat (char *str1, const char *str2) {
    int c, d;

    c = string_len(str1);
    d = 0;

    while ('\0' != str2[d])
    str1[c++] = str2[d++];

    str1[c] = '\0';
    return(d);
}

int string_comp (const char *str1, const char *str2) {
    int len;

    len = string_len(str1);
    if (len != string_len(str2))
    return(0);

    for (; len > 0; len--) {
        if (str1[len] != str2[len])
	return(0);
    }

    return(1);
}

char *string_cpy (const char *str1) {
	int c;
	char *dest;

	c = 0;
	dest = malloc((string_len(str1)+1) * sizeof(char));
    while (*str1) {
		dest[c] = *str1++;
		c++;
	}
	
	dest[c] = '\0';
    return(dest);
}

int string_len (const char *string) {
    int c;
    for (c=0; '\0' != string[c]; c++);
    return(c);
}

char *string_snip (const char *string, const int start, const int end) {
    int c, d;
    char *str;

    str = malloc((end-start+1) * sizeof(char));
    d = 0;

    for (c=start; c < end; c++)
    str[d++] = string[c];

    str[d] = '\0';
    return(str);
}

char *string_strip (const char *string, const char *strip) {
    char *str, *tmp;
    int len_stp, len_str;
    int c, s;

    len_stp = string_len(strip);
    len_str = string_len(string);
    str = malloc((len_str + 1) * sizeof(char));
    c = 0;

    for (s=0; '\0' != string[s]; s++)
    {
       tmp = string_snip(string, s, s + len_stp);

       if (string_comp(strip, tmp))
          s += len_stp;
       else
          str[c++] = string[s];

       free(tmp);
    }

    str[c] = '\0';
    return(str);
}
