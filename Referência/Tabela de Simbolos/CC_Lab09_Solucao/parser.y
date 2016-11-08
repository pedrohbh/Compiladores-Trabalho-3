// My implementation of Lab09.

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
#include <stdlib.h>
#include "parser.h"
#include "tables.h"

int yylex(void);
void yyerror(char const *s);

void check_var(int i);
void new_var(int i);

extern int yylineno;

LitTable *lt;
SymTable *st;
SymTable *aux;
%}

%token IF THEN ELSE END REPEAT UNTIL READ WRITE
%token SEMI LPAREN RPAREN
%token ASSIGN
%token INT PUTS

%token NUM
%token ID
%token STRING

%left LT EQ
// Precedence of operators (* and / have higher precedence).
// All four operators are left associative.
%left PLUS MINUS
%left TIMES OVER

// Start symbol for the grammar.
%start program

%%

program:
  stmt_sequence
;

stmt_sequence:
  stmt_sequence stmt
| stmt
;

stmt:
  if_stmt
| repeat_stmt
| assign_stmt
| read_stmt
| write_stmt
| var_decl  // New
| puts_stmt // New
;

if_stmt:
  IF expr THEN stmt_sequence END
| IF expr THEN stmt_sequence ELSE stmt_sequence END
;

repeat_stmt:
  REPEAT stmt_sequence UNTIL expr
;

assign_stmt:
  ID ASSIGN expr SEMI   { check_var($1); }
;

read_stmt:
  READ ID SEMI  { check_var($2); }
;

write_stmt:
  WRITE expr SEMI
;

expr:
  expr LT expr
| expr EQ expr
| expr PLUS expr
| expr MINUS expr
| expr TIMES expr
| expr OVER expr
| LPAREN expr RPAREN
| NUM
| ID    { check_var($1); }
;

var_decl: // New
  INT ID SEMI { new_var($2); }
;

puts_stmt: // New
  PUTS STRING SEMI  { printf("PUTS: %s.\n", get_literal(lt, $2)); }
;

%%

void check_var(int i) {
    char* name = get_name(aux, i);
    int line = get_line(aux, i);
    int idx = lookup_var(st, name);
    if (idx == -1) {
        printf("SEMANTIC ERROR (%d): variable '%s' was not declared.\n", line, name);
        exit(1);
    }
}

void new_var(int i) {
    char* name = get_name(aux, i);
    int line = get_line(aux, i);
    int idx = lookup_var(st, name);

    if (idx != -1) {
        printf("SEMANTIC ERROR (%d): variable '%s' already declared at line %d.\n",
            line, name, get_line(st, idx));
        exit(1);
    }

    add_var(st, name, line);
}

// Error handling.
void yyerror (char const *s) {
    printf("PARSE ERROR (%d): %s\n", yylineno, s);
}

// Main.
int main() {
    yydebug = 0; // Toggle this variable to enter debug mode.

    // Initialization of tables before parsing.
    lt = create_lit_table();
    st = create_sym_table();
    aux = create_sym_table();

    yyparse();

    printf("\n\n");
    print_lit_table(lt); printf("\n\n");
    print_sym_table(st); printf("\n\n");

    free_lit_table(lt);
    free_sym_table(st);
    free_sym_table(aux);

    return 0;
}
