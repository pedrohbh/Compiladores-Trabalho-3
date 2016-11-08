
/* Options to bison */
// File name of generated parser.
%output "parser.c"
// Produces a 'parser.h'
%defines "parser.h"
// Give proper error messages when a syntax error is found.
%define parse.error verbose
// Enable LAC (lookahead correction) to improve syntax error handling.
%define parse.lac full
// Enable the trace option so that debugging is possible.
%define parse.trace

%{
#include <stdio.h>
#include "bt.h"

int yylex(void);
void yyerror(char const *s);

BT *tree;
%}

%define api.value.type {BT*} // Type of variable yylval;

%token NUMBER
%left '+' '-'
%left '*' '/'

%%

line:
  expr '\n'     { tree = $1; }
;

expr:
  NUMBER        { $$ = $1; }
| expr '+' expr { $$ = new_node(PLUS_NODE, $1, $3); }
| expr '-' expr { $$ = new_node(MINUS_NODE, $1, $3); }
| expr '*' expr { $$ = new_node(TIMES_NODE, $1, $3); }
| expr '/' expr { $$ = new_node(OVER_NODE, $1, $3); }
;

%%

int main() {
    yydebug = 0; // Toggle this variable to enter debug mode.

    if (yyparse() == 0) {
        //printf("AST of given expression:\n");
        //print_tree(tree);
        print_dot(tree);
        free_tree(tree);
    }

    return 0;
}
