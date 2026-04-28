#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantics.h"

SymTable *global_table_head = NULL;
SymTable *current_table_tail = NULL;

const char* get_type_string(enum category cat) {
    switch (cat) {
        case Int: return "int";
        case Double: return "double";
        case Bool: return "boolean";
        case Void: return "void";
        case StringArray: return "String[]";
        default: return "undef";
    }
}

SymTable* create_and_add_table(const char *name, const char *type, const char *method_params) {
    SymTable *new_table = malloc(sizeof(SymTable));
    new_table->name = strdup(name);
    new_table->type = strdup(type);
    new_table->method_params = method_params ? strdup(method_params) : NULL;
    new_table->symbols = NULL;
    new_table->next = NULL;

    if (global_table_head == NULL) {
        global_table_head = new_table;
        current_table_tail = new_table;
    } 
    
    else {
        current_table_tail->next = new_table;
        current_table_tail = new_table;
    }

    return new_table;
}

void add_symbol(SymTable *table, const char *name, const char *type, const char *param_types, int is_param){

    Symbol *new_sym = malloc(sizeof(Symbol));
    new_sym->name = strdup(name);
    new_sym->type = strdup(type);
    new_sym->param_types = param_types ? strdup(param_types) : NULL;
    new_sym->is_param = is_param;
    new_sym->next = NULL;

    if(table->symbols == NULL) {
        table->symbols = new_sym;
    } 
    
    else{

        Symbol *curr = table->symbols;
        while (curr->next != NULL) {
            curr = curr->next;
        }

        curr->next = new_sym;
    }
}

char* build_params_string(struct node *params_node){

    char buffer[1024] = "";
    struct node_list *param_curr = params_node->children;

    while (param_curr != NULL) {

        struct node *pdecl = param_curr->node;
        struct node *ptype = pdecl->children->node; 
        
        strcat(buffer, get_type_string(ptype->category));
        
        if (param_curr->next != NULL) {
            strcat(buffer, ",");
        }

        param_curr = param_curr->next;
    }

    return strdup(buffer);
}

void parse_var_decls(SymTable *table, struct node *current){
    
    if (current == NULL) return;

    if (current->category == VarDecl) {
        struct node *type_node = current->children->node;
        struct node *id_node = current->children->next->node;
        add_symbol(table, id_node->token, get_type_string(type_node->category), NULL, 0);
    }

    struct node_list *child = current->children;
    while (child != NULL) {
        parse_var_decls(table, child->node);
        child = child->next;
    }
}

