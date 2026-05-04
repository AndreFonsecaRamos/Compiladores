/* João Francisco - 2023228417 */
/* André Ramos - 2023227306 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "semantics.h"

SymTable *global_table_head = NULL;
SymTable *current_table_tail = NULL;

Symbol* lookup_symbol(SymTable *table, const char *name);

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

const char* get_op_string(enum category cat) {
    switch(cat) {
        case Add: case Plus: return "+";
        case Sub: case Minus: return "-";
        case Mul: return "*";
        case Div: return "/";
        case Mod: return "%";
        case Assign: return "=";
        case Eq: return "==";
        case Ne: return "!=";
        case Lt: return "<";
        case Gt: return ">";
        case Le: return "<=";
        case Ge: return ">=";
        case And: return "&&";
        case Or: return "||";
        case Xor: return "^";
        case Not: return "!";
        case Lshift: return "<<";
        case Rshift: return ">>";
        default: return "";
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

void add_symbol(SymTable *table, struct node *id_node, const char *type, const char *param_types, int is_param){

    const char *name = id_node->token;
    
    // Verificações
    if (strcmp(name, "_") == 0) {
        printf("Line %d, col %d: Symbol _ is reserved\n", id_node->line, id_node->col);
    }
    
    Symbol *existing = lookup_symbol(table, name);
    if (existing != NULL) {

        int is_dup = 0;
        if (strcmp(table->type, "Class") == 0) {
            if (param_types == NULL && existing->param_types == NULL) is_dup = 1; 
            else if (param_types != NULL && existing->param_types != NULL && strcmp(param_types, existing->param_types) == 0) is_dup = 1; 
        } else {
            is_dup = 1; 
        }

        if (is_dup) {
            printf("Line %d, col %d: Symbol %s already defined\n", id_node->line, id_node->col, name);
            return;
        }
    }

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


Symbol* lookup_symbol(SymTable *table, const char *name) {
    if (table == NULL) return NULL;
    Symbol *curr = table->symbols;
    while (curr != NULL) {
        if (strcmp(curr->name, name) == 0) {
            return curr;
        }
        curr = curr->next;
    }
    return NULL;
}

Symbol* find_method(SymTable *class_table, const char *name, int num_args, char **arg_types, int *is_ambiguous) {
    *is_ambiguous = 0;
    Symbol *perfect_match = NULL;
    Symbol *compat_match = NULL;
    int compat_count = 0;

    Symbol *curr = class_table->symbols;
    while (curr != NULL) {
        if (curr->param_types != NULL && strcmp(curr->name, name) == 0) {
            char *params_copy = strdup(curr->param_types);
            int m_num_args = 0;
            char *m_args[100];
            char *token = strtok(params_copy, ",");
            while(token != NULL) {
                m_args[m_num_args++] = strdup(token);
                token = strtok(NULL, ",");
            }
            free(params_copy);

            if (m_num_args == num_args) {
                int exact = 1;
                int compat = 1;
                for (int i = 0; i < num_args; i++) {
                    if (strcmp(m_args[i], arg_types[i]) != 0) {
                        exact = 0;
                        if (strcmp(m_args[i], "double") == 0 && strcmp(arg_types[i], "int") == 0) {

                        } else {
                            compat = 0;
                        }
                    }
                }
                
                for(int i=0; i<m_num_args; i++) free(m_args[i]);

                if (exact) {
                    perfect_match = curr;
                    break;
                } else if (compat) {
                    compat_match = curr;
                    compat_count++;
                }
            } else {
                for(int i=0; i<m_num_args; i++) free(m_args[i]);
            }
        }
        curr = curr->next;
    }

    if (perfect_match) return perfect_match;
    if (compat_count > 1) {
        *is_ambiguous = 1;
        return NULL;
    }
    return compat_match;
}

void check_expression(struct node *expr, SymTable *class_table, SymTable *method_table) {
    if (expr == NULL) return;

    struct node_list *child = expr->children;
    while (child != NULL) {
        check_expression(child->node, class_table, method_table);
        child = child->next;
    }

    switch (expr->category) {
        case Natural: {
            char clean_num[100];
            int j = 0;

            for(int i = 0; expr->token[i] != '\0'; i++) {
                if(expr->token[i] != '_') clean_num[j++] = expr->token[i];
            }

            clean_num[j] = '\0';
            
            double val = atof(clean_num);
            if (val > 2147483647.0) {
                printf("Line %d, col %d: Number %s out of bounds\n", expr->line, expr->col, expr->token);
            }
            expr->annotation = strdup("int");
            break;
        }
        case Decimal: {
            char clean_num[1024];
            int j = 0;
            for(int i = 0; expr->token[i] != '\0'; i++) {
                if(expr->token[i] != '_') clean_num[j++] = expr->token[i];
            }
            clean_num[j] = '\0';

            double val;
            sscanf(clean_num, "%lf", &val);
            char *end;
            strtod(clean_num, &end);

            expr->annotation = strdup("double");
            break;
        }
        case BoolLit:
            expr->annotation = strdup("boolean");
            break;
        case Id: {

            Symbol *sym = lookup_symbol(method_table, expr->token);
            if (sym == NULL) {
                sym = lookup_symbol(class_table, expr->token);
            }

            if (sym != NULL) {
                expr->annotation = strdup(sym->type);
            } else {
                printf("Line %d, col %d: Cannot find symbol %s\n", expr->line, expr->col, expr->token);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case Add: case Sub: case Mul: case Div: case Mod: {
            struct node *left = expr->children->node;
            struct node *right = expr->children->next->node;
            char *t1 = left->annotation;
            char *t2 = right->annotation;

            if (strcmp(t1, "int") == 0 && strcmp(t2, "int") == 0) {
                expr->annotation = strdup("int");
            } 
            else if ((strcmp(t1, "int") == 0 || strcmp(t1, "double") == 0) &&
                     (strcmp(t2, "int") == 0 || strcmp(t2, "double") == 0)) {
                expr->annotation = strdup("double");
            } 
            else {
                printf("Line %d, col %d: Operator %s cannot be applied to types %s, %s\n",
                    expr->line, expr->col, get_op_string(expr->category), t1, t2);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case And: case Or: case Xor: {
            struct node *left = expr->children->node;
            struct node *right = expr->children->next->node;
            char *t1 = left->annotation;
            char *t2 = right->annotation;

            if (strcmp(t1, "boolean") == 0 && strcmp(t2, "boolean") == 0) {
                expr->annotation = strdup("boolean");
            } 
            else {
                printf("Line %d, col %d: Operator %s cannot be applied to types %s, %s\n",
                    expr->line, expr->col, get_op_string(expr->category), t1, t2);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case Lt: case Gt: case Le: case Ge: {
            struct node *left = expr->children->node;
            struct node *right = expr->children->next->node;
            char *t1 = left->annotation;
            char *t2 = right->annotation;

            if ((strcmp(t1, "int") == 0 || strcmp(t1, "double") == 0) &&
                     (strcmp(t2, "int") == 0 || strcmp(t2, "double") == 0)) {
                expr->annotation = strdup("boolean");
            } 
            else {
                printf("Line %d, col %d: Operator %s cannot be applied to types %s, %s\n",
                    expr->line, expr->col, get_op_string(expr->category), t1, t2);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case Eq: case Ne: {
            struct node *left = expr->children->node;
            struct node *right = expr->children->next->node;
            char *t1 = left->annotation;
            char *t2 = right->annotation;

            if (strcmp(t1, t2) == 0 || 
                    ((strcmp(t1, "int") == 0 || strcmp(t1, "double") == 0) && 
                     (strcmp(t2, "int") == 0 || strcmp(t2, "double") == 0))) {
                expr->annotation = strdup("boolean");
            } 
            else {
                printf("Line %d, col %d: Operator %s cannot be applied to types %s, %s\n",
                    expr->line, expr->col, get_op_string(expr->category), t1, t2);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case Plus: case Minus: {
            struct node *child = expr->children->node;
            char *t1 = child->annotation;

            if (strcmp(t1, "int") == 0 || strcmp(t1, "double") == 0) {
                expr->annotation = strdup(t1);
            } 
            else {
                printf("Line %d, col %d: Operator %s cannot be applied to type %s\n",
                    expr->line, expr->col, get_op_string(expr->category), t1);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case Not: {
            struct node *child = expr->children->node;
            char *t1 = child->annotation;

            if (strcmp(t1, "boolean") == 0) {
                expr->annotation = strdup("boolean");
            } 
            else {
                printf("Line %d, col %d: Operator %s cannot be applied to type %s\n",
                    expr->line, expr->col, get_op_string(expr->category), t1);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case Lshift: case Rshift: {
            struct node *left = expr->children->node;
            struct node *right = expr->children->next->node;
            char *t1 = left->annotation;
            char *t2 = right->annotation;

            if (strcmp(t1, "int") == 0 && strcmp(t2, "int") == 0) {
                expr->annotation = strdup("int");
            } 
            else {
                printf("Line %d, col %d: Operator %s cannot be applied to types %s, %s\n",
                    expr->line, expr->col, get_op_string(expr->category), t1, t2);
                expr->annotation = strdup("undef");
            }
            break;
        }
        case Length: {
            struct node *child = expr->children->node;
            char *t1 = child->annotation;
            
            if (strcmp(t1, "String[]") == 0) {
                expr->annotation = strdup("int");
            }
            else {
                printf("Line %d, col %d: Operator .length cannot be applied to type %s\n",
                       expr->line, expr->col, t1);
                expr->annotation = strdup("undef");
            }
            break;
        }

        case Assign: {
            struct node *left = expr->children->node;
            struct node *right = expr->children->next->node;
            char *t1 = left->annotation;
            char *t2 = right->annotation;

            if (strcmp(t1, t2) == 0 || (strcmp(t1, "double") == 0 && strcmp(t2, "int") == 0)) {
                expr->annotation = strdup(t1);
            } 

            else {
                printf("Line %d, col %d: Operator %s cannot be applied to types %s, %s\n",
                       expr->line, expr->col, get_op_string(expr->category), t1, t2);
                expr->annotation = strdup(t1);
            }
            break;
        }
        case Call: {
            struct node *id_node = expr->children->node;
            struct node_list *arg = expr->children->next;
            
            char *arg_types[100];
            int num_args = 0;
            int has_undef_arg = 0;

            while (arg != NULL) {
                check_expression(arg->node, class_table, method_table);
                arg_types[num_args] = arg->node->annotation;
                if (strcmp(arg->node->annotation, "undef") == 0) {
                    has_undef_arg = 1;
                }
                num_args++;
                arg = arg->next;
            }

            int is_ambiguous = 0;
            Symbol *matched_method = find_method(class_table, id_node->token, num_args, arg_types, &is_ambiguous);

            if (is_ambiguous) {
                printf("Line %d, col %d: Reference to method %s is ambiguous\n", id_node->line, id_node->col, id_node->token);
                expr->annotation = strdup("undef");
                id_node->annotation = strdup("undef");
            } 
            else if (matched_method != NULL) {
                expr->annotation = strdup(matched_method->type);
                
                char sig[1024];
                if (matched_method->param_types != NULL && strlen(matched_method->param_types) > 0) {
                    sprintf(sig, "(%s)", matched_method->param_types);
                } else {
                    sprintf(sig, "()");
                }
                id_node->annotation = strdup(sig);
                if (has_undef_arg) {
                    expr->annotation = strdup("undef");
                }
            } 
            else {

                printf("Line %d, col %d: Cannot find symbol %s\n", expr->line, expr->col, id_node->token);
                expr->annotation = strdup("undef");
                id_node->annotation = strdup("undef");
            }
            break;
        }
        case ParseArgs: {
            struct node *id_node = expr->children->node;
            struct node *index_expr = expr->children->next->node;
            check_expression(index_expr, class_table, method_table);
            
            Symbol *arr_sym = lookup_symbol(method_table, id_node->token);
            if(arr_sym == NULL) arr_sym = lookup_symbol(class_table, id_node->token);

            if (arr_sym == NULL || strcmp(arr_sym->type, "String[]") != 0) {
                printf("Line %d, col %d: Operator Integer.parseInt cannot be applied to type %s\n", 
                       id_node->line, id_node->col, arr_sym ? arr_sym->type : "undef");
            }
            if (strcmp(index_expr->annotation, "int") != 0) {
                printf("Line %d, col %d: Incompatible type %s in Integer.parseInt statement\n", 
                       index_expr->line, index_expr->col, index_expr->annotation);
            }
            expr->annotation = strdup("int");
            break;
        }
    }
}

void check_statements(struct node *stmt, SymTable *class_table, SymTable *method_table) {
    if (stmt == NULL) return;

    switch (stmt->category) {
        case If: {
            check_expression(stmt->children->node, class_table, method_table); 
            char *cond_type = stmt->children->node->annotation;
            if (strcmp(cond_type, "boolean") != 0 && strcmp(cond_type, "undef") != 0) {
                printf("Line %d, col %d: Incompatible type %s in if statement\n", 
                       stmt->children->node->line, stmt->children->node->col, cond_type);
            }
            check_statements(stmt->children->next->node, class_table, method_table); 
            if (stmt->children->next->next != NULL) {
                check_statements(stmt->children->next->next->node, class_table, method_table); 
            }
            break;
        }
        case While: {
            check_expression(stmt->children->node, class_table, method_table);
            char *cond_type = stmt->children->node->annotation;
            if (strcmp(cond_type, "boolean") != 0 && strcmp(cond_type, "undef") != 0) {
                printf("Line %d, col %d: Incompatible type %s in while statement\n", 
                       stmt->children->node->line, stmt->children->node->col, cond_type);
            }
            check_statements(stmt->children->next->node, class_table, method_table);
            break;
        }
        case Return: {
            Symbol *ret_sym = lookup_symbol(method_table, "return");
            char *expected_type = ret_sym ? ret_sym->type : "void";
            
            if (stmt->children != NULL) {
                check_expression(stmt->children->node, class_table, method_table);
                char *actual_type = stmt->children->node->annotation;

                if (strcmp(actual_type, "undef") != 0) {
                    if (strcmp(expected_type, "void") == 0) {
                        printf("Line %d, col %d: Incompatible type %s in return statement\n",
                               stmt->children->node->line, stmt->children->node->col, actual_type);
                    } 
                    else if (strcmp(expected_type, actual_type) != 0 && 
                            !(strcmp(expected_type, "double") == 0 && strcmp(actual_type, "int") == 0)) {
                        printf("Line %d, col %d: Incompatible type %s in return statement\n",
                               stmt->children->node->line, stmt->children->node->col, actual_type);
                    }
                }
            } else {
                if (strcmp(expected_type, "void") != 0) {
                    printf("Line %d, col %d: Incompatible type void in return statement\n",
                           stmt->line, stmt->col); 
                }
            }
            break;
        }
        case Print: {
            struct node *print_expr = stmt->children->node;
            if (print_expr->category != StrLit) {
                check_expression(print_expr, class_table, method_table);
                char *type = print_expr->annotation;

                if (strcmp(type, "undef") != 0 && (strcmp(type, "String[]") == 0 || strcmp(type, "void") == 0)) {
                    printf("Line %d, col %d: Incompatible type %s in print statement\n",
                           print_expr->line, print_expr->col, type);
                }
            }
            else {
                print_expr->annotation = strdup("String"); 
            }
            break;
        }
        case Block:
        case MethodBody: {
            struct node_list *child = stmt->children;
            while (child != NULL) {
                check_statements(child->node, class_table, method_table);
                child = child->next;
            }
            break;
        }
        case Assign:
        case Call:
        case ParseArgs:

            check_expression(stmt, class_table, method_table);
            break;
        case VarDecl: {
            struct node *type_node = stmt->children->node;
            struct node *id_node = stmt->children->next->node;
            add_symbol(method_table, id_node, get_type_string(type_node->category), NULL, 0);
            break;
        }
        default:
            break; 
    }
}

void check_program(struct node *program_node) {
    if (program_node == NULL || program_node->category != Program) return;

    struct node_list *child = program_node->children;
    
    const char *class_name = child->node->token;
    SymTable *class_table = create_and_add_table(class_name, "Class", NULL);

    child = child->next;
    while (child != NULL) {
        struct node *decl = child->node;

        if (decl->category == FieldDecl) {
            struct node *type_node = decl->children->node;
            struct node *id_node = decl->children->next->node;
            add_symbol(class_table, id_node, get_type_string(type_node->category), NULL, 0);

        } else if (decl->category == MethodDecl) {
            struct node *header = decl->children->node;
            struct node *body = decl->children->next->node;

            struct node *ret_type_node = header->children->node;
            struct node *id_node = header->children->next->node;
            struct node *params_node = header->children->next->next->node; 

            const char *method_name = id_node->token;
            const char *ret_type = get_type_string(ret_type_node->category);
            char *params_str = build_params_string(params_node);

            add_symbol(class_table, id_node, ret_type, params_str, 0);

            SymTable *method_table = create_and_add_table(method_name, "Method", params_str);
            struct node dummy = {Id, "return", NULL, 0, 0, NULL};
            add_symbol(method_table, &dummy, ret_type, NULL, 0);

            struct node_list *param = params_node->children;
            while (param != NULL) {
                struct node *pdecl = param->node;
                struct node *ptype = pdecl->children->node;
                struct node *pid = pdecl->children->next->node;
                add_symbol(method_table, pid, get_type_string(ptype->category), NULL, 1);
                param = param->next;
            }

            check_statements(body, class_table, method_table);
            
            free(params_str);
        }
        child = child->next;
    }
}

void print_symbol_tables(SymTable *head) {
    SymTable *curr_table = head;

    while (curr_table != NULL) {
        if (strcmp(curr_table->type, "Class") == 0) {
            printf("===== Class %s Symbol Table =====\n", curr_table->name);
        } 
        else {
            printf("===== Method %s(%s) Symbol Table =====\n", curr_table->name, curr_table->method_params);
        }

        Symbol *curr_sym = curr_table->symbols;
        while (curr_sym != NULL) {
            if (curr_sym->param_types != NULL) { 
                printf("%s\t(%s)\t%s\n", curr_sym->name, curr_sym->param_types, curr_sym->type);
            } 
            else { 
                printf("%s\t\t%s", curr_sym->name, curr_sym->type);
                if (curr_sym->is_param) {
                    printf("\tparam");
                }
                printf("\n");
            }
            curr_sym = curr_sym->next;
        }

        printf("\n"); 
        curr_table = curr_table->next;
    }
}

