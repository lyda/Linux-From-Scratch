#ifndef STRING_H
#define STRING_H

extern void error (const char *fmt, ...);
extern int string_cat (char *str1, const char *str2);
extern int string_comp (const char *str1, const char *str2);
extern char *string_cpy (const char *str1);
extern int string_len (const char *string);
extern char *string_snip (const char *string, const int start, const int end);
extern char *string_strip (const char *string, const char *strip);

#endif
