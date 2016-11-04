#ifndef ARVORE_H
#define ARVORE_H

typedef struct treeNode TreeNode;

typedef enum
{
	NUMBER_NODE,
	PLUS_NODE,
	MINUS_NODE,
	TIMES_NODE,
	OVER_NODE,
} NodeKind;

TreeNode *novoNodo( NodeKind kind );

void adicionaFilho( TreeNode *pai, TreeNode *filho, int posicao );



#endif
