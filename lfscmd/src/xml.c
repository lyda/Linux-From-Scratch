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
#include <string.h>
#include <stdlib.h>
#include <sys/stat.h>
#include "xml.h"
#include "file.h"
#include "stringfun.h"

int parsedoc (char *xmlfile) {
	int retval=1;
	xmlDocPtr doc;
	xmlNodePtr node;

	xmlSubstituteEntitiesDefault(1);
	doc=xmlParseFile(xmlfile);
	node=xmlDocGetRootElement(doc);

	/* Check document validity */
	if (NULL == doc) {
		fprintf(stderr, "Error: Document is not well-formed.\n");
		retval=-1;
	}
	if (NULL == node) {
		fprintf(stderr, "Error: Empty root element.\n");
		retval=-1;
	}
	if (1 == retval)
		retval=lfscmd(doc, node);

	xmlFreeDoc(doc);
	return(retval);
}

int lfscmd (xmlDocPtr doc, xmlNodePtr node) {
	if ( ! parsexml(doc, node->children))
		return(-1);

	return(1);
}

int parsexml (xmlDocPtr doc, xmlNodePtr node) {
	while (NULL != node) {
		if (0 == strcmp("title", node->name)) {
			lfs.title_status = 1;
			if (NULL == (lfs.title = xmlNodeListGetString(doc, node->children, 1)) ) {
				fprintf(stderr, "Error: <%s> tag in <%s> is empty.\n", node->name, node->parent->name);
			}
		}
		else if (0 == strcmp("part", node->name) || NULL != strstr(node->name, "sect")) {
			if (NULL != (xmlGetProp(node, "id")) )
				lfs.filename = xmlGetProp(node, "id");
		}
		else if (0 == strcmp("screen", node->name) ) {
			if (0 == strcmp("userinput", node->children->name) ) {
				if (! parse_screen(doc, node->children))
					return(0);
			}
		}

		/* Traverse the tree recursively */
		if (NULL != node->children)
			parsexml(doc, node->children);

		node = node->next;
	}
	return(1);
}

int parse_screen (xmlDocPtr doc, xmlNodePtr node) {
	FILE *output=stdout;

	if (NULL == lfs.filename)
		lfs.filename="UNKNOWN";
	if (NULL == lfs.title)
		lfs.title="UNKNOWN";
	if (1 == lfsopts.files)
		output=openFile(lfs.filename);

	print_title(output);

	while (NULL != node) {
		if (0 == strcmp("text", node->name) ) {
			if (NULL != (lfs.text = node->content) )
				fprintf(output, "%s", lfs.text);
		}
		else if (0 == strcmp("userinput", node->name) ) {
			if (NULL != (lfs.userinput = xmlNodeListGetString(doc, node->children, 1)) )
				fprintf(output, "%s", lfs.userinput);
		}

		node = node->next;
	}

	fprintf(output, "\n\n");
	if (1 == lfsopts.files) {
		fclose(output);
		if (1 == lfsopts.executable)
			chmod(lfs.filename, 00755);
	}
	return(1);
}
