/* João Francisco - 2023228417 */
/* André Ramos - 2023227306 */

%{
#include "y.tab.h"
#include <stdio.h>
#include <string.h>

/* Modo de operação */
int print_tokens = 0;

/* Tracking da posição */
int line = 1;
int col = 1;
int token_line, token_col;

/* Buffer para strings e erros */
char buffer_string[4096];
char error_token[4096]; 
int comprimento_string = 0;
int linha_inicio_string, coluna_inicio_string;
int escape_invalido = 0;

/* Atualizar coluna e guardar token atual */
#define COL_UPDATE() col += yyleng
#define SAVE_POS() do { \
    token_line = line; token_col = col; \
    strcpy(error_token, yytext); \
} while(0)

/* Imprimir token */
#define PRINT_TOKEN(name) if(print_tokens) printf(name "\n")
#define PRINT_TOKEN_VAL(name, val) if(print_tokens) printf(name "(%s)\n", val)
%}

/* Abreviações */
DIGIT       [0-9]
DIGIT_NZ    [1-9]
LETTER      [a-zA-Z_$]
ALNUM       [a-zA-Z0-9_$]

/* Partes númericas */
DIGITS          {DIGIT}({DIGIT}|_)*{DIGIT}|{DIGIT}
EXPONENT        [eE][+-]?{DIGITS}

/* Start conditions */
%x COMMENT
%x STRLIT_STATE

%%
    /* Comentários de linha */
"//"[^\r\n]* { ; }

    /* Comentários de bloco */
"/*"                        { SAVE_POS(); BEGIN(COMMENT); col += yyleng; }
<COMMENT>"*/"               { col += yyleng; BEGIN(INITIAL); }
<COMMENT>\r\n               { line++; col = 1; }
<COMMENT>\r                 { line++; col = 1; }
<COMMENT>\n                 { line++; col = 1; }
<COMMENT>.                  { col++; }
<COMMENT><<EOF>> { 
    printf("Line %d, col %d: unterminated comment\n", token_line, token_col);
    token_line = line;
    token_col = col;
    strcpy(error_token, ""); 
    BEGIN(INITIAL); 
    return 0; 
}

    /* Strings */
"\""                        {
                            SAVE_POS();
                            linha_inicio_string = line;
                            coluna_inicio_string = col;
                            comprimento_string = 0;
                            buffer_string[0] = '\0';
                            escape_invalido = 0;
                            col++;
                            BEGIN(STRLIT_STATE);
                            }
                            
<STRLIT_STATE>"\"" {
    col++;
    BEGIN(INITIAL);
    if(print_tokens && !escape_invalido) {
        buffer_string[comprimento_string] = '\0';
        printf("STRLIT(\"%s\")\n", buffer_string);
    }
    
    if (!escape_invalido) {
        buffer_string[comprimento_string] = '\0';
        char *quoted = malloc(comprimento_string + 3);
        sprintf(quoted, "\"%s\"", buffer_string);
        yylval.lexeme = quoted;
        strcpy(error_token, quoted); 
        return STRLIT;
    }
}

<STRLIT_STATE>\\f                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 'f'; col += 2; }
<STRLIT_STATE>\\n                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 'n'; col += 2; }
<STRLIT_STATE>\\r                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 'r'; col += 2; }
<STRLIT_STATE>\\t                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 't'; col += 2; }
<STRLIT_STATE>\\\\                { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = '\\'; col += 2; }
<STRLIT_STATE>\\\"                { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = '"'; col += 2; }

<STRLIT_STATE>\\[^fnrt\"\\\n\r]   {
                            printf("Line %d, col %d: invalid escape sequence (%s)\n", line, col, yytext);
                            buffer_string[comprimento_string++] = yytext[0];
                            buffer_string[comprimento_string++] = yytext[1];
                            col += 2;
                            escape_invalido = 1;
                            }

<STRLIT_STATE>\\/[\r\n]           {
                            printf("Line %d, col %d: invalid escape sequence (%s)\n", line, col, yytext);
                            buffer_string[comprimento_string++] = yytext[0];
                            col++;
                            }

<STRLIT_STATE>\r\n                {
                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            line++; col = 1;
                            BEGIN(INITIAL);
                            }

<STRLIT_STATE>\n                  {
                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            line++; col = 1;
                            BEGIN(INITIAL);
                            }

<STRLIT_STATE>\r                  {
                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            line++; col = 1;
                            BEGIN(INITIAL);
                            }

<STRLIT_STATE><<EOF>> { 
    printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
    token_line = line;
    token_col = col;
    strcpy(error_token, "");
    BEGIN(INITIAL);
    return 0;
}

<STRLIT_STATE>.                   { buffer_string[comprimento_string++] = yytext[0]; col++; }

    /* Tokens especiais */
"System.out.print"          { SAVE_POS(); PRINT_TOKEN("PRINT"); COL_UPDATE(); return PRINT; }
"Integer.parseInt"          { SAVE_POS(); PRINT_TOKEN("PARSEINT"); COL_UPDATE(); return PARSEINT; }
".length"                   { SAVE_POS(); PRINT_TOKEN("DOTLENGTH"); COL_UPDATE(); return DOTLENGTH; }

    /* Boolean literals */
"true"                      { SAVE_POS(); PRINT_TOKEN_VAL("BOOLLIT", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return BOOLLIT; }
"false"                     { SAVE_POS(); PRINT_TOKEN_VAL("BOOLLIT", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return BOOLLIT; }

    /* Palavras-chave Juc */
"boolean"                   { SAVE_POS(); PRINT_TOKEN("BOOL"); COL_UPDATE(); return BOOL; }
"class"                     { SAVE_POS(); PRINT_TOKEN("CLASS"); COL_UPDATE(); return CLASS; }
"double"                    { SAVE_POS(); PRINT_TOKEN("DOUBLE"); COL_UPDATE(); return DOUBLE; }
"else"                      { SAVE_POS(); PRINT_TOKEN("ELSE"); COL_UPDATE(); return ELSE; }
"if"                        { SAVE_POS(); PRINT_TOKEN("IF"); COL_UPDATE(); return IF; }
"int"                       { SAVE_POS(); PRINT_TOKEN("INT"); COL_UPDATE(); return INT; }
"public"                    { SAVE_POS(); PRINT_TOKEN("PUBLIC"); COL_UPDATE(); return PUBLIC; }
"return"                    { SAVE_POS(); PRINT_TOKEN("RETURN"); COL_UPDATE(); return RETURN; }
"static"                    { SAVE_POS(); PRINT_TOKEN("STATIC"); COL_UPDATE(); return STATIC; }
"String"                    { SAVE_POS(); PRINT_TOKEN("STRING"); COL_UPDATE(); return STRING; }
"void"                      { SAVE_POS(); PRINT_TOKEN("VOID"); COL_UPDATE(); return VOID; }
"while"                     { SAVE_POS(); PRINT_TOKEN("WHILE"); COL_UPDATE(); return WHILE; }

    /* RESERVED */
"++"                        { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"--"                        { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"null"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"Integer"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"System"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"abstract"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"assert"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"break"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"byte"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"case"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"catch"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"char"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"const"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"continue"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"default"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"do"                        { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"enum"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"extends"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"final"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"finally"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"float"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"for"                       { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"goto"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"implements"                { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"import"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"instanceof"                { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"interface"                 { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"long"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"native"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"new"                       { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"package"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"private"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"protected"                 { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"short"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"strictfp"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"super"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"switch"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"synchronized"              { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"this"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"throw"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"throws"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"transient"                 { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"try"                       { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
"volatile"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); return RESERVED; }
    
    /* Operadores multi-carácter */
"&&"                        { SAVE_POS(); PRINT_TOKEN("AND"); COL_UPDATE(); return AND; }
"||"                        { SAVE_POS(); PRINT_TOKEN("OR"); COL_UPDATE(); return OR; }
"=="                        { SAVE_POS(); PRINT_TOKEN("EQ"); COL_UPDATE(); return EQ; }
"!="                        { SAVE_POS(); PRINT_TOKEN("NE"); COL_UPDATE(); return NE; }
">="                        { SAVE_POS(); PRINT_TOKEN("GE"); COL_UPDATE(); return GE; }
"<="                        { SAVE_POS(); PRINT_TOKEN("LE"); COL_UPDATE(); return LE; }
"<<"                        { SAVE_POS(); PRINT_TOKEN("LSHIFT"); COL_UPDATE(); return LSHIFT; }
">>"                        { SAVE_POS(); PRINT_TOKEN("RSHIFT"); COL_UPDATE(); return RSHIFT; }
"->"                        { SAVE_POS(); PRINT_TOKEN("ARROW"); COL_UPDATE(); return ARROW; }

    /* Operadores simples */
"="                         { SAVE_POS(); PRINT_TOKEN("ASSIGN"); COL_UPDATE(); return ASSIGN; }
"+"                         { SAVE_POS(); PRINT_TOKEN("PLUS"); COL_UPDATE(); return PLUS; }
"-"                         { SAVE_POS(); PRINT_TOKEN("MINUS"); COL_UPDATE(); return MINUS; }
"*"                         { SAVE_POS(); PRINT_TOKEN("STAR"); COL_UPDATE(); return STAR; }
"/"                         { SAVE_POS(); PRINT_TOKEN("DIV"); COL_UPDATE(); return DIV; }
"%"                         { SAVE_POS(); PRINT_TOKEN("MOD"); COL_UPDATE(); return MOD; }
"!"                         { SAVE_POS(); PRINT_TOKEN("NOT"); COL_UPDATE(); return NOT; }
">"                         { SAVE_POS(); PRINT_TOKEN("GT"); COL_UPDATE(); return GT; }
"<"                         { SAVE_POS(); PRINT_TOKEN("LT"); COL_UPDATE(); return LT; }
"^"                         { SAVE_POS(); PRINT_TOKEN("XOR"); COL_UPDATE(); return XOR; }

    /* Delimitadores */
"{"                         { SAVE_POS(); PRINT_TOKEN("LBRACE"); COL_UPDATE(); return LBRACE; }
"}"                         { SAVE_POS(); PRINT_TOKEN("RBRACE"); COL_UPDATE(); return RBRACE; }
"("                         { SAVE_POS(); PRINT_TOKEN("LPAR"); COL_UPDATE(); return LPAR; }
")"                         { SAVE_POS(); PRINT_TOKEN("RPAR"); COL_UPDATE(); return RPAR; }
"["                         { SAVE_POS(); PRINT_TOKEN("LSQ"); COL_UPDATE(); return LSQ; }
"]"                         { SAVE_POS(); PRINT_TOKEN("RSQ"); COL_UPDATE(); return RSQ; }
";"                         { SAVE_POS(); PRINT_TOKEN("SEMICOLON"); COL_UPDATE(); return SEMICOLON; }
","                         { SAVE_POS(); PRINT_TOKEN("COMMA"); COL_UPDATE(); return COMMA; }

    /* Decimais */
{DIGITS}"."{DIGITS}{EXPONENT}?    { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return DECIMAL; }
{DIGITS}"."{EXPONENT}             { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return DECIMAL; }
"."{DIGITS}{EXPONENT}?            { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return DECIMAL; }
{DIGITS}"."                       { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return DECIMAL; }
{DIGITS}{EXPONENT}                { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return DECIMAL; }

    /* NATURAIS */
0                                 { SAVE_POS(); PRINT_TOKEN_VAL("NATURAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return NATURAL; }
{DIGIT_NZ}({DIGIT}|_)*{DIGIT}     { SAVE_POS(); PRINT_TOKEN_VAL("NATURAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return NATURAL; }
{DIGIT_NZ}                        { SAVE_POS(); PRINT_TOKEN_VAL("NATURAL", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return NATURAL; }

    /* Identifier */
{LETTER}{ALNUM}* { SAVE_POS(); PRINT_TOKEN_VAL("IDENTIFIER", yytext); COL_UPDATE(); yylval.lexeme = strdup(yytext); return IDENTIFIER; }

    /* Espaços em branco e erros */
" "                         { col++; }
\t                          { col++; }
\f                          { col++; }
\r\n                        { line++; col = 1; }
\r                          { line++; col = 1; }
\n                          { line++; col = 1; }

.                           { printf("Line %d, col %d: illegal character (%s)\n", line, col, yytext); col++; }
<<EOF>> { 
    token_line = line; 
    token_col = col; 
    strcpy(error_token, ""); 
    return 0; 
}

%%

int yywrap() {
    return 1;
}