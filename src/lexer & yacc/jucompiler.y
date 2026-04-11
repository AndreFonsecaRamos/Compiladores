/* João Francisco - 2023228417 */
/* André Ramos - 2023227306 */

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(char *s);

extern int print_tokens;

/* Tracking da posição e flags */

extern int token_line, token_col; 
extern char* yytext;
int flag_l = 0;
int flag_e1 = 0;

%}

%token CLASS PUBLIC STATIC
%token PRINT PARSEINT DOTLENGTH
%token BOOLLIT BOOL DOUBLE ELSE IF INT RETURN STRING VOID WHILE
%token RESERVED
%token AND OR EQ NE GE LE LSHIFT RSHIFT ARROW
%token ASSIGN PLUS MINUS STAR DIV MOD NOT GT LT XOR
%token LBRACE RBRACE LPAR RPAR LSQ RSQ SEMICOLON COMMA
%token DECIMAL NATURAL IDENTIFIER STRLIT

/* Precedência de operadores */

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

/* Principal */

Program: CLASS IDENTIFIER LBRACE DeclList RBRACE
       | CLASS IDENTIFIER LBRACE RBRACE
       ;

DeclList: DeclList MethodDecl
        | DeclList FieldDecl
        | DeclList SEMICOLON
        | MethodDecl
        | FieldDecl
        | SEMICOLON
        ;

/* Métodos */

MethodDecl: PUBLIC STATIC MethodHeader MethodBody
          ;

MethodHeader: Type IDENTIFIER LPAR FormalParams RPAR
            | VOID IDENTIFIER LPAR FormalParams RPAR
            | Type IDENTIFIER LPAR RPAR
            | VOID IDENTIFIER LPAR RPAR
            ;

FormalParams: Type IDENTIFIER FormalParamsList
            | STRING LSQ RSQ IDENTIFIER
            ;

FormalParamsList: FormalParamsList COMMA Type IDENTIFIER
                | 
                ;

MethodBody: LBRACE MethodBodyContent RBRACE
          ;

MethodBodyContent: 
                 | MethodBodyContent Statement
                 | MethodBodyContent VarDecl
                 ;

/* Variáveis de classe e locais */

FieldDecl: PUBLIC STATIC Type IDENTIFIER FieldIDList SEMICOLON
         | error SEMICOLON
         ;

VarDecl: Type IDENTIFIER FieldIDList SEMICOLON
       ;

FieldIDList: FieldIDList COMMA IDENTIFIER
           |
           ;

Type: BOOL
    | INT
    | DOUBLE
    ;

/* Statments */

Statement: LBRACE StatementList RBRACE
         | IF LPAR Expr RPAR Statement %prec NO_ELSE
         | IF LPAR Expr RPAR Statement ELSE Statement
         | WHILE LPAR Expr RPAR Statement
         | RETURN Expr SEMICOLON
         | RETURN SEMICOLON
         | MethodInvocation SEMICOLON
         | Assignment SEMICOLON
         | ParseArgs SEMICOLON
         | SEMICOLON
         | PRINT LPAR Expr RPAR SEMICOLON
         | PRINT LPAR STRLIT RPAR SEMICOLON
         | error SEMICOLON
         ;

StatementList:
             | StatementList Statement
             ;

/* Atribuições, Invocações e Expressões Base */

Assignment: IDENTIFIER ASSIGN Expr
          ;

MethodInvocation: IDENTIFIER LPAR ExprList RPAR
                | IDENTIFIER LPAR RPAR
                | IDENTIFIER LPAR error RPAR
                ;

ExprList: ExprList COMMA Expr
        | Expr
        ;

ParseArgs: PARSEINT LPAR IDENTIFIER LSQ Expr RSQ RPAR
         | PARSEINT LPAR error RPAR
         ;

Expr: Expr PLUS Expr
    | Expr MINUS Expr
    | Expr STAR Expr
    | Expr DIV Expr
    | Expr MOD Expr
    | Expr AND Expr
    | Expr OR Expr
    | Expr XOR Expr
    | Expr LSHIFT Expr
    | Expr RSHIFT Expr
    | Expr EQ Expr
    | Expr GE Expr
    | Expr GT Expr
    | Expr LE Expr
    | Expr LT Expr
    | Expr NE Expr
    | MINUS Expr %prec UNARY_MINUS
    | PLUS Expr %prec UNARY_PLUS
    | NOT Expr
    | LPAR Expr RPAR
    | LPAR error RPAR
    | MethodInvocation
    | Assignment
    | ParseArgs
    | IDENTIFIER DOTLENGTH
    | IDENTIFIER
    | NATURAL
    | DECIMAL
    | BOOLLIT
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
    }
    
    if (flag_l || flag_e1){
        while(yylex());

    } 
    
    else {
        yyparse();
    }
    
    return 0;
}

void yyerror(char *s) {
    printf("Line %d, col %d: %s: %s\n", token_line, token_col, s, yytext);
}