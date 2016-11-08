#ifndef BT_H
#define BT_H

typedef enum {
    NUMBER_NODE,
    PLUS_NODE,
    MINUS_NODE,
    TIMES_NODE,
    OVER_NODE
} NodeKind;

struct node; // Opaque structure to ensure encapsulation.

typedef struct node BT;

BT* new_leaf(NodeKind kind, int data);
BT* new_node(NodeKind kind, BT *l, BT *r);

void print_tree(BT *tree);
void free_tree(BT *tree);

#endif
