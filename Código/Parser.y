
/* Options to bison */
// File name of generated parser.
%output "Parser.c"
// Produces a 'parser.h'
%defines "Parser.h"
// Give proper error messages when a syntax error is found.
%define parse.error verbose
// Enable LAC (lookahead correction) to improve syntax error handling.
%define parse.lac full

// Enable the trace option so that debugging is possible.
%define parse.trace

%{
#include <stdio.h>
#include "Arvore.h"

int yylex(void);
void yyerror(char const *s);

extern int yylineno;
%}

%token IF ELSE INPUT INT OUTPUT RETURN VOID WHILE WRITE
%token PLUS MINUS TIMES OVER
%token LT LE GT GE EQ NEQ
%token ASSIGN SEMI COMMA LPAREN RPAREN LBRACK RBRACK LBRACE RBRACE
%token STRING NUM ID UNKNOWN
%left LT LE GT GE EQ NEQ
%left PLUS MINUS
%left TIMES OVER

%%

program: func_decl_list;

func_decl_list: func_decl_list func_decl | func_decl;

func_decl: func_header func_body;

func_header: ret_type ID LPAREN params RPAREN;

func_body: LBRACE opt_var_decl opt_stmt_list RBRACE;

opt_var_decl: /* VAZIO */ | var_decl_list;

opt_stmt_list: /* VAZIO */ | stmt_list;

ret_type: INT | VOID;

params: VOID | param_list;

param_list: param_list COMMA param | param;

param: INT ID | INT ID LBRACK RBRACK;

var_decl_list: var_decl_list var_decl | var_decl;

var_decl: INT ID SEMI | INT ID LBRACK NUM RBRACK SEMI;

stmt_list: stmt_list stmt | stmt;

stmt: assign_stmt | if_stmt | while_stmt | return_stmt | func_call SEMI;

assign_stmt: lval ASSIGN arith_expr SEMI;

lval: ID | ID LBRACK NUM RBRACK | ID LBRACK ID RBRACK;

if_stmt: IF LPAREN bool_expr RPAREN block | IF LPAREN bool_expr RPAREN block ELSE block;

block: LBRACE opt_stmt_list RBRACE;

while_stmt: WHILE LPAREN bool_expr RPAREN block;

return_stmt: RETURN SEMI
				{
					$$ = novoNodo( RETURN_NODE );
				}
				| RETURN arith_expr SEMI
				{
					$$ = novoNodo( RETURN_NODE );
					adicionaFilho( $$, 1, $2 );
				};

func_call: output_call
				{
					$$ = $1;
				}
				| write_call
				{
					$$ = $1;
				}
				| user_func_call
				{
					$$ = $1;
				};

input_call: INPUT LPAREN RPAREN
				{
					$$ = novoNodo( INPUT_NODE );
				};

output_call: OUTPUT LPAREN arith_expr RPAREN
				{
					$$ = novoNodo( OUTPUT_NODE );
					adicionaFilho( $$, 1, $3 );
				};

write_call: WRITE LPAREN STRING RPAREN
				{ 
					$$ = novoNodo( WRITE_NODE );
					adicionaFilho( $$, 1, novoNodo( STRING_NODE ) );
				};

user_func_call: ID LPAREN opt_arg_list RPAREN;

opt_arg_list: /* VAZIO */ | arg_list;

arg_list: arg_list COMMA arith_expr | arith_expr;

bool_expr: arith_expr bool_op arith_expr;

bool_op: LT
			{
				$$ = novoNodo( LT_NODE );
			}
			| LE
			{
				$$ = novoNodo( LE_NODE );
			}
			| GT
			{
				$$ = novoNodo( GT_NODE );
			}
			| GE
			{
				$$ = novoNodo( GE_NODE );
			}
			
			| EQ
			{
				$$ = novoNodo( EQ_NODE );
			}
			| NEQ { $$ = novoNodo( NEQ_NODE ); };

arith_expr: arith_expr PLUS arith_expr
				{
					$$ = novoNodo( PLUS_NODE );
					adicionaFilho( $$, 2, $1, $3 );
					//adicionaFilho( $$, $1, 0 );
					//adicionaFilho( $$, $3, 1 );
				}
 				| arith_expr MINUS arith_expr
				{
					$$ = novoNodo( MINUS_NODE );
					adicionaFilho( $$, 2, $1, $3 );
				}
 				| arith_expr TIMES arith_expr
				{
					$$ = novoNodo( TIMES_NODE );
					adicionaFilho( $$, 2, $1, $3 );
				}
				| arith_expr OVER arith_expr
				{
					$$ = novoNodo( OVER_NODE );
					adicionaFilho( $$, 2, $1, $3 );
				}
				| LPAREN arith_expr RPAREN
				{
					$$ = $2;
				}
				| lval
				{
					$$ = $1;
				}
				| input_call
				{
					$$ = $1;
				}
				
				| user_func_call
				{
					$$ = $1;
				}
				| NUM { $$ = novoNodo( NUMBER_NODE ); };
							
				

%%

void yyerror( char const *s )
{
	printf("PARSE ERROR (%d): %s\n", yylineno, s);
}

int main()
{
	int resultado = yyparse();
	if ( resultado == 0 )
		printf("PARSE SUCESSFUL!\n");

	return 0;
}
