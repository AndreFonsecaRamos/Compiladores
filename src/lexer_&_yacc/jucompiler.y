/* João Francisco - 2023228417 */
/* André Ramos - 2023227306 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"
#include "semantics.h"

int yylex(void);
void yyerror(char *s);

extern int print_tokens;
extern int token_line, token_col; 
extern char* yytext;
int flag_l = 0;
int flag_e1 = 0;
int flag_t = 0;
int flag_s = 0;

struct node *ast_root;
int num_errors = 0;
%}

%union {
    char *lexeme;
    struct node *node;
}

%locations

%token <lexeme> IDENTIFIER NATURAL DECIMAL STRLIT BOOLLIT

%token CLASS PUBLIC STATIC
%token PRINT PARSEINT DOTLENGTH
%token BOOL DOUBLE ELSE IF INT RETURN STRING VOID WHILE
%token RESERVED
%token AND OR EQ NE GE LE LSHIFT RSHIFT ARROW
%token ASSIGN PLUS MINUS STAR DIV MOD NOT GT LT XOR
%token LBRACE RBRACE LPAR RPAR LSQ RSQ SEMICOLON COMMA

%type <node> Program DeclList MethodDecl FieldDecl MethodHeader FormalParams FormalParamsList 
%type <node> MethodBody MethodBodyContent Type VarDecl FieldIDList
%type <node> Statement StatementList Assignment MethodInvocation ExprList ParseArgs Expr Expr1

%nonassoc NO_ELSE
%nonassoc ELSE

%right ASSIGN
%left OR
%left AND
%left XOR
%left EQ NE
%left LT GT LE GE
%left LSHIFT RSHIFT
%left PLUS MINUS
%left STAR DIV MOD

%right NOT UNARY_MINUS UNARY_PLUS

%%

Program: 
    CLASS IDENTIFIER LBRACE DeclList RBRACE {
        ast_root = newnode(Program, NULL);
        addchild(ast_root, newnode(Id, $2));
        if ($4 != NULL) {
            struct node_list *current = $4->children;
            while (current != NULL) {
                addchild(ast_root, current->node);
                current = current->next;
            }
        }
    }
    | CLASS IDENTIFIER LBRACE RBRACE {
        ast_root = newnode(Program, NULL);
        addchild(ast_root, newnode(Id, $2));
    }
    ;

DeclList: 
    DeclList MethodDecl {
        if ($1 == NULL) $$ = newnode(Program, NULL);
        else $$ = $1;
        addchild($$, $2);
    }
    | DeclList FieldDecl {
        if ($1 == NULL) $$ = newnode(Program, NULL);
        else $$ = $1;
        if ($2 != NULL) {
            struct node_list *current = $2->children;
            while (current != NULL) {
                addchild($$, current->node);
                current = current->next;
            }
        }
    }
    | DeclList SEMICOLON { $$ = $1; }
    | MethodDecl {
        $$ = newnode(Program, NULL);
        addchild($$, $1);
    }
    | FieldDecl {
        $$ = newnode(Program, NULL);
        if ($1 != NULL) {
            struct node_list *current = $1->children;
            while (current != NULL) {
                addchild($$, current->node);
                current = current->next;
            }
        }
    }
    | SEMICOLON { $$ = NULL; }
    ;

MethodDecl: 
    PUBLIC STATIC MethodHeader MethodBody {
        $$ = newnode(MethodDecl, NULL);
        addchild($$, $3);
        addchild($$, $4);
    }
    ;

MethodHeader: 
    Type IDENTIFIER LPAR FormalParams RPAR {
        $$ = newnode(MethodHeader, NULL);
        addchild($$, $1);
        struct node *id_node = newnode(Id, $2);
        id_node->line = @2.first_line;
        id_node->col = @2.first_column;
        addchild($$, id_node);
        addchild($$, $4);
    }
    | VOID IDENTIFIER LPAR FormalParams RPAR {
        $$ = newnode(MethodHeader, NULL);
        addchild($$, newnode(Void, NULL));
        struct node *id_node = newnode(Id, $2);
        id_node->line = @2.first_line;
        id_node->col = @2.first_column;
        addchild($$, id_node);
        addchild($$, $4);
    }
    | Type IDENTIFIER LPAR RPAR { 
        $$ = newnode(MethodHeader, NULL); 
        $$->line = @1.first_line; $$->col = @1.first_column;
        addchild($$, $1);
        struct node *id_node = newnode(Id, $2);
        id_node->line = @2.first_line;
        id_node->col = @2.first_column;
        addchild($$, id_node);
        addchild($$, newnode(MethodParams, NULL));
    }
    | VOID IDENTIFIER LPAR RPAR { 
        $$ = newnode(MethodHeader, NULL); 
        $$->line = @1.first_line; $$->col = @1.first_column;
        addchild($$, newnode(Void, NULL));
        struct node *id_node = newnode(Id, $2);
        id_node->line = @2.first_line;
        id_node->col = @2.first_column;
        addchild($$, id_node);
        addchild($$, newnode(MethodParams, NULL));
    }
    ;

FormalParams: 
    Type IDENTIFIER FormalParamsList {
        $$ = newnode(MethodParams, NULL);
        struct node *param = newnode(ParamDecl, NULL);
        addchild(param, $1);
        struct node *id_node = newnode(Id, $2);
        id_node->line = @2.first_line;
        id_node->col = @2.first_column;
        addchild(param, id_node);
        addchild($$, param);
        if ($3 != NULL) {
            struct node_list *current = $3->children;
            while (current != NULL) {
                addchild($$, current->node);
                current = current->next;
            }
        }
    }
    | STRING LSQ RSQ IDENTIFIER {
        $$ = newnode(MethodParams, NULL);
        struct node *param = newnode(ParamDecl, NULL);
        addchild(param, newnode(StringArray, NULL));
        struct node *id_node = newnode(Id, $4);
        id_node->line = @4.first_line;
        id_node->col = @4.first_column;
        addchild(param, id_node);
        addchild($$, param);
    }
    ;

FormalParamsList: 
    FormalParamsList COMMA Type IDENTIFIER {
        if ($1 == NULL) $$ = newnode(Program, NULL);
        else $$ = $1;
        struct node *param = newnode(ParamDecl, NULL);
        addchild(param, $3);
        struct node *id_node = newnode(Id, $4);
        id_node->line = @4.first_line;
        id_node->col = @4.first_column;
        addchild(param, id_node);
        addchild($$, param);
    }
    | { $$ = NULL; }
    ;

MethodBody: 
    LBRACE MethodBodyContent RBRACE {
        $$ = newnode(MethodBody, NULL);
        if ($2 != NULL) {
            struct node_list *current = $2->children;
            while (current != NULL) {
                addchild($$, current->node);
                current = current->next;
            }
        }
    }
    ;

MethodBodyContent: 
    { $$ = NULL; }
    | MethodBodyContent Statement {
        if ($1 == NULL) $$ = newnode(Program, NULL); 
        else $$ = $1;
        if ($2 != NULL) addchild($$, $2); 
    }
    | MethodBodyContent VarDecl {
        if ($1 == NULL) $$ = newnode(Program, NULL); 
        else $$ = $1;
        if ($2 != NULL) {
            struct node_list *current = $2->children;
            while (current != NULL) {
                addchild($$, current->node);
                current = current->next;
            }
        }
    }
    ;

FieldDecl: 
    PUBLIC STATIC Type IDENTIFIER FieldIDList SEMICOLON {
        $$ = newnode(Program, NULL); 
        struct node *first_field = newnode(FieldDecl, NULL);
        addchild(first_field, $3); 
        
        struct node *id_node = newnode(Id, $4);
        id_node->line = @4.first_line;
        id_node->col = @4.first_column;
        addchild(first_field, id_node);
        
        addchild($$, first_field);
        
        if ($5 != NULL) {
            struct node_list *current = $5->children;
            while (current != NULL) {
                struct node *extra_field = newnode(FieldDecl, NULL);
                addchild(extra_field, newnode($3->category, NULL)); 
                addchild(extra_field, current->node); 
                addchild($$, extra_field);
                current = current->next;
            }
        }
    }
    | error SEMICOLON { $$ = NULL; num_errors++; } 
    ;

VarDecl: 
    Type IDENTIFIER FieldIDList SEMICOLON {
        $$ = newnode(Program, NULL); 
        struct node *first_var = newnode(VarDecl, NULL);
        addchild(first_var, $1);
        
        struct node *id_node = newnode(Id, $2);
        id_node->line = @2.first_line;
        id_node->col = @2.first_column;
        addchild(first_var, id_node);
        
        addchild($$, first_var);
        
        if ($3 != NULL) {
            struct node_list *current = $3->children;
            while (current != NULL) {
                struct node *extra_var = newnode(VarDecl, NULL);
                addchild(extra_var, newnode($1->category, NULL)); 
                addchild(extra_var, current->node); 
                addchild($$, extra_var);
                current = current->next;
            }
        }
    }
    ;

FieldIDList: 
    FieldIDList COMMA IDENTIFIER {
        if ($1 == NULL) $$ = newnode(Program, NULL);
        else $$ = $1;
        
        struct node *id_node = newnode(Id, $3);
        id_node->line = @3.first_line;
        id_node->col = @3.first_column;
        addchild($$, id_node); 
    }
    | { $$ = NULL; }
    ;

Type: 
    BOOL     { $$ = newnode(Bool, NULL); }
    | INT    { $$ = newnode(Int, NULL); }
    | DOUBLE { $$ = newnode(Double, NULL); }
    ;

Statement: 
    LBRACE StatementList RBRACE { 
        $$ = create_block_node($2); 
    }
    | IF LPAR Expr RPAR Statement %prec NO_ELSE {
        $$ = newnode(If, NULL);
        addchild($$, $3); 
        if ($5 != NULL) addchild($$, $5);
        else addchild($$, newnode(Block, NULL));
        addchild($$, newnode(Block, NULL));
    }
    | IF LPAR Expr RPAR Statement ELSE Statement {
        $$ = newnode(If, NULL);
        addchild($$, $3); 
        if ($5 != NULL) addchild($$, $5); 
        else addchild($$, newnode(Block, NULL)); 
        if ($7 != NULL) addchild($$, $7); 
        else addchild($$, newnode(Block, NULL)); 
    }
    | WHILE LPAR Expr RPAR Statement {
        $$ = newnode(While, NULL);
        addchild($$, $3); 
        if ($5 != NULL) addchild($$, $5); 
        else addchild($$, newnode(Block, NULL)); 
    }
    | RETURN Expr SEMICOLON { $$ = newnode(Return, NULL); $$->line = @1.first_line; $$->col = @1.first_column;
        addchild($$, $2);
    }
    | RETURN SEMICOLON { $$ = newnode(Return, NULL); $$->line = @1.first_line; $$->col = @1.first_column; }
    | MethodInvocation SEMICOLON { $$ = $1; }
    | Assignment SEMICOLON { $$ = $1; }
    | ParseArgs SEMICOLON { $$ = $1; }
    | SEMICOLON { $$ = NULL; }
    | PRINT LPAR Expr RPAR SEMICOLON {
        $$ = newnode(Print, NULL);
        addchild($$, $3);
    }
    | PRINT LPAR STRLIT RPAR SEMICOLON {
        $$ = newnode(Print, NULL);
        addchild($$, newnode(StrLit, $3));
    }
    | error SEMICOLON { $$ = NULL; num_errors++; } 
    ;

StatementList: 
    { $$ = NULL; }
    | StatementList Statement { 
        if ($1 == NULL) {
            $$ = newnode(Program, NULL); 
            if ($2 != NULL) addchild($$, $2);
        } else {
            if ($2 != NULL) addchild($1, $2);
            $$ = $1;
        }
    }
    ;

Assignment: 
    IDENTIFIER ASSIGN Expr { 
        $$ = newnode(Assign, NULL); 
        $$->line = @2.first_line;  
        $$->col = @2.first_column; 
        
        struct node *id_node = newnode(Id, $1);
        id_node->line = @1.first_line; 
        id_node->col = @1.first_column;
        
        addchild($$, id_node); 
        addchild($$, $3); 
    }
    ;

MethodInvocation: 
    IDENTIFIER LPAR ExprList RPAR { 
        struct node *id_node = newnode(Id, $1); 
        id_node->line = @1.first_line; id_node->col = @1.first_column; 
        $$ = newnode(Call, NULL); $$->line = @1.first_line; $$->col = @1.first_column; addchild($$, id_node); 
        if ($3 != NULL) {
            struct node_list *current = $3->children;
            while (current != NULL) {
                addchild($$, current->node);
                current = current->next;
            }
        }
    }
    | IDENTIFIER LPAR RPAR { 
        struct node *id_node = newnode(Id, $1); 
        id_node->line = @1.first_line; id_node->col = @1.first_column; 
        $$ = newnode(Call, NULL); $$->line = @1.first_line; $$->col = @1.first_column; addchild($$, id_node); 
    }
    | IDENTIFIER LPAR error RPAR { $$ = NULL; num_errors++; }
    ;

ExprList: 
    ExprList COMMA Expr { 
        addchild($1, $3); 
        $$ = $1; 
    }
    | Expr { 
        $$ = newnode(Program, NULL);
        addchild($$, $1); 
    }
    ;

ParseArgs: 
    PARSEINT LPAR IDENTIFIER LSQ Expr RSQ RPAR { 
        $$ = newnode(ParseArgs, NULL); 
        $$->line = @1.first_line;      
        $$->col = @1.first_column; 
        
        struct node *id_node = newnode(Id, $3); 
        id_node->line = @3.first_line; 
        id_node->col = @3.first_column;
        
        addchild($$, id_node); 
        addchild($$, $5); 
    }
    | PARSEINT LPAR error RPAR { $$ = NULL; num_errors++; }
    ;

Expr: 
    Assignment { $$ = $1; }
    | Expr1 { $$ = $1; }
    ;

Expr1: 
    Expr1 PLUS Expr1 { $$ = newnode(Add, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 MINUS Expr1 { $$ = newnode(Sub, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 STAR Expr1 { $$ = newnode(Mul, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 DIV Expr1 { $$ = newnode(Div, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 MOD Expr1 { $$ = newnode(Mod, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 AND Expr1 { $$ = newnode(And, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 OR Expr1 { $$ = newnode(Or, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 XOR Expr1 { $$ = newnode(Xor, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 LSHIFT Expr1 { $$ = newnode(Lshift, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 RSHIFT Expr1 { $$ = newnode(Rshift, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 EQ Expr1 { $$ = newnode(Eq, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 GE Expr1 { $$ = newnode(Ge, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 GT Expr1 { $$ = newnode(Gt, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 LE Expr1 { $$ = newnode(Le, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 LT Expr1 { $$ = newnode(Lt, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    | Expr1 NE Expr1 { $$ = newnode(Ne, NULL); $$->line = @2.first_line; $$->col = @2.first_column; addchild($$, $1); addchild($$, $3); }
    
    | MINUS Expr1 %prec UNARY_MINUS { $$ = newnode(Minus, NULL); $$->line = @1.first_line; $$->col = @1.first_column; addchild($$, $2); }
    | PLUS Expr1 %prec UNARY_PLUS { $$ = newnode(Plus, NULL); $$->line = @1.first_line; $$->col = @1.first_column; addchild($$, $2); }
    | NOT Expr1 { $$ = newnode(Not, NULL); $$->line = @1.first_line; $$->col = @1.first_column; addchild($$, $2); }
    
    | LPAR Expr RPAR               { $$ = $2; }
    | LPAR error RPAR { $$ = NULL; num_errors++; }
    
    | MethodInvocation             { $$ = $1; }
    | ParseArgs                    { $$ = $1; }
    
    | IDENTIFIER DOTLENGTH { 
        $$ = newnode(Length, NULL); 
        $$->line = @2.first_line;       
        $$->col = @2.first_column; 
        
        struct node *id_node = newnode(Id, $1);
        id_node->line = @1.first_line; 
        id_node->col = @1.first_column;
        
        addchild($$, id_node); 
    }
    
    | IDENTIFIER { $$ = newnode(Id, $1); $$->line = @1.first_line; $$->col = @1.first_column; }
    | NATURAL { $$ = newnode(Natural, $1); $$->line = @1.first_line; $$->col = @1.first_column; }
    | DECIMAL { $$ = newnode(Decimal, $1); $$->line = @1.first_line; $$->col = @1.first_column; }
    | BOOLLIT { $$ = newnode(BoolLit, $1); $$->line = @1.first_line; $$->col = @1.first_column; }
    ;

%%

int main(int argc, char *argv[]) {

    for (int i = 1; i < argc; i++){
        if (strcmp(argv[i], "-l") == 0){
            flag_l = 1;
            print_tokens = 1;
        } 
        else if (strcmp(argv[i], "-e1") == 0){
            flag_e1 = 1;
            print_tokens = 0;
        }
        else if (strcmp(argv[i], "-t") == 0){
            flag_t = 1;
        }
        else if (strcmp(argv[i], "-s") == 0){
            flag_s = 1;
        }
    }
    
    if (flag_l || flag_e1){
        while(yylex());
    } 
    else {
        yyparse();
        if (num_errors == 0) {
            int run_semantics = 0;
            for (int i = 1; i < argc; i++) {
                if (strcmp(argv[i], "-s") == 0 || strcmp(argv[i], "-e3") == 0) {
                            run_semantics = 1;
                }
            }

            if (run_semantics) {
                semantic_analysis(ast_root);
                if (flag_s) {
                    print_tables();
                    printf("\n"); 
                    show_annotated(ast_root, 0);
                }
            } else if (flag_t) {
                print_ast(ast_root, 0);
            }
        }
    }
    return 0;
}

extern char error_token[]; 
extern char buffer_string[];

void yyerror(char *s) {
    num_errors++;

    if (strcmp(error_token, "") == 0) {
        printf("Line %d, col %d: %s: \n", token_line, token_col, s);
    } else if (strcmp(error_token, "\"") == 0) {
        printf("Line %d, col %d: %s: \"%s\"\n", token_line, token_col, s, buffer_string);
    } else {
        printf("Line %d, col %d: %s: %s\n", token_line, token_col, s, error_token);
    }
}