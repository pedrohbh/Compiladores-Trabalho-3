#ifndef TABELAS_H
#define TABELAS_H

typedef struct linhaLista LinhaLista;

typedef struct tabelaSimbolos TabelaSimbolos;

int buscaTabelaSimbolos( TabelaSimbolos *tb, char *nome );

void insereNovaLinha( TabelaSimbolos *nodo, int linha );

int getPrimeiraLinhaSimbolo( TabelaSimbolos *tb, char *nome );

TabelaSimbolos *insereTabelaSimbolos( TabelaSimbolos *tb, char *nome, int linha );

TabelaSimbolos *getNodo( TabelaSimbolos *tb, char *nome );

char *copiaString( char *string );

void imprimeTabelaSimbolos( TabelaSimbolos *tb );

#endif

