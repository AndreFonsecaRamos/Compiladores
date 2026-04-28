#ifndef SEMANTIC_H
#define SEMANTIC_H

#include "ast.h"

typedef struct _symbol {
    char *name;             
    char *type;             
    char *param_types;      
    int is_param;           
    struct _symbol *next;   
} Symbol;

typedef struct _symtable {
    char *name;             
    char *type;             
    char *method_params;    
    Symbol *symbols;       
    struct _symtable *next; 
} SymTable;

void check_program(struct node *program_node);
void print_symbol_tables(SymTable *head);

#endif