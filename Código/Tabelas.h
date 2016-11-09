#ifndef TABELAS_H
#define TABELAS_H

typedef struct linhaLista LinhaLista;

typedef struct tabelaSimbolos TabelaSimbolos;

int buscaTabelaSimbolos( TabelaSimbolos *tb, char *nome );

void insereNovaLinha( TabelaSimbolos *nodo, int linha );

TabelaSimbolos *insereTabelaSimbolos( TabelaSimbolos *tb, char *nome, int linha );

char *copiaString( char *string );

#endif
