
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "parser.tab.h"

extern FILE *yyin;
extern int yylex(void);
int yyparse(void);


/* Token display mode */
int tokens_only = 0;

int main(int argc, char *argv[])
{
    FILE *input_file;

    /* Check command line arguments */
    if (argc < 2 || argc > 3)
    {
        printf("Roman Numeral Calculator Compiler\n\n");
        printf("Usage:\n");
        printf("compiler.exe [-tokens] input.txt\n");
        return 1;
    }

    /* Token mode */
    if (argc == 3)
    {
        if (strcmp(argv[1], "-tokens") == 0)
        {
            tokens_only = 1;
        }
        else
        {
            printf("Error: Invalid option!\n");
            return 1;
        }
    }

    /* Open input file */
    input_file = fopen(argv[argc - 1], "r");

    if (input_file == NULL)
    {
        printf("Error: Cannot open input file!\n");
        return 1;
    }

    yyin = input_file;

    /* Run Lexer or Parser */
    if (tokens_only)
    {
        printf("Token List:\n\n");

        while (yylex() != 0)
        {
            /* Tokens are printed by lexer.l */
        }
    }
    else
    {
        printf("Roman Numeral Calculator Compiler\n\n");

        if (yyparse() == 0)
        {
            printf("Program accepted successfully!\n");
        }
        else
        {
            printf("Compilation failed!\n");
            fclose(input_file);
            return 1;
        }
    }

    fclose(input_file);

    return 0;
}
