#include <stdlib.h>
#include <stdarg.h>
#include "Arvore.h"

#define MAXCHILDREN 7

extern int yylineno;

struct treeNode
{
	NodeKind kind;
	struct treeNode *filhosPtr[ 7 ];
	int lineno;
};


TreeNode *novoNodo( NodeKind kind )
{
	int i;
	TreeNode *t = (TreeNode *)malloc(sizeof(TreeNode));
	if ( t == NULL )
	{
		fprintf( stderr, "Erro ao alocar novo nodo por falta de memória\n");
	}
	else
	{
		for ( i = 0; i < MAXCHILDREN; i++ )
			t->filhosPtr[ i ] = NULL;
		
		t->kind = kind;
		t->lineno = lineno;
	}

	return t;
}


void adicionaFilhoPrototipo( TreeNode *pai, TreeNode *filho, int posicao )
{
	if ( posicao >= MAXCHIDREN )
	{
		fprintf( stderr, "Estouro do indice máximo de filhos. O valor máximo é %d, enquanto o indice é %d\n", MAXCHILDREN, posicao );
	}

	pai->filhoPtr[ posicao ] = filho;
}

void adicionaFilho( TreeNode *pai, int tamanho, ... )
{
	if ( tamanho >= MAXCHIDREN )
	{
		fprintf( stderr, "Estouro do indice máximo de filhos. O valor máximo é %d, enquanto o indice é %d\n", MAXCHILDREN, posicao );
	}

	int i;
	va_list ap;

	va_start( ap, i );
	
	for ( i = 0; i < tamanho; i++ )
	{
		pai->filhosPtr[ i ] = va_arg( ap, TreeNode * );
	}

	va_end( ap );

}
