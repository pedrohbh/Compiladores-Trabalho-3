
#include <stdio.h>
#include <stdlib.h>
#include "bt.h"

struct node {
    NodeKind kind;
    int data;
    struct node *l, *r;
};

BT* create_node(NodeKind kind) {
    BT* node = malloc(sizeof * node);
    node->kind = kind;
    node->l = node->r = NULL;
    return node;
}

BT* new_leaf(NodeKind kind, int data) {
    BT *leaf = create_node(kind);
    leaf->data = data;
    return leaf;
}

BT* new_node(NodeKind kind, BT *l, BT *r) {
    BT *node = create_node(kind);
    node->l = l;
    node->r = r;
    return node;
}

void print_node(BT *node, int level) {
    printf("%d: Node -- Addr: %p -- Kind: %d -- Data: %d -- Left: %p -- Right: %p\n",
           level, node, node->kind, node->data, node->l, node->r);
}

void print_bt(BT *tree, int level) {
    if (tree->l != NULL) print_bt(tree->l, level + 1);
    print_node(tree, level);
    if (tree->r != NULL) print_bt(tree->r, level + 1);
}

void print_tree(BT *tree) {
    print_bt(tree, 0);
}

void free_tree(BT *tree) {
    if (tree != NULL) {
      free_tree(tree->l);
      free_tree(tree->r);
      free(tree);
    }
}
