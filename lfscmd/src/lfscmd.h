#ifndef LFSCMD_H
#define LFSCMD_H

#include <libxml/tree.h>

struct LFSCMD {
    int exe, execute, file, title, strip_amp;
    //int status;
    char *query;//, *xmlfile;
    //char *cmd, *fname, *sect;
};

extern struct LFSCMD options;

extern int lfscmd (int argc, char **argv);
extern int lfscmd_parsexml (char* sect, char* fname, xmlDocPtr doc, xmlNodePtr node);
extern int lfscmd_parse_screen (FILE* output, xmlDocPtr doc, xmlNodePtr node);

#endif
