#ifndef XML_H
#define XML_H

#include <libxml/tree.h>

struct LFSCMD {
	char *title, *userinput, *text, *filename;
	int title_status;
} lfs;

struct LFSCMD_OPTIONS {
	int executable, files, titles;
} lfsopts;

extern int parsedoc (char *xmlfile);
extern int lfscmd (xmlDocPtr doc, xmlNodePtr node);
extern int parsexml (xmlDocPtr doc, xmlNodePtr node);
extern int parse_screen (xmlDocPtr doc, xmlNodePtr node);

#endif
