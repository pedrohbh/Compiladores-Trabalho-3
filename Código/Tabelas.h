#ifndef TABELAS_H
#define TABELAS_H

typedef struct tabelaFuncao TabelaFuncao;

typedef struct linhaLista LinhaLista;

typedef struct tabelaSimbolos TabelaSimbolos;

// -------------------------------------Tabela Função----------------------------------------

int buscaTabelaFuncao( TabelaFuncao *tb, char *nome );

TabelaFuncao *getNodoFuncao( TabelaFuncao *tb, char *nome );

int getPrimeiraLinhaFuncao( TabelaFuncao *tb, char *nome );

void insereNovaLinhaFuncao( TabelaFuncao *nodo, int linha );

TabelaFuncao *insereTabelaFuncao( TabelaFuncao *tb, char *nome, int linha );

// -------------------------------------Tabela Simbolos----------------------------------------

TabelaFuncao *getNodoFuncao( TabelaFuncao *tb, char *nome )

int buscaTabelaSimbolos( TabelaSimbolos *tb, char *nome );

void insereNovaLinha( TabelaSimbolos *nodo, int linha );

int getPrimeiraLinhaSimbolo( TabelaSimbolos *tb, char *nome );

TabelaSimbolos *insereTabelaSimbolos( TabelaSimbolos *tb, char *nome, int linha );

TabelaSimbolos *getNodo( TabelaSimbolos *tb, char *nome );

char *copiaString( char *string );

void imprimeTabelaSimbolos( TabelaSimbolos *tb );

#endif
