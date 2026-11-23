
%option noyywrap yylineno

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"

extern int tokens_only;

int is_valid_roman(const char *str)
{
    int i = 0;
    int count;

    count = 0;
    while (str[i] == 'M')
    {
        i++;
        count++;
    }
    if (count > 3) return 0;

    if (strncmp(str + i, "CM", 2) == 0 ||
        strncmp(str + i, "CD", 2) == 0)
        i += 2;
    else
    {
        if (str[i] == 'D') i++;

        count = 0;
        while (str[i] == 'C')
        {
            i++;
            count++;
        }
        if (count > 3) return 0;
    }

    if (strncmp(str + i, "XC", 2) == 0 ||
        strncmp(str + i, "XL", 2) == 0)
        i += 2;
    else
    {
        if (str[i] == 'L') i++;

        count = 0;
        while (str[i] == 'X')
        {
            i++;
            count++;
        }
        if (count > 3) return 0;
    }

    if (strncmp(str + i, "IX", 2) == 0 ||
        strncmp(str + i, "IV", 2) == 0)
        i += 2;
    else
    {
        if (str[i] == 'V') i++;

        count = 0;
        while (str[i] == 'I')
        {
            i++;
            count++;
        }
        if (count > 3) return 0;
    }

    return str[i] == '\0';
}

void show_token(const char *type, const char *value)
{
    if (tokens_only)
    {
        printf("Line %d: %-10s %s\n",
               yylineno, type, value);
    }
}

char *copy_string(const char *str)
{
    char *copy = malloc(strlen(str) + 1);

    if (copy == NULL)
    {
        fprintf(stderr, "Memory allocation failed\n");
        exit(1);
    }

    strcpy(copy, str);
    return copy;
}
%}

ID          [a-z_][a-zA-Z0-9_]*
ROMAN       [IVXLCDM]+

%%

[ \t\r]+    { }
\n          { }

"print"     {
                show_token("PRINT", yytext);
                return PRINT;
            }

{ROMAN}     {
                if (is_valid_roman(yytext))
                {
                    yylval.str = copy_string(yytext);
                    show_token("ROMAN", yytext);
                    return ROMAN;
                }
                else
                {
                    fprintf(stderr,
                        "Lexical Error: Invalid Roman numeral '%s' at line %d\n",
                        yytext, yylineno);
                    exit(1);
                }
            }

{ID}        {
                yylval.str = copy_string(yytext);
                show_token("ID", yytext);
                return ID;
            }

"+"         { show_token("PLUS", yytext); return PLUS; }
"-"         { show_token("MINUS", yytext); return MINUS; }
"*"         { show_token("MULTIPLY", yytext); return MULTIPLY; }
"("         { show_token("LPAREN", yytext); return LPAREN; }
")"         { show_token("RPAREN", yytext); return RPAREN; }
"="         { show_token("ASSIGN", yytext); return ASSIGN; }
";"         { show_token("SEMICOLON", yytext); return SEMICOLON; }

.           {
                fprintf(stderr,
                    "Lexical Error: Unexpected character '%s' at line %d\n",
                    yytext, yylineno);
                exit(1);
            }

%%
