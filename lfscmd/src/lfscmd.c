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

struct LFSCMD options;

int lfscmd (int argc, char **argv)
{
    xmlDocPtr doc;
    xmlNodePtr node;
    int c;
    char* xmlfile;

    /* Set defaults */
    options.exe       = 0;
    options.execute   = 0;
    options.file      = 0;
    options.title     = 0;
    options.strip_amp = 0;
    options.query   = NULL;
    //options.xmlfile = NULL;

    while ((c = getopt (argc, argv, "fxteq:a")) != -1)
        switch (c)
        {
        case 'f':
            options.file = 1;
            break;
        case 'x':
            options.exe = 1;
            break;
        case 't':
            options.title = 1;
            break;
        case 'e':
            options.execute = 1;
            break;
        case 'q':
            options.query = optarg;
            break;
        case 'a':
            options.strip_amp = 1;
            break;
        case '?':
        default:
            help(argv[0]);
        }

    /* Get xml file path */
    xmlfile = argv[optind];

    /* Validate arguments */
    if (NULL == xmlfile
        && NULL == (xmlfile=locate_book("LFSCMD_BOOK")))
        help(argv[0]);

    /* Setup the xml parser */
    xmlSubstituteEntitiesDefault(1);
    doc = xmlParseFile(xmlfile);
    node = xmlDocGetRootElement(doc);

    /* Check that the document is well-formed */
    if (NULL == doc) error("Document not well-formed");
    /* Check for an empty root element */
    if (NULL == node) error("Empty root element");

    return(lfscmd_parsexml("unknown", "unknown", doc, node->children));
}

int lfscmd_parsexml (char* sect, char* fname, xmlDocPtr doc, xmlNodePtr node)
{
    regex_t reg;
    FILE *output = stdout;
    int title_shown = 0;

    /* Compile regex query */
    if (NULL != options.query)
    {
        if (regcomp(&reg, options.query, REG_NOSUB))
            error("Regex is ill-formed: %s", options.query);
    }

    while (NULL != node)
    {
        /* Record page title */
        if (string_comp("title", node->name))
        {
            sect = xmlNodeListGetString(doc, node->children, 1);
            title_shown = 0;
        }
        /* Determine filename by section id */
        else if (string_comp("part", node->name)
                 || (string_len(node->name) >= 4
                     && string_comp("sect", string_snip(node->name, 0, 4))))
        {
            if (NULL != xmlGetProp(node, "id"))
                fname = xmlGetProp(node, "id");

        }
        /* Display screen commands */
        else if (string_comp("screen", node->name)
                 && string_comp("userinput", node->children->name))
        {
            /* Match title or section with query */
            if (NULL != options.query)
            {
                if (!regexec(&reg, sect, 0, NULL, 0)
                    || !regexec(&reg, fname, 0, NULL, 0))
                {
                    /* Append output to file */
                    if (options.file)
                        output=write_file(fname, "a");

                    /* Output new page title */
                    if (options.title && !title_shown)
                    {
                        fprintf(output, "\n\n### %s: %s ###\n", fname, sect);
                        title_shown = 1;
                    }
                    lfscmd_parse_screen(output, doc, node->children);
                }
            }
            else
            {
                /* Append output to file */
                if (options.file)
                    output=write_file(fname, "a");

                /* Output new page title */
                if (options.title && !title_shown)
                {
                    fprintf(output, "\n\n### %s: %s ###\n", fname, sect);
                    title_shown = 1;
                }
                lfscmd_parse_screen(output, doc, node->children);
            }
            /* Close file */
            if (options.file)
            {
                fclose(output);

                /* Make file executable */
                if (options.exe)
                    chmod(fname, 00755);
            }
        }

        /* Recursively traverse the tree */
        if (NULL != node->children)
            lfscmd_parsexml(sect, fname, doc, node->children);

        node = node->next;
    }
    return(0);
}

static void output_cmd(FILE* output, char* cmd)
{
    if (options.execute)
        system(options.strip_amp ? string_strip(cmd, " &&") : cmd);
    else
        fprintf(output, "%s", options.strip_amp ? string_strip(cmd, " &&") : cmd);
}

int lfscmd_parse_command(FILE* output, xmlDocPtr doc, xmlNodePtr node)
{
    char* cmd;

    while (NULL != node)
    {
        /* Output content outside of "command" */
        if (string_comp("text", node->name))
        {
            if (NULL != (cmd = node->content))
            {
                output_cmd(output, cmd);
            }
        }

        if (NULL != (cmd = xmlNodeListGetString(doc, node->children, 1)))
        {
            output_cmd(output, cmd);
        }

        node = node->next;
    }
    return 1;
}

int lfscmd_parse_userinput(FILE* output, xmlDocPtr doc, xmlNodePtr node)
{
    char* cmd;

    /* Output userinput commands and content */
    while (NULL != node)
    {
        /* Properly deal with BLFS commands of the form <screen><userinput><command> */
        if (string_comp("command", node->name))
        {
            lfscmd_parse_command(output, doc, node->children);
        }
        else if (NULL != (cmd = xmlNodeListGetString(doc, node, 1)))
        {
            output_cmd(output, cmd);
        }

        node = node->next;
    }

    return 1;
}

int lfscmd_parse_screen (FILE* output, xmlDocPtr doc, xmlNodePtr node)
{
    char* cmd;

    /* Output screen commands and content */
    while (NULL != node)
    {
        /* Output content outside of "userinput" */
        if (string_comp("text", node->name))
        {
            if (NULL != (cmd = node->content))
            {
                output_cmd(output, cmd);
            }
        }

        /* Output commands */
        else if (string_comp("userinput", node->name))
        {
            lfscmd_parse_userinput(output, doc, node->children);
        }

        node = node->next;
    }

    /* Output trailing space */
    fprintf(output, "\n");

    return(1);
}

