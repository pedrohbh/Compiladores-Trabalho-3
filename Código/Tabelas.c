#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "Tabelas.h"

#define SYMBOL_MAX_SIZE 128


struct linhaLista
{
	int linha;
	struct linhaLista *proximoPtr;
};

struct tabelaSimbolos
{
	char *nome;
	//int tamanho;
	LinhaLista *linhas;
	struct tabelaSimbolos *proximoPtr;
};


/*TabelaSimbolos *criaTabelaSimbolos()
{
	TabelaSimbolos novaTabela = (TabelaSimbolos *)malloc(sizeof(TabelaSimbolos));
*/	


int buscaTabelaSimbolos( TabelaSimbolos *tb, char *nome )
{
	TabelaSimbolos *it;
	int i = 0;
	for ( it = tb; it != NULL; it = it->proximoPtr )
	{
		if ( strcmp( nome, it->nome ) == 0 )
			return i;

		i++;
	}

	return -1;
}

void insereNovaLinha( TabelaSimbolos *nodo, int linha )
{
	if ( nodo->linhas == NULL )
	{
		nodo->linhas = (LinhaLista *)malloc( sizeof( LinhaLista ) );
		if ( nodo->linhas == NULL )
		{
			fprintf( stderr, "Falta de memória ao alocar linha do elemento da tabela de simbolos \"%s\". Linha: %d.\n", nodo->nome, linha );
			exit( 1 );
		}

		nodo->linhas->linha = linha;
		nodo->linhas->proximoPtr = NULL;
	}
	else
	{
		LinhaLista *it = nodo->linhas;
		while ( it->proximoPtr != NULL )
			it = it->proximoPtr;
		
		it->proximoPtr = (LinhaLista *)malloc( sizeof( LinhaLista ) );
		if ( it->proximoPtr == NULL )
		{
			fprintf( stderr, "Falta de memória ao alocar linha do elemento da tabela de simbolos \"%s\". Linha: %d.\n", nodo->nome, linha );
			exit( 1 );
		}
		it->proximoPtr->linha = linha;
		it->proximoPtr->proximoPtr = NULL;
	}
}		
			

TabelaSimbolos *insereTabelaSimbolos( TabelaSimbolos *tb, char *nome, int linha )
{
	TabelaSimbolos *novoElemento = (TabelaSimbolos *)malloc( sizeof(TabelaSimbolos) );
	
	if ( novoElemento == NULL )
	{
		fprintf( stderr, "Falta de memória ao alocar o elemento da tabela de simbolos \"%s\".\n", nome );
		exit( 1 );
	}

	novoElemento->nome = copiaString( nome );
	novoElemento->linhas = NULL;
	novoElemento->proximoPtr = NULL;
	insereNovaLinha( novoElemento, linha );


	if ( tb == NULL )
		tb = novoElemento;
	else
	{
		novoElemento->proximoPtr = tb;
		tb = novoElemento;
	}

	return tb;
}

char *copiaString( char *string )
{
	int n;
	char *t;
	if ( string == NULL )
		return NULL;
	n = strlen( string ) + 1;
	t = (char *)malloc( sizeof( char ) * n );
	if ( t == NULL )
	{
		fprintf( stderr, "Falta de memória ao alocar a string \"%s\".\n", string );
		exit( 1 );
	}
	else
		strcpy( t, string );
	
	return t;
}
