
%{
#include <stdio.h>
#include <stdlib.h>
#include "roman.h"

int yylex(void);
void yyerror(const char *s);
extern int yylineno;
%}

/* Semantic Value Types */
%union {
    int num;
    char *str;
}

/* Tokens */
%token <str> ROMAN ID
%token PRINT
%token PLUS MINUS MULTIPLY
%token LPAREN RPAREN
%token ASSIGN SEMICOLON

/* Expression Data Types */
%type <num> expression term factor

/* Operator Precedence */
%left PLUS MINUS
%left MULTIPLY

%start program

%%

/* Main Program */
program:
      expression
      {
          char result[50];

          int_to_roman($1, result);

          printf("\nCalculation Result:\n");
          printf("Integer: %d\n", $1);
          printf("Roman: %s\n", result);
      }
    | PRINT expression SEMICOLON
      {
          char result[50];

          int_to_roman($2, result);

          printf("\nCalculation Result:\n");
          printf("Integer: %d\n", $2);
          printf("Roman: %s\n", result);
      }
    ;

/* Arithmetic Expressions */
expression:
      expression PLUS term
      {
          $$ = $1 + $3;
      }
    | expression MINUS term
      {
          $$ = $1 - $3;
      }
    | term
      {
          $$ = $1;
      }
    ;

term:
      term MULTIPLY factor
      {
          $$ = $1 * $3;
      }
    | factor
      {
          $$ = $1;
      }
    ;

factor:
      ROMAN
      {
          $$ = roman_to_int($1);
          free($1);
      }
    | LPAREN expression RPAREN
      {
          $$ = $2;
      }
    ;

%%

/* Syntax Error Handler */
void yyerror(const char *s)
{
    fprintf(stderr,
            "\nSyntax Error at line %d: %s\n",
            yylineno, s);
}
