%option outfile="scanner.c"
%option noyywrap
%option nounput
%option noinput

%{
#include "bt.h"
#include "parser.h"
%}

%%

[0-9]+  { yylval = new_leaf(NUMBER_NODE, atoi(yytext)); return NUMBER; }
" "     ; // skip blanks
.|\n    { return yytext[0]; }
