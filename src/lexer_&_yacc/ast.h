#ifndef _AST_H
#define _AST_H

enum category { 
    Program, MethodDecl, FieldDecl, MethodHeader, ParamDecl, MethodParams, MethodBody,
    Assign, Or, And, Eq, Ne, Lt, Gt, Le, Ge, Add, Sub, Mul, Div, Mod, Not, Minus, Plus,
    Xor, Lshift, Rshift,
    Call, ParseArgs, Length, Return, If, While, Print, Block, VarDecl,
    Id, Bool, Double, Int, Void, StringArray, Natural, Decimal, BoolLit, StrLit
};

struct node {
    enum category category;
    char *token;
    struct node_list *children;
};

struct node_list {
    struct node *node;
    struct node_list *next;
};

extern const char *category_names[];

struct node *newnode(enum category category, char *token);
void addchild(struct node *parent, struct node *child);
struct node *create_block_node(struct node *statement_list);
void print_ast(struct node *current, int depth);

#endif