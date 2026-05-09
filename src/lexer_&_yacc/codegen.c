/* João Francisco - 2023228417 */
/* André Ramos - 2023227306 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"
#include "semantics.h"
#include "codegen.h"

/* Variaveis globais para gerir os registos temporarios e labels */
int temporary;
int label_counter;
int str_counter;

static int main_generated = 0;
static int in_main_entry = 0;

/* Para o pre-allocation dos slots de And/Or (so podem estar no entry block, */
/* senao deitam o stack abaixo em loops grandes)                              */
static int ao_alloca_base = 0;
static int ao_alloca_next = 0;

extern class_table *gtable;
method_table *current_mt = NULL;


/* Lista de strings literais  */
typedef struct str_entry {
    char *token;
    int id;
    int length;
    struct str_entry *next;
} str_entry;

str_entry *str_list = NULL;

/* adiciona uma string a lista (calculando o comprimento real, contando */
/* escapes como \n, \t, etc. como um caracter)                          */
void add_string(const char *token) {
    str_entry *novo = malloc(sizeof(str_entry));
    novo->token = strdup(token);
    novo->id = str_counter++;

    int len = 0;
    for(int i = 1; token[i] != '"' && token[i] != '\0'; i++){
        if (token[i] == '\\') i++;   /* salta o caracter de escape */
        len++;
    }
    novo->length = len + 1;      /* +1 para o '\0' final */
    novo->next = NULL;

    /* Insere no fim da lista */
    if(str_list == NULL){
        str_list = novo;
    } 
    
    else {
        str_entry *curr = str_list;
        while (curr->next != NULL) curr = curr->next;
        curr->next = novo;
    }
}

int get_string_id(const char *token) {
    for(str_entry *curr = str_list; curr != NULL; curr = curr->next){
        if (strcmp(curr->token, token) == 0) return curr->id;
    }
    return -1;
}

int get_string_length(const char *token) {
    for (str_entry *curr = str_list; curr != NULL; curr = curr->next) {
        if (strcmp(curr->token, token) == 0) return curr->length;
    }
    return 1;
}


/* Funcoes auxiliares para a AST */
static struct node *getchild(struct node *n, int index) {
    if (n == NULL) return NULL;
    struct node_list *curr = n->children;
    for (int i = 0; i < index && curr != NULL; i++) {
        curr = curr->next;
    }
    if (curr == NULL) return NULL;
    return curr->node;
}

static int countchildren(struct node *n) {
    if(n == NULL) return 0;
    int count = 0;
    for(struct node_list *curr = n->children; curr != NULL; curr = curr->next){
        count++;
    }
    return count;
}


/* Conversoes de tipos */
static enum type string_to_type(const char *s) {
    if(s == NULL) return type_undef;
    if(strcmp(s, "int") == 0)      return type_int;
    if(strcmp(s, "double") == 0)   return type_double;
    if(strcmp(s, "boolean") == 0)  return type_boolean;
    if(strcmp(s, "String[]") == 0) return type_string_array;
    if(strcmp(s, "void") == 0)     return type_void;
    return type_undef;
}

const char* get_llvm_type(enum type t) {
    switch(t) {
        case type_int:          return "i32";
        case type_double:       return "double";
        case type_boolean:      return "i1";
        case type_void:         return "void";
        case type_string_array: return "i8**";
        default:                return "i32";
    }
}


/* procura simbolos na tabela */
static symbol_entry *find_symbol(symbol_entry *list, const char *name) {
    if(name == NULL) return NULL;
    for(symbol_entry *cur = list; cur != NULL; cur = cur -> next){
        if (cur->name != NULL && strcmp(cur->name, name) == 0) return cur;
    }
    return NULL;
}

/* Devolve o ponteiro LLVM para uma variavel: %x se for local, @x se global */
char* get_var_ptr(const char *name, enum type expected) {
    char *buf = malloc(strlen(name) + 64);

    if(current_mt != NULL){
        symbol_entry *s = find_symbol(current_mt -> symbols, name);
        /* Tem de ser uma variavel (nao metodo) e do tipo certo */
        if (s != NULL && !s->is_method && string_to_type(s -> type_str) == expected) {
            sprintf(buf, "%%%s", name);
            return buf;
        }
    }
    /* senao e global */
    sprintf(buf, "@%s", name);
    return buf;
}


/* Helpers para literais numericos */

/* Java permite underscores nos numeros (123_456). Temos de os tirar */
static char *strip_underscores(const char *s) {
    char *r = malloc(strlen(s) + 1);
    int j = 0;
    for(int i = 0; s[i] != '\0'; i++){
        if (s[i] != '_') {
            r[j] = s[i];
            j++;
        }
    }
    r[j] = '\0';
    return r;
}

/* arranja o formato dos doubles: ".5" -> "0.5" e "1e10" -> "1.0e10" */
static char *fix_decimal_format(const char *s) {
    if(s[0] == '.'){
        char *r = malloc(strlen(s) + 2);
        r[0] = '0';
        strcpy(r + 1, s);
        return r;
    }

    if(strchr(s, '.') == NULL){
        char *e = strchr(s, 'e');
        if (e == NULL) e = strchr(s, 'E');
        if (e != NULL) {
            int n = e - s;
            char *r = malloc(strlen(s) + 3);
            strncpy(r, s, n);
            r[n] = '\0';
            strcat(r, ".0");
            strcat(r, e);
            return r;
        }
    }

    return strdup(s);
}


/* Mangling de nomes para overloading */
static void add_param_local(param_entry **list, const char *type_str) {
    param_entry *p = malloc(sizeof(param_entry));
    p->type_str = strdup(type_str);
    p->next = NULL;

    if (*list == NULL) {
        *list = p;
        return;
    }
    param_entry *cur = *list;
    while (cur->next != NULL) cur = cur->next;
    cur->next = p;
}

static void free_params_local(param_entry *p) {
    while (p != NULL) {
        param_entry *prox = p->next;
        free(p->type_str);
        free(p);
        p = prox;
    }
}

static int count_methods_with_name(const char *name) {
    int c = 0;
    for (symbol_entry *s = gtable->symbols; s != NULL; s = s->next) {
        if (s->is_method && strcmp(s->name, name) == 0) c++;
    }
    return c;
}

static const char *llvm_type_mangle(enum type t) {
    switch(t) {
        case type_int:          return "i32";
        case type_double:       return "double";
        case type_boolean:      return "i1";
        case type_string_array: return "i8pp";
        default:                return "i32";
    }
}

/* So fazemos mangling se houver overloading (mais que 1 metodo com o mesmo nome) */
static char *mangle_name(const char *name, param_entry *params) {
    if (gtable == NULL || count_methods_with_name(name) <= 1) {
        return strdup(name);
    }

    char buf[4096];
    strcpy(buf, name);
    strcat(buf, "__");

    int first = 1;
    for (param_entry *p = params; p != NULL; p = p->next) {
        if (!first) strcat(buf, "_");
        strcat(buf, llvm_type_mangle(string_to_type(p->type_str)));
        first = 0;
    }
    return strdup(buf);
}

static char *mangle_name_from_ast(const char *name, struct node *params_node) {
    if (gtable == NULL || count_methods_with_name(name) <= 1) {
        return strdup(name);
    }

    /* Constroi a lista de parametros a partir da AST e usa o mangle_name normal */
    param_entry *plist = NULL;
    int pidx = 0;
    struct node *pd;
    while ((pd = getchild(params_node, pidx++)) != NULL) {
        struct node *pt = getchild(pd, 0);
        add_param_local(&plist, type_to_string(category_to_type(pt->category)));
    }

    char *r = mangle_name(name, plist);
    free_params_local(plist);
    return r;
}


/* Cast de int para double */
int cast_to_double(int reg, enum type t) {
    if (t == type_int) {
        printf("  %%%d = sitofp i32 %%%d to double\n", temporary, reg);
        return temporary++;
    }
    return reg;
}


/* Forward declaration */
static void codegen_statement(struct node *stmt);

/* Conta quantos nodos And/Or existem na sub-arvore. Usado para pre-alocar */
/* todos os slots no entry block do metodo (evita stack overflow em loops) */
static int count_and_or(struct node *n) {
    if (n == NULL) return 0;

    int count = 0;
    if (n->category == And || n->category == Or) count = 1;

    for (struct node_list *curr = n->children; curr != NULL; curr = curr->next) {
        count += count_and_or(curr->node);
    }
    return count;
}


int codegen_expression(struct node *expr) {
    if (expr == NULL) return -1;

    switch(expr->category) {

        /* Literais */
        case Natural: {
            char *clean = strip_underscores(expr->token);
            printf("  %%%d = add i32 0, %s\n", temporary, clean);
            free(clean);
            return temporary++;
        }
        case Decimal: {
            char *clean = strip_underscores(expr->token);
            char *fixed = fix_decimal_format(clean);
            free(clean);
            printf("  %%%d = fadd double 0.0, %s\n", temporary, fixed);
            free(fixed);
            return temporary++;
        }
        case BoolLit: {
            int val = (strcmp(expr->token, "true") == 0) ? 1 : 0;
            printf("  %%%d = add i1 0, %d\n", temporary, val);
            return temporary++;
        }

        /* Identificador (carrega a variavel da memoria) */
        case Id: {
            char *ptr = get_var_ptr(expr->token, expr->type);
            const char *l_type = get_llvm_type(expr->type);
            printf("  %%%d = load %s, %s* %s\n", temporary, l_type, l_type, ptr);
            free(ptr);
            return temporary++;
        }

        /* Atribuicao */
        case Assign: {
            struct node *l_node = getchild(expr, 0);
            struct node *r_node = getchild(expr, 1);

            int r_reg = codegen_expression(r_node);

            /* Se atribuir int a uma variavel double, fazer cast */
            if (l_node->type == type_double && r_node->type == type_int) {
                r_reg = cast_to_double(r_reg, r_node->type);
            }

            char *ptr = get_var_ptr(l_node->token, l_node->type);
            const char *l_type = get_llvm_type(l_node->type);
            printf("  store %s %%%d, %s* %s\n", l_type, r_reg, l_type, ptr);
            free(ptr);

            return r_reg;  /* O valor da atribuicao e o que foi atribuido */
        }

        /* Operacoes aritmeticas */
        case Add: case Sub: case Mul: case Div: case Mod: {
            struct node *l = getchild(expr, 0);
            struct node *r = getchild(expr, 1);
            int rl = codegen_expression(l);
            int rr = codegen_expression(r);

            if (expr->type == type_double) {
                /* Operacao em doubles - fazer cast de int para double se necessario */
                rl = cast_to_double(rl, l->type);
                rr = cast_to_double(rr, r->type);

                if (expr->category == Add) printf("  %%%d = fadd double %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Sub) printf("  %%%d = fsub double %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Mul) printf("  %%%d = fmul double %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Div) printf("  %%%d = fdiv double %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Mod) printf("  %%%d = frem double %%%d, %%%d\n", temporary, rl, rr);
            } else {
                /* Operacao em ints */
                if (expr->category == Add) printf("  %%%d = add i32 %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Sub) printf("  %%%d = sub i32 %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Mul) printf("  %%%d = mul i32 %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Div) printf("  %%%d = sdiv i32 %%%d, %%%d\n", temporary, rl, rr);
                if (expr->category == Mod) printf("  %%%d = srem i32 %%%d, %%%d\n", temporary, rl, rr);
            }
            return temporary++;
        }

        /* Operadores unarios + e - */
        case Plus: case Minus: {
            struct node *l = getchild(expr, 0);
            int rl = codegen_expression(l);

            /* O + nao faz nada, devolve o valor tal e qual */
            if (expr->category == Plus) return rl;

            /* O - multiplica por -1 */
            if (expr->type == type_double) {
                printf("  %%%d = fmul double %%%d, -1.0\n", temporary, rl);
            } else {
                printf("  %%%d = mul i32 %%%d, -1\n", temporary, rl);
            }
            return temporary++;
        }

        /* Operador ! */
        case Not: {
            struct node *l = getchild(expr, 0);
            int rl = codegen_expression(l);
            /* xor com 1 inverte o bit */
            printf("  %%%d = xor i1 %%%d, 1\n", temporary, rl);
            return temporary++;
        }

        /* Comparacoes */
        case Eq: case Ne: case Lt: case Gt: case Le: case Ge: {
            struct node *l = getchild(expr, 0);
            struct node *r = getchild(expr, 1);
            int rl = codegen_expression(l);
            int rr = codegen_expression(r);

            int is_double = (l->type == type_double || r->type == type_double);

            if (is_double) {
                /* Se algum dos operandos for double, fazer comparacao em double */
                rl = cast_to_double(rl, l->type);
                rr = cast_to_double(rr, r->type);

                const char *op = "";
                if (expr->category == Eq) op = "oeq";
                if (expr->category == Ne) op = "one";
                if (expr->category == Lt) op = "olt";
                if (expr->category == Gt) op = "ogt";
                if (expr->category == Le) op = "ole";
                if (expr->category == Ge) op = "oge";
                printf("  %%%d = fcmp %s double %%%d, %%%d\n", temporary, op, rl, rr);
            } else {
                /* Comparacao em ints (ou booleans) */
                const char *op = "";
                if (expr->category == Eq) op = "eq";
                if (expr->category == Ne) op = "ne";
                if (expr->category == Lt) op = "slt";
                if (expr->category == Gt) op = "sgt";
                if (expr->category == Le) op = "sle";
                if (expr->category == Ge) op = "sge";
                const char *l_type = get_llvm_type(l->type);
                printf("  %%%d = icmp %s %s %%%d, %%%d\n", temporary, op, l_type, rl, rr);
            }
            return temporary++;
        }

        /* || com short-circuit */
        /* Se o lado esquerdo for verdade, nao avalia o direito (resultado = true) */
        case Or: {
            struct node *l = getchild(expr, 0);
            struct node *r = getchild(expr, 1);

            int n = label_counter++;
            int res_reg = ao_alloca_base + ao_alloca_next++;  /* slot pre-alocado */

            int rl = codegen_expression(l);
            printf("  br i1 %%%d, label %%Lor_short_%d, label %%Lor_eval_%d\n", rl, n, n);

            /* se o esquerdo foi false, avalia o direito */
            printf("Lor_eval_%d:\n", n);
            int rr = codegen_expression(r);
            printf("  store i1 %%%d, i1* %%%d\n", rr, res_reg);
            printf("  br label %%Lor_end_%d\n", n);

            /* se o esquerdo foi true, atalho - resultado e true */
            printf("Lor_short_%d:\n", n);
            printf("  store i1 1, i1* %%%d\n", res_reg);
            printf("  br label %%Lor_end_%d\n", n);

            /* no fim, le o resultado */
            printf("Lor_end_%d:\n", n);
            int final_reg = temporary++;
            printf("  %%%d = load i1, i1* %%%d\n", final_reg, res_reg);
            return final_reg;
        }

        /* && com short-circuit */
        /* se o lado esquerdo for false, nao avalia o direito (resultado = false) */
        case And: {
            struct node *l = getchild(expr, 0);
            struct node *r = getchild(expr, 1);

            int n = label_counter++;
            int res_reg = ao_alloca_base + ao_alloca_next++;

            int rl = codegen_expression(l);
            printf("  br i1 %%%d, label %%Land_eval_%d, label %%Land_short_%d\n", rl, n, n);

            /* se o esquerdo foi true, avalia o direito */
            printf("Land_eval_%d:\n", n);
            int rr = codegen_expression(r);
            printf("  store i1 %%%d, i1* %%%d\n", rr, res_reg);
            printf("  br label %%Land_end_%d\n", n);

            /* se o esquerdo foi false, atalho - resultado e false */
            printf("Land_short_%d:\n", n);
            printf("  store i1 0, i1* %%%d\n", res_reg);
            printf("  br label %%Land_end_%d\n", n);

            printf("Land_end_%d:\n", n);
            int final_reg = temporary++;
            printf("  %%%d = load i1, i1* %%%d\n", final_reg, res_reg);
            return final_reg;
        }

        /* XOR */
        case Xor: {
            struct node *l = getchild(expr, 0);
            struct node *r = getchild(expr, 1);
            int rl = codegen_expression(l);
            int rr = codegen_expression(r);
            printf("  %%%d = xor %s %%%d, %%%d\n",
                   temporary, get_llvm_type(expr->type), rl, rr);
            return temporary++;
        }

        /* Shifts */
        case Lshift: case Rshift: {
            struct node *l = getchild(expr, 0);
            struct node *r = getchild(expr, 1);
            int rl = codegen_expression(l);
            int rr = codegen_expression(r);

            const char *op;
            if(expr -> category == Lshift) op = "shl";
            else op = "ashr";  /* arithmetic shift right - mantem o sinal */

            printf("  %%%d = %s i32 %%%d, %%%d\n", temporary, op, rl, rr);
            return temporary++;
        }

        /* args.length */
        case Length: {
            struct node *id = getchild(expr, 0);
            printf("  %%%d = load i32, i32* %%.%s_length\n", temporary, id->token);
            return temporary++;
        }

        /* Integer.parseInt(args[i]) */
        case ParseArgs: {
            struct node *id_node = getchild(expr, 0);
            struct node *idx_node = getchild(expr, 1);

            int r_idx = codegen_expression(idx_node);
            char *ptr = get_var_ptr(id_node->token, type_string_array);

            /* Carrega o ponteiro do array */
            printf("  %%%d = load i8**, i8*** %s\n", temporary, ptr);
            int array_ptr = temporary++;

            /* calcula o endereco de args[i] */
            printf("  %%%d = getelementptr inbounds i8*, i8** %%%d, i32 %%%d\n",
                   temporary, array_ptr, r_idx);
            int str_ptr_ptr = temporary++;

            /* carrega o ponteiro da string */
            printf("  %%%d = load i8*, i8** %%%d\n", temporary, str_ptr_ptr);
            int str_ptr = temporary++;

            /* Chama atoi */
            printf("  %%%d = call i32 @atoi(i8* %%%d)\n", temporary, str_ptr);
            free(ptr);
            return temporary++;
        }

        /* Chamada a metodo */
        case Call: {
            struct node *id_node = getchild(expr, 0);
            int num_args = countchildren(expr) - 1;

            int *arg_regs = NULL;
            enum type *arg_types = NULL;
            int *arg_len_regs = NULL;

            /* Avaliar todos os argumentos */
            if (num_args > 0) {
                arg_regs = malloc(num_args * sizeof(int));
                arg_types = malloc(num_args * sizeof(enum type));
                arg_len_regs = malloc(num_args * sizeof(int));

                for (int i = 0; i < num_args; i++) {
                    struct node *arg = getchild(expr, i + 1);
                    arg_regs[i] = codegen_expression(arg);
                    arg_types[i] = arg->type;
                    arg_len_regs[i] = -1;

                    /* se for String[], temos de passar tambem o length como segundo argumento */
                    if (arg->type == type_string_array && arg->category == Id) {
                        printf("  %%%d = load i32, i32* %%.%s_length\n",
                               temporary, arg->token);
                        arg_len_regs[i] = temporary++;
                    }
                }
            }

            /* Procura o metodo certo */
            symbol_entry *target_method = NULL;
            if(gtable != NULL && gtable -> symbols != NULL) {
                /* primeiro tenta match exato (sem precisar de cast) */
                for(symbol_entry *sym = gtable->symbols; sym != NULL; sym = sym -> next) {
                    if(!sym->is_method) continue;
                    if(strcmp(sym->name, id_node->token) != 0) continue;

                    int p_count = 0;
                    for(param_entry *p = sym -> params; p != NULL; p = p -> next) p_count++;
                    if(p_count != num_args) continue;

                    int is_exact = 1;
                    param_entry *p = sym->params;
                    for(int i = 0; i < num_args; i++, p = p -> next){
                        if (arg_types[i] != string_to_type(p -> type_str)) {
                            is_exact = 0;
                        }
                    }
                    if(is_exact) {
                        target_method = sym;
                        break;
                    }
                }

                /* se nao encontrou exato, tenta com cast int->double */
                if(target_method == NULL){
                    for(symbol_entry *sym = gtable -> symbols; sym != NULL; sym = sym -> next) {
                        if(!sym -> is_method) continue;
                        if  (strcmp(sym -> name, id_node -> token) != 0) continue;

                        int p_count = 0;
                        for (param_entry *p = sym -> params; p != NULL; p = p -> next) p_count++;
                        if (p_count != num_args) continue;

                        int is_comp = 1;
                        param_entry *p = sym->params;
                        for (int i = 0; i < num_args; i++, p = p->next) {
                            enum type expected = string_to_type(p->type_str);
                            /* aceita int onde se espera double */
                            if(expected == type_double && arg_types[i] == type_int) continue;
                            if(expected != arg_types[i]) is_comp = 0;
                        }
                        if(is_comp){
                            target_method = sym;
                            break;
                        }
                    }
                }
            }

            /* faz os casts de int para double nos argumentos que precisam */
            if(target_method != NULL){
                param_entry *p = target_method->params;
                for(int i = 0; i < num_args; i++, p = p->next){
                    enum type expected = string_to_type(p -> type_str);
                    if(expected == type_double && arg_types[i] == type_int){
                        arg_regs[i] = cast_to_double(arg_regs[i], type_int);
                        arg_types[i] = type_double;
                    }
                }
            }

            /* constroi a string com os argumentos */
            int call_args_len = num_args * 256 + 1;
            char *call_args = malloc(call_args_len);
            call_args[0] = '\0';

            for (int i = 0; i < num_args; i++) {
                if (i > 0) strcat(call_args, ", ");

                char buf[256];
                sprintf(buf, "%s %%%d", get_llvm_type(arg_types[i]), arg_regs[i]);
                strcat(call_args, buf);

                /* se for String[], adiciona tambem o length */
                if (arg_types[i] == type_string_array
                    && arg_len_regs != NULL
                    && arg_len_regs[i] >= 0)
                {
                    sprintf(buf, ", i32 %%%d", arg_len_regs[i]);
                    strcat(call_args, buf);
                }
            }

            /* determina o nome (mangled ou nao) */
            char *fn_name;
            if(target_method != NULL){
                fn_name = mangle_name(id_node -> token, target_method->params);
            } else {
                fn_name = strdup(id_node->token);
            }

            /* emite a chamada */
            int ret_val = -1;
            const char *ret_t = get_llvm_type(expr->type);
            if (expr->type == type_void) {
                printf("  call void @%s(%s)\n", fn_name, call_args);
            } 
            
            else {
                printf("  %%%d = call %s @%s(%s)\n",
                       temporary, ret_t, fn_name, call_args);
                ret_val = temporary++;
            }

            free(fn_name);
            if (arg_regs)     free(arg_regs);
            if (arg_types)    free(arg_types);
            if (arg_len_regs) free(arg_len_regs);
            free(call_args);

            return ret_val;
        }

        default:
            break;
    }
    return -1;
}


static void codegen_statement(struct node *stmt) {
    if (stmt == NULL) return;

    switch (stmt -> category) {

        case Block: {
            /* apenas processa cada filho do bloco */
            int i = 0;
            struct node *ch;
            while ((ch = getchild(stmt, i++)) != NULL) {
                codegen_statement(ch);
            }
            break;
        }

        case Print: {
            struct node *child = getchild(stmt, 0);

            /* Caso especial: imprimir uma string literal */
            if (child->category == StrLit) {
                int id = get_string_id(child->token);
                int len = get_string_length(child->token);

                printf("  %%%d = call i32 (i8*, ...) @printf("
                       "i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.str, i32 0, i32 0), "
                       "i8* getelementptr inbounds ([%d x i8], [%d x i8]* @.str.%d, i32 0, i32 0))\n",
                       temporary++, len, len, id);
                break;
            }

            /* Caso geral: avaliar a expressao e imprimir conforme o tipo */
            int reg = codegen_expression(child);

            if (child->type == type_int) {
                printf("  %%%d = call i32 (i8*, ...) @printf("
                       "i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.int, i32 0, i32 0), "
                       "i32 %%%d)\n", temporary++, reg);
            }
            else if (child -> type == type_double) {
                printf("  %%%d = call i32 (i8*, ...) @printf("
                       "i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.double, i32 0, i32 0), "
                       "double %%%d)\n", temporary++, reg);
            }
            else if (child->type == type_boolean) {
                /* Para booleans, temos de imprimir "true" ou "false" */
                int l_true  = label_counter++;
                int l_false = label_counter++;
                int l_end   = label_counter++;

                printf("  br i1 %%%d, label %%L%d, label %%L%d\n", reg, l_true, l_false);

                printf("L%d:\n", l_true);
                printf("  %%%d = call i32 (i8*, ...) @printf("
                       "i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.true, i32 0, i32 0))\n",
                       temporary++);
                printf("  br label %%L%d\n", l_end);

                printf("L%d:\n", l_false);
                printf("  %%%d = call i32 (i8*, ...) @printf("
                       "i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.false, i32 0, i32 0))\n",
                       temporary++);
                printf("  br label %%L%d\n", l_end);

                printf("L%d:\n", l_end);
            }
            break;
        }

        case If: {
            struct node *cond      = getchild(stmt, 0);
            struct node *then_stmt = getchild(stmt, 1);
            struct node *else_stmt = getchild(stmt, 2);

            int c_reg = codegen_expression(cond);

            int l_then = label_counter++;
            int l_else = label_counter++;
            int l_end  = label_counter++;

            printf("  br i1 %%%d, label %%L%d, label %%L%d\n", c_reg, l_then, l_else);

            /* Bloco do then */
            printf("L%d:\n", l_then);
            codegen_statement(then_stmt);
            printf("  br label %%L%d\n", l_end);

            /* Bloco do else (pode estar vazio se for um if sem else) */
            printf("L%d:\n", l_else);
            if (else_stmt != NULL) codegen_statement(else_stmt);
            printf("  br label %%L%d\n", l_end);

            /* continuacao */
            printf("L%d:\n", l_end);
            break;
        }

        case While: {
            struct node *cond = getchild(stmt, 0);
            struct node *body = getchild(stmt, 1);

            int l_cond = label_counter++;
            int l_loop = label_counter++;
            int l_end  = label_counter++;

            /* salta para a condicao */
            printf("  br label %%L%d\n", l_cond);

            /* bloco da condicao */
            printf("L%d:\n", l_cond);
            int c_reg = codegen_expression(cond);
            printf("  br i1 %%%d, label %%L%d, label %%L%d\n", c_reg, l_loop, l_end);

            /* borpo do ciclo */
            printf("L%d:\n", l_loop);
            codegen_statement(body);
            printf("  br label %%L%d\n", l_cond);  /* volta a testar a condicao */

            /* Saida do ciclo */
            printf("L%d:\n", l_end);
            break;
        }

        case Return: {
            struct node *ret_expr = getchild(stmt, 0);

            if(ret_expr != NULL){
                int r_reg = codegen_expression(ret_expr);

                if(in_main_entry) {
                    /* O main em LLVM e i32, nao podemos fazer ret void aqui */
                    if (ret_expr->type == type_int)
                        printf("  ret i32 %%%d\n", r_reg);
                    else
                        printf("  ret i32 0\n");
                } else {
                    /* Buscar o tipo de retorno esperado */
                    symbol_entry *ret_sym = NULL;
                    if (current_mt != NULL) {
                        ret_sym = find_symbol(current_mt->symbols, "return");
                    }
                    enum type expected;
                    if (ret_sym != NULL) {
                        expected = string_to_type(ret_sym->type_str);
                    } else {
                        expected = ret_expr->type;
                    }

                    /* Cast int->double se for preciso */
                    if (expected == type_double && ret_expr->type == type_int) {
                        r_reg = cast_to_double(r_reg, ret_expr->type);
                    }
                    printf("  ret %s %%%d\n", get_llvm_type(expected), r_reg);
                }
            } else {
                /* Return sem valor */
                if (in_main_entry) {
                    printf("  ret i32 0\n");
                } else {
                    printf("  ret void\n");
                }
            }

            /* Cria um bloco morto para o que vier depois - (codigo inalcansavel) */
            printf("Ldead%d:\n", label_counter++);
            break;
        }

        /* statements que sao expressoes (atribuicao, chamada, parseInt) */
        case Assign:
        case Call:
        case ParseArgs:
            codegen_expression(stmt);
            break;

        default:
            break;
    }
}


void codegen_parameters(struct node *params_node) {
    int idx = 0;
    struct node *param;

    while ((param = getchild(params_node, idx++)) != NULL) {
        if (idx > 1) printf(", ");

        struct node *type_node = getchild(param, 0);
        struct node *id_node   = getchild(param, 1);
        enum type t = category_to_type(type_node->category);

        /* usamos prefixo .arg_ para nao interferir com nomes de variaveis do utilizador */
        printf("%s %%.arg_%s", get_llvm_type(t), id_node->token);

        /* Para String[] passamos tambem o length como segundo argumento */
        if(t == type_string_array){
            printf(", i32 %%.arg_%s_len", id_node->token);
        }
    }
}


/* construimos a assinatura do metodo (usado para encontrar a method_table certa) */
static char *build_sig_from_ast(const char *name, struct node *params_node) {
    char buf[4096];
    strcpy(buf, name);
    strcat(buf, "(");

    int first = 1, pidx = 0;
    struct node *pd;
    while((pd = getchild(params_node, pidx++)) != NULL){
        if(!first) strcat(buf, ",");
        struct node *pt = getchild(pd, 0);
        strcat(buf, type_to_string(category_to_type(pt->category)));
        first = 0;
    }
    strcat(buf, ")");

    return strdup(buf);
}


void codegen_method(struct node *method) {
    temporary = 1;  /* reset do contador de temporarios para cada metodo */

    struct node *header = getchild(method, 0);
    struct node *body   = getchild(method, 1);

    struct node *type_node   = getchild(header, 0);
    struct node *id_node     = getchild(header, 1);
    struct node *params_node = getchild(header, 2);
    enum type ret_type = category_to_type(type_node->category);

    /* Encontra a method_table correspondente para podermos resolver simbolos locais */
    char *sig = build_sig_from_ast(id_node->token, params_node);
    method_table *mt = gtable->methods;
    while (mt != NULL) {
        if (strcmp(mt->signature, sig) == 0) {
            current_mt = mt;
            break;
        }
        mt = mt->next;
    }
    free(sig);

    /* Verifica se este e o main do programa */
    int is_main_entry = 0;
    struct node *first_param = getchild(params_node, 0);
    if (strcmp(id_node->token, "main") == 0 && first_param != NULL) {
        struct node *fp_type = getchild(first_param, 0);
        if (fp_type != NULL && fp_type->category == StringArray) {
            is_main_entry = 1;
        }
    }

    if (is_main_entry) {
        /* Caso especial: o main com (String[] args) */
        main_generated = 1;
        in_main_entry = 1;

        struct node *args_id = getchild(first_param, 1);
        const char *args_name = args_id->token;

        printf("define i32 @main(i32 %%argc, i8** %%argv) {\n");

        /* setup do args: saltar argv[0] (nome do executavel) */
        printf("  %%.args_base = getelementptr inbounds i8*, i8** %%argv, i32 1\n");
        printf("  %%%s = alloca i8**\n", args_name);
        printf("  store i8** %%.args_base, i8*** %%%s\n", args_name);

        /* args.length e argc - 1 (porque saltamos o nome do executavel) */
        printf("  %%.args_len_val = sub i32 %%argc, 1\n");
        printf("  %%.%s_length = alloca i32\n", args_name);
        printf("  store i32 %%.args_len_val, i32* %%.%s_length\n", args_name);

    } else {
        /* caso geral: metodo normal */
        char *fn_name = mangle_name_from_ast(id_node->token, params_node);
        printf("define %s @%s(", get_llvm_type(ret_type), fn_name);
        free(fn_name);
        codegen_parameters(params_node);
        printf(") {\n");

        /* aloca espaco para os parametros e copia os valores */
        int pidx = 0;
        struct node *param;
        while ((param = getchild(params_node, pidx++)) != NULL) {
            struct node *t_node = getchild(param, 0);
            struct node *i_node = getchild(param, 1);
            enum type pt = category_to_type(t_node->category);
            const char *llvm_t = get_llvm_type(pt);

            printf("  %%%s = alloca %s\n", i_node->token, llvm_t);
            printf("  store %s %%.arg_%s, %s* %%%s\n",
                   llvm_t, i_node->token, llvm_t, i_node->token);

            /* se for String[], guardamos tambem o length*/
            if(pt == type_string_array){
                printf("  %%.%s_length = alloca i32\n", i_node->token);
                printf("  store i32 %%.arg_%s_len, i32* %%.%s_length\n",
                       i_node->token, i_node->token);
            }
        }
    }

    /*emite as allocas de todas as VarDecl no inicio do metodo */
    {
        int bidx = 0;
        struct node *stmt_or_var;
        while((stmt_or_var = getchild(body, bidx++)) != NULL) {
            if (stmt_or_var->category == VarDecl) {
                struct node *t_node = getchild(stmt_or_var, 0);
                struct node *i_node = getchild(stmt_or_var, 1);
                printf("  %%%s = alloca %s\n",
                       i_node->token,
                       get_llvm_type(category_to_type(t_node->category)));
            }
        }
    }

    /*  pre-aloca slots para todos os && e || do metodo. Tem de ser no entry block, */
    /* senao em loops grandes deita o stack abaixo (cada iteracao fazia novo alloca)*/
    ao_alloca_base = temporary;
    ao_alloca_next = 0;
    int ao_count = count_and_or(body);
    for (int i = 0; i < ao_count; i++) {
        printf("  %%%d = alloca i1\n", temporary++);
    }

    /*gera o codigo dos statements (saltando as VarDecl) */
    {
        int bidx = 0;
        struct node *stmt_or_var;
        while((stmt_or_var = getchild(body, bidx++)) != NULL){
            if(stmt_or_var->category != VarDecl){
                codegen_statement(stmt_or_var);
            }
        }
    }

    /* return final por defeito - faz com que a funcao termine sempre */
    /* mesmo que o programa nao tenha return explicito                */
    if (is_main_entry) {
        printf("  ret i32 0\n");
    } else if (ret_type == type_void) {
        printf("  ret void\n");
    } else if (ret_type == type_double) {
        printf("  ret double 0.0\n");
    } else if (ret_type == type_boolean) {
        printf("  ret i1 0\n");
    } else {
        printf("  ret i32 0\n");
    }

    in_main_entry = 0;
    printf("}\n\n");
}


/* Faz uma travessia da AST para coletar todas as strings literais usadas em prints */
void pre_collect_strings(struct node *stmt) {
    if(stmt == NULL) return;

    if(stmt -> category == Print) {
        struct node *child = getchild(stmt, 0);
        if (child != NULL && child->category == StrLit) {
            add_string(child->token);
        }
        return;
    }

    /* para qualquer outro nodo, recurse nos filhos */
    for(struct node_list *curr = stmt->children; curr != NULL; curr = curr->next) {
        pre_collect_strings(curr->node);
    }
}


void codegen_program(struct node *program) {
    if(program == NULL) return;

    /*1-recolhe todas as strings dos metodos */
    {
        int idx = 1;
        struct node *member;
        while ((member = getchild(program, idx++)) != NULL) {
            if (member->category == MethodDecl) {
                pre_collect_strings(member);
            }
        }
    }

    /*2- declaracoes externas - precisamos do printf e do atoi */
    printf("declare i32 @printf(i8*, ...)\n");
    printf("declare i32 @atoi(i8*)\n\n");

    /*3 - format strings para o printf */
    printf("@.str.int = private unnamed_addr constant [3 x i8] c\"%%d\\00\"\n");
    printf("@.str.double = private unnamed_addr constant [6 x i8] c\"%%.16e\\00\"\n");
    printf("@.str.str = private unnamed_addr constant [3 x i8] c\"%%s\\00\"\n");
    printf("@.str.true = private unnamed_addr constant [5 x i8] c\"true\\00\"\n");
    printf("@.str.false = private unnamed_addr constant [6 x i8] c\"false\\00\"\n");

    /* 4 - Constantes para cada string literal usada no programa */
    for (str_entry *curr = str_list; curr != NULL; curr = curr->next) {
        char *c_str = malloc(strlen(curr->token) * 4 + 1);
        c_str[0] = '\0';

        /* Faz a conversao dos escapes do Java para o formato do LLVM IR */
        for (int i = 1; curr->token[i] != '"'; i++) {
            if (curr->token[i] == '\\' && curr->token[i+1] == 'n') {
                strcat(c_str, "\\0A");
                i++;
            } else if (curr->token[i] == '\\' && curr->token[i+1] == 'f') {
                strcat(c_str, "\\0C");
                i++;
            } else if (curr->token[i] == '\\' && curr->token[i+1] == 'r') {
                strcat(c_str, "\\0D");
                i++;
            } else if (curr->token[i] == '\\' && curr->token[i+1] == 't') {
                strcat(c_str, "\\09");
                i++;
            } else if (curr->token[i] == '\\' && curr->token[i+1] == '\\') {
                strcat(c_str, "\\5C");
                i++;
            } else if (curr->token[i] == '\\' && curr->token[i+1] == '"') {
                strcat(c_str, "\\22");
                i++;
            } else {
                /* caracter normal */
                char tmp[2] = { curr->token[i], '\0' };
                strcat(c_str, tmp);
            }
        }

        printf("@.str.%d = private unnamed_addr constant [%d x i8] c\"%s\\00\"\n",
               curr->id, curr->length, c_str);
        free(c_str);
    }
    printf("\n");

    /*5 - Variaveis globais (FieldDecl) */
    {
        int idx = 1;
        struct node *member;
        while ((member = getchild(program, idx++)) != NULL) {
            if (member->category == FieldDecl) {
                struct node *type_node = getchild(member, 0);
                struct node *id_node   = getchild(member, 1);
                enum type t = category_to_type(type_node->category);

                if (t == type_double) {
                    printf("@%s = global double 0.0\n", id_node->token);
                } else if (t == type_boolean) {
                    printf("@%s = global i1 0\n", id_node->token);
                } else {
                    printf("@%s = global i32 0\n", id_node->token);
                }
            }
        }
    }
    printf("\n");

    /* 6 - codigo de cada metodo */
    {
        int idx = 1;
        struct node *member;
        while ((member = getchild(program, idx++)) != NULL) {
            if (member->category == MethodDecl && member->type != type_undef) {
                codegen_method(member);
            }
        }
    }

    /* 7 - Se o programa nao tem main com String[] args, geramos um main vazio */
    /*    para o LLVM nao se queixar                                          */
    if(!main_generated){
        printf("define i32 @main(i32 %%argc, i8** %%argv) {\nentry:\n  ret i32 0\n}\n");
    }
}
