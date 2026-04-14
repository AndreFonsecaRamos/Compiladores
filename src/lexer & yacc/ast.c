#include <stdlib.h>
#include <stdio.h>
#include "ast.h"

const char *category_names[] = {
    "Program", "MethodDecl", "FieldDecl", "MethodHeader", "ParamDecl", "MethodParams", "MethodBody",
    "Assign", "Or", "And", "Eq", "Ne", "Lt", "Gt", "Le", "Ge", "Add", "Sub", "Mul", "Div", "Mod", "Not", "Minus", "Plus",
    "Xor", "Lshift", "Rshift",
    "Call", "ParseArgs", "Length", "Return", "If", "While", "Print", "Block", "VarDecl",
    "Identifier", "Bool", "Double", "Int", "Void", "StringArray", "Natural", "Decimal", "BoolLit", "StrLit"
};

struct node *newnode(enum category category, char *token) {
    struct node *new = malloc(sizeof(struct node));
    new->category = category;
    new->token = token;
    new->children = NULL;
    return new;
}

void addchild(struct node *parent, struct node *child) {
    if (parent == NULL || child == NULL) return;

    struct node_list *new = malloc(sizeof(struct node_list));
    new->node = child;
    new->next = NULL;
    
    if (parent->children == NULL) {
        parent->children = new;
        return;
    }

    struct node_list *current = parent->children;
    while(current->next != NULL) {
        current = current->next;
    }
    current->next = new;
}

struct node *create_block_node(struct node *statement_list) {
    if (statement_list == NULL) {
        return NULL;
    }
    
    struct node_list *children_list = statement_list->children;
    
    /* Bloco vazio: {} -> retorna NULL (desaparece) */
    if (children_list == NULL) {
        free(statement_list);
        return NULL;
    }
    
    /* Exatamente 1 filho */
    if (children_list->next == NULL) {
        struct node *single = children_list->node;
        free(children_list);
        free(statement_list);
        return single;
    }
    
    /* Mais de 1 filho: cria nó Block */
    statement_list->category = Block;
    return statement_list;
}

void print_ast(struct node *current, int depth) {
    if (current == NULL) return;

    for (int i = 0; i < depth; i++) {
        printf("..");
    }

    if (current->token != NULL) {
        printf("%s(%s)\n", category_names[current->category], current->token);
    } else {
        printf("%s\n", category_names[current->category]);
    }

    struct node_list *child_item = current->children;
    while (child_item != NULL) {
        print_ast(child_item->node, depth + 1);
        child_item = child_item->next;
    }
}