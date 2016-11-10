#ifndef TABELAS_H
#define TABELAS_H

typedef struct linhaLista LinhaLista;

typedef struct tabelaFuncao TabelaFuncao;

typedef struct tabelaSimbolos TabelaSimbolos;

//-------------------------------------Literais-----------------------------------------------
typedef struct lit_table LitTable;

LitTable* create_lit_table();

int add_literal(LitTable* lt, char* s);


char* get_literal(LitTable* lt, int i);

void print_lit_table(LitTable* lt);

void free_lit_table(LitTable* lt);


//--------------------------------------Funcao------------------------------------------------

int buscaTabelaFuncao( TabelaFuncao *tb, char *nome );

TabelaFuncao *getNodoFuncao( TabelaFuncao *tb, char *nome );

int getPrimeiraLinhaFuncao( TabelaFuncao *tb, char *nome );

void insereNovaLinhaFuncao( TabelaFuncao *nodo, int linha );

TabelaFuncao *insereTabelaFuncao( TabelaFuncao *tb, char *nome, int linha );

//--------------------------------------Simbolos---------------------------------------------
int buscaTabelaSimbolos( TabelaSimbolos *tb, char *nome );

void insereNovaLinha( TabelaSimbolos *nodo, int linha );

int getPrimeiraLinhaSimbolo( TabelaSimbolos *tb, char *nome );

TabelaSimbolos *insereTabelaSimbolos( TabelaSimbolos *tb, char *nome, int linha );

TabelaSimbolos *getNodo( TabelaSimbolos *tb, char *nome );

char *copiaString( char *string );

void imprimeTabelaSimbolos( TabelaSimbolos *tb );


//-----------------------------------------Nova Simbolos----------------------------------------------
// Opaque structure.
// For simplicity, the table is implemented as a sequential list.
// This table only stores the variable name and the declaration line.
typedef struct sym_table SymTable;

// Creates an empty symbol table.
SymTable* create_sym_table();

// Adds a fresh var to the table.
// No check is made by this function, so make sure to call 'lookup_var' first.
// Returns the index where the variable was inserted.
int add_var(SymTable* st, char* s, int line);

// Returns the index where the given variable is stored or -1 otherwise.
int lookup_var(SymTable* st, char* s);

// Returns the variable name stored at the given index.
// No check is made by this function, so make sure that the index is valid first.
char* get_name(SymTable* st, int i);

// Returns the declaration line of the variable stored at the given index.
// No check is made by this function, so make sure that the index is valid first.
int get_line(SymTable* st, int i);

// Prints the given table to stdout.
void print_sym_table(SymTable* st);

// Clear the allocated structure.
void free_sym_table(SymTable* st);


#endif

