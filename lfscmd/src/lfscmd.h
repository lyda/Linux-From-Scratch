#ifndef LFSCMD_H
#define LFSCMD_H

#include <libxml/tree.h>

struct LFSCMD {
    int exe, execute, file, title;
    int status;
    char *query, *xmlfile;
    char *cmd, *fname, *sect;
} lfs;

extern int lfscmd (int argc, char **argv);
extern int lfscmd_parsexml (xmlDocPtr doc, xmlNodePtr node);
extern int lfscmd_parse_screen (xmlDocPtr doc, xmlNodePtr node);

#endif
