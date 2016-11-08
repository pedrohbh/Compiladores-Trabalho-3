/* My implementation of Lab09 */

%option outfile="scanner.c"
%option noyywrap
%option nounput
%option noinput

%{
#include "parser.h"
#include "tables.h"

#define process_token(type) return type

void process_id();
void process_string();

extern LitTable *lt;
extern SymTable *aux;
%}

number      [0-9]+
identifier  [a-zA-Z]+
string      \"[^"]*\"

/* Multi-line comments are handled in the rules section.
   First we need to define a start condition. */
%x          ML_COMMENT

%%

"if"            { process_token(IF); }
"then"          { process_token(THEN); }
"else"          { process_token(ELSE); }
"end"           { process_token(END); }
"repeat"        { process_token(REPEAT); }
"until"         { process_token(UNTIL); }
"read"          { process_token(READ); }
"write"         { process_token(WRITE); }

"int"           { process_token(INT); }     // New
"puts"          { process_token(PUTS); }    // New

"+"             { process_token(PLUS); }
"-"             { process_token(MINUS); }
"*"             { process_token(TIMES); }
"/"             { process_token(OVER); }

"="             { process_token(EQ); }
"<"             { process_token(LT); }

"("             { process_token(LPAREN); }
")"             { process_token(RPAREN); }
";"             { process_token(SEMI); }

":="            { process_token(ASSIGN); }

{number}        { process_token(NUM); }
{identifier}    { process_id(); process_token(ID); }

{string}        { process_string(); process_token(STRING); }     // New

[ \t]+          /* eat up whitespace */
"\n"            yylineno++; /* eat up a single line */

"{"                 BEGIN(ML_COMMENT); /* multi-line comments */
<ML_COMMENT>[^}\n]* /* eat anything that’s not a ’}’ */
<ML_COMMENT>"\n"    yylineno++;
<ML_COMMENT>"}"     BEGIN(INITIAL);

                /* Be sure to keep this as the last rule */
.               { printf("SCANNING ERROR (%d): Unknown symbol %s\n", yylineno, yytext);
                  exit(1); }

%%

void process_id() {
    yylval = add_var(aux, yytext, yylineno);
}

void process_string() {
    yylval = add_literal(lt, yytext);
}
