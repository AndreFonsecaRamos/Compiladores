/* João Francisco - 2023228417 */
/* André Ramos - 2023227306 */

#ifndef SEMANTICS_H
#define SEMANTICS_H

#include "ast.h"

enum type { type_none, type_int, type_double, type_boolean, type_void, type_string_array, type_undef };

typedef struct param_entry {
    char *type_str;
    struct param_entry *next;
} param_entry;

typedef struct symbol_entry {
    char *name;
    char *type_str;
    int is_method;
    int is_param;        
    param_entry *params; 
    int line, col;
    struct symbol_entry *next;
} symbol_entry;

typedef struct method_table {
    char *name;            
    char *signature;       
    symbol_entry *symbols; 
    struct method_table *next;
} method_table;

typedef struct {
    char *name;
    symbol_entry *symbols; 
    method_table *methods;
} class_table;

extern class_table *gtable;

int semantic_analysis(struct node *program);
void print_tables(void);
void show_annotated(struct node *node, int depth);
const char *type_to_string(enum type t);
enum type category_to_type(enum category c);

#endif