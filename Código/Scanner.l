%option outfile="Scanner.c"
%option noyywrap
%option nounput
%option noinput

%{
#include <stdio.h>
#include <stdlib.h>
#include "Parser.h"
#include "Arvore.h"

extern char *tokenSimbolo;
extern char *tokenLiteral;

//void process_id();
%}

digito [0-9]
numero {digito}+
letra [a-zA-Z]
identificador {letra}+({digito}*|{letra}*)
newline \n
whitespace [ \t]+
%x comment
%%

"/*" BEGIN(comment);

<comment>[^*\n]* { /* FAZ NADA */ }
<comment>"*"+[^*/\n]* { /* FAZ NADA */ }
<comment>\n { yylineno++; }
<comment>"*"+"/" BEGIN(INITIAL);

"if" { return IF; }
"else" { return ELSE; }
"input" { return INPUT; }
"int" { return INT; }
"output" { return OUTPUT; }
"return" { return RETURN; }
"void" { return VOID; }
"while" { return WHILE; }
"write" { return WRITE; }
"+" { return PLUS; }
"-" { return MINUS; }
"*" { return TIMES; }
"/" { return OVER; }
"<" { return LT; }
"<=" { return LE; }
">" { return GT; }
">=" { return GE; }
"==" { return EQ; }
"!=" { return NEQ; }
"=" { return ASSIGN; }
";" { return SEMI; }
"," { return COMMA; }
"(" { return LPAREN; }
")" { return RPAREN; }
"[" { return LBRACK; }
"]" { return RBRACK; }
"{" { return LBRACE; }
"}" { return RBRACE; }
"//"[^\n]* { /* FAZ NADA */ }
"\""[^"\""]*"\"" { return STRING; }
{numero} { return NUM; }
{identificador} { int len = strlen( yytext ) + 1; tokenSimbolo = (char *)malloc(sizeof(char) * len); strcpy(tokenSimbolo, yytext );/*printf("ID = %s\n", yytext); tokenSimbolo = yytext;*/  return ID; }
{newline} { yylineno++; }
{whitespace} { /* FAZ NADA */ }
. { printf("SCANNING ERROR (%d): Unknown symbol %s\n", yylineno, yytext ); exit( 1 ); }

%%

/*void process_id()
{

}*/
