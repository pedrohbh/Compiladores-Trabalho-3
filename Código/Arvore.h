#ifndef ARVORE_H
#define ARVORE_H

typedef struct treeNode TreeNode;

typedef enum
{
	NUMBER_NODE,
	STRING_NODE,
	BLOCK_NODE,
	INPUT_NODE,
	OUTPUT_NODE,
	WRITE_NODE,
	RETURN_NODE,
	IF_NODE,
	LT_NODE,
	LE_NODE,
	GT_NODE,
	GE_NODE,
	EQ_NODE,
	NEQ_NODE,
	PLUS_NODE,
	MINUS_NODE,
	TIMES_NODE,
	OVER_NODE,
} NodeKind;

TreeNode *novoNodo( NodeKind kind );

void adicionaFilhoPrototipo( TreeNode *pai, TreeNode *filho, int posicao );

void adicionaFilho( TreeNode *pai, int tamanho, ... );



#endif
