/* João Francisco - 2023228417 */
/* André Ramos - 2023227306 */

#ifndef SEMANTICS_H
#define SEMANTICS_H

#include "ast.h"

/* Enumeração dos tipos semânticos */
enum type {
    type_none = 0,
    type_int,
    type_double,
    type_boolean,
    type_void,
    type_string_array,
    type_undef
};

/* Funções para o jucompiler.y */
int semantic_analysis(struct node *program);
void print_tables(void);
void show_annotated(struct node *node, int depth);

/* Utilitários de tipos */
const char *type_to_string(enum type t);
enum type category_to_type(enum category c);

#endif