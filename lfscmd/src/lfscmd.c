/*
 * Copyright (C) 2003 Timothy Bauscher <timothy@linuxfromscratch.org>
*/

#include <stdio.h>
#include <regex.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>

#include "help.h"
#include "env.h"
#include "string.h"
#include "file.h"
#include "lfscmd.h"

int lfscmd (int argc, char **argv) {
    xmlDocPtr doc;
    xmlNodePtr node;
    int c;

    /* Set defaults */
    lfs.exe     = 0;
    lfs.execute = 0;
    lfs.file    = 0;
    lfs.title   = 0;
    lfs.status  = 0;
    lfs.query   = NULL;
    lfs.xmlfile = NULL;

    while ((c = getopt (argc, argv, "fxteq:")) != -1)
    switch(c)
    {
       case 'f':
          lfs.file = 1;
          break;
       case 'x':
          lfs.exe = 1;
          break;
       case 't':
          lfs.title = 1;
          break;
       case 'e':
          lfs.execute = 1;
          break;
       case 'q':
          lfs.query = optarg;
          break;
       case '?':
       default:
          help(argv[0]);
    }

    /* Get xml file path */
    lfs.xmlfile = argv[optind];

    /* Validate arguments */
    if (NULL == lfs.xmlfile
     && NULL == (lfs.xmlfile=locate_book("LFSCMD_BOOK")))
     help(argv[0]);

    /* Setup the xml parser */
    xmlSubstituteEntitiesDefault(1);
    doc = xmlParseFile(lfs.xmlfile);
    node = xmlDocGetRootElement(doc);

    /* Check that the document is well-formed */
    if (NULL == doc) error("Document not well-formed");
    /* Check for an empty root element */
    if (NULL == node) error("Empty root element");

    return(lfscmd_parsexml(doc, node->children));
}

int lfscmd_parsexml (xmlDocPtr doc, xmlNodePtr node) {
    regex_t reg;

    /* Compile regex query */
    if (NULL != lfs.query) {
       if (regcomp(&reg, lfs.query, REG_NOSUB))
       error("Regex is ill-formed: %s", lfs.query);
    }

    while (NULL != node)
    {
        /* Record page title */
        if (string_comp("title", node->name)) {
           lfs.sect = xmlNodeListGetString(doc, node->children, 1);
           lfs.status = 1;
        }
        /* Determine filename by section id */
        else if (string_comp("part", node->name)
             || (string_len(node->name) >= 4
             && string_comp("sect", string_snip(node->name, 0, 4)))) {

             if (NULL != xmlGetProp(node, "id"))
             lfs.fname = xmlGetProp(node, "id");
        }
        /* Display screen commands */
        else if (string_comp("screen", node->name)
              && string_comp("userinput", node->children->name)) {

             /* Match title or section with query */
             if (NULL != lfs.query) {
                if (!regexec(&reg, lfs.sect, 0, NULL, 0)
                 || !regexec(&reg, lfs.fname, 0, NULL, 0))
                 lfscmd_parse_screen(doc, node->children);
             }
             else lfscmd_parse_screen(doc, node->children);
        }

        /* Recursively traverse the tree */
        if (NULL != node->children)
        lfscmd_parsexml(doc, node->children);

        node = node->next;
    }
    return(0);
}

int lfscmd_parse_screen (xmlDocPtr doc, xmlNodePtr node) {
    FILE *output = stdout;

    if (NULL == lfs.fname) lfs.fname = "unknown";
    if (NULL == lfs.sect)  lfs.sect  = "unknown";

    /* Append output to file */
    if (1 == lfs.file) output=write_file(lfs.fname, "a");
    
    /* Output new page title */
    if (1 == lfs.status && 1 == lfs.title) {
       fprintf(output, "\n\n### %s: %s ###\n", lfs.fname, lfs.sect);
       lfs.status = 0;
    }

    /* Output screen commands and content */
    while (NULL != node)
    {
        /* Output content outside of "userinput" */
        if (string_comp("text", node->name)) {
            if (NULL != (lfs.cmd = node->content)) {
               if (1 == lfs.execute) system(lfs.cmd);
               else fprintf(output, "%s", lfs.cmd);
            }
        }

        /* Output commands */
        else if (string_comp("userinput", node->name))
        {
            /* Strip double ampersands */
            if (NULL != (lfs.cmd = xmlNodeListGetString(doc, node->children, 1))) {
            
               if (1 == lfs.execute)
                 system(string_strip(lfs.cmd, "&&"));
               else
                 fprintf(output, "%s", string_strip(lfs.cmd, "&&"));
            }

            /* Properly deal with BLFS commands of the form <screen><userinput><command> */
            if (string_comp("command", node->children->name))
            {
                xmlNodePtr command_node = node->children;

                while (NULL != command_node)
                {
                    if (NULL != (lfs.cmd = xmlNodeListGetString(doc, command_node->children, 1)))
                    {
                        if (1 == lfs.execute)
                        {
                            system(string_strip(lfs.cmd, "&&"));
                        }
                        else
                        {
                            fprintf(output, "%s", string_strip(lfs.cmd, "&&"));
                        }
                    }
                    command_node = command_node->next;
                }

            }
        }

        node = node->next;
    }

    /* Output trailing space */
    fprintf(output, "\n");

    /* Close file */
    if (1 == lfs.file) {
       fclose(output);

       /* Make file executable */
       if (1 == lfs.exe) chmod(lfs.fname, 00755);
    }
    return(1);
}
