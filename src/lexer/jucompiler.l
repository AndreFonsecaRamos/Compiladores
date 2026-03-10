/* João Francisco - 2023228417 */

%{
#include <stdio.h>
#include <string.h>

/* Modo de operação */

int print_tokens = 0;

/* Tracking da posição */

int line = 1;
int col = 1;
int token_line, token_col;

/* Buffer para strings */

char buffer_string[4096];
int comprimento_string = 0;
int linha_inicio_string, coluna_inicio_string;
int escape_invalido = 0;

/* Atualizar coluna */

#define COL_UPDATE() col += yyleng
#define SAVE_POS() token_line = line; token_col = col

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
%x STRLIT

%%
    /* Comentários de linha */

"//"[^\r\n]*                { ; }

    /* Comentários de bloco */

"/*"                        { SAVE_POS(); BEGIN(COMMENT); col += yyleng; }
<COMMENT>"*/"               { col += yyleng; BEGIN(INITIAL); }
<COMMENT>\r\n               { line++; col = 1; }
<COMMENT>\r                 { line++; col = 1; }
<COMMENT>\n                 { line++; col = 1; }
<COMMENT>.                  { col++; }
<COMMENT><<EOF>>            { printf("Line %d, col %d: unterminated comment\n", token_line, token_col); BEGIN(INITIAL); return 0; }

    /* Strings */

"\""                        {

                            SAVE_POS();
                            linha_inicio_string = line;
                            coluna_inicio_string = col;
                            comprimento_string = 0;
                            buffer_string[0] = '\0';
                            escape_invalido = 0;
                            col++;
                            BEGIN(STRLIT);

                            }
<STRLIT>"\""                {

                            col++;
                            BEGIN(INITIAL);
                            if(print_tokens && !escape_invalido) {
                                buffer_string[comprimento_string] = '\0';
                                printf("STRLIT(\"%s\")\n", buffer_string);
                            }

                            }

<STRLIT>\\f                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 'f'; col += 2; }
<STRLIT>\\n                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 'n'; col += 2; }
<STRLIT>\\r                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 'r'; col += 2; }
<STRLIT>\\t                 { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = 't'; col += 2; }
<STRLIT>\\\\                { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = '\\'; col += 2; }
<STRLIT>\\\"                { buffer_string[comprimento_string++] = '\\'; buffer_string[comprimento_string++] = '"'; col += 2; }

<STRLIT>\\[^fnrt\"\\\n\r]   {

                            printf("Line %d, col %d: invalid escape sequence (%s)\n", line, col, yytext);
                            buffer_string[comprimento_string++] = yytext[0];
                            buffer_string[comprimento_string++] = yytext[1];
                            col += 2;
                            escape_invalido = 1;

                            }

<STRLIT>\\/[\r\n]           {

                            printf("Line %d, col %d: invalid escape sequence (%s)\n", line, col, yytext);
                            buffer_string[comprimento_string++] = yytext[0];
                            col++;

                            }

<STRLIT>\r\n                {

                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            line++; col = 1;
                            BEGIN(INITIAL);

                            }

<STRLIT>\n                  {

                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            line++; col = 1;
                            BEGIN(INITIAL);

                            }

<STRLIT>\r                  {

                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            line++; col = 1;
                            BEGIN(INITIAL);

                            }

<STRLIT><<EOF>>             {

                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            BEGIN(INITIAL);
                            return 0;

                            }

<STRLIT>.                   { buffer_string[comprimento_string++] = yytext[0]; col++; }

    /* Tokens especiais (ANTES de IDENTIFIER) */

"System.out.print"          { SAVE_POS(); PRINT_TOKEN("PRINT"); COL_UPDATE(); }
"Integer.parseInt"          { SAVE_POS(); PRINT_TOKEN("PARSEINT"); COL_UPDATE(); }
".length"                   { SAVE_POS(); PRINT_TOKEN("DOTLENGTH"); COL_UPDATE(); }

    /* Boolean literals (ANTES de IDENTIFIER) */

"true"                      { SAVE_POS(); PRINT_TOKEN_VAL("BOOLLIT", yytext); COL_UPDATE(); }
"false"                     { SAVE_POS(); PRINT_TOKEN_VAL("BOOLLIT", yytext); COL_UPDATE(); }

    /* Palavras-chave Juc (ANTES de IDENTIFIER) */
    
"boolean"                   { SAVE_POS(); PRINT_TOKEN("BOOL"); COL_UPDATE(); }
"class"                     { SAVE_POS(); PRINT_TOKEN("CLASS"); COL_UPDATE(); }
"double"                    { SAVE_POS(); PRINT_TOKEN("DOUBLE"); COL_UPDATE(); }
"else"                      { SAVE_POS(); PRINT_TOKEN("ELSE"); COL_UPDATE(); }
"if"                        { SAVE_POS(); PRINT_TOKEN("IF"); COL_UPDATE(); }
"int"                       { SAVE_POS(); PRINT_TOKEN("INT"); COL_UPDATE(); }
"public"                    { SAVE_POS(); PRINT_TOKEN("PUBLIC"); COL_UPDATE(); }
"return"                    { SAVE_POS(); PRINT_TOKEN("RETURN"); COL_UPDATE(); }
"static"                    { SAVE_POS(); PRINT_TOKEN("STATIC"); COL_UPDATE(); }
"String"                    { SAVE_POS(); PRINT_TOKEN("STRING"); COL_UPDATE(); }
"void"                      { SAVE_POS(); PRINT_TOKEN("VOID"); COL_UPDATE(); }
"while"                     { SAVE_POS(); PRINT_TOKEN("WHILE"); COL_UPDATE(); }

    /* RESERVED: palavras reservadas Java não usadas em Juc */

"++"                        { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"--"                        { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"null"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"Integer"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"System"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"abstract"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"assert"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"break"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"byte"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"case"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"catch"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"char"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"const"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"continue"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"default"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"do"                        { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"enum"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"extends"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"final"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"finally"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"float"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"for"                       { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"goto"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"implements"                { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"import"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"instanceof"                { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"interface"                 { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"long"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"native"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"new"                       { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"package"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"private"                   { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"protected"                 { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"short"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"strictfp"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"super"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"switch"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"synchronized"              { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"this"                      { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"throw"                     { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"throws"                    { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"transient"                 { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"try"                       { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
"volatile"                  { SAVE_POS(); PRINT_TOKEN_VAL("RESERVED", yytext); COL_UPDATE(); }
    
    /* Operadores multi-carácter (ANTES dos simples) */

"&&"                        { SAVE_POS(); PRINT_TOKEN("AND"); COL_UPDATE(); }
"||"                        { SAVE_POS(); PRINT_TOKEN("OR"); COL_UPDATE(); }
"=="                        { SAVE_POS(); PRINT_TOKEN("EQ"); COL_UPDATE(); }
"!="                        { SAVE_POS(); PRINT_TOKEN("NE"); COL_UPDATE(); }
">="                        { SAVE_POS(); PRINT_TOKEN("GE"); COL_UPDATE(); }
"<="                        { SAVE_POS(); PRINT_TOKEN("LE"); COL_UPDATE(); }
"<<"                        { SAVE_POS(); PRINT_TOKEN("LSHIFT"); COL_UPDATE(); }
">>"                        { SAVE_POS(); PRINT_TOKEN("RSHIFT"); COL_UPDATE(); }
"->"                        { SAVE_POS(); PRINT_TOKEN("ARROW"); COL_UPDATE(); }

    /* Operadores simples */

"="                         { SAVE_POS(); PRINT_TOKEN("ASSIGN"); COL_UPDATE(); }
"+"                         { SAVE_POS(); PRINT_TOKEN("PLUS"); COL_UPDATE(); }
"-"                         { SAVE_POS(); PRINT_TOKEN("MINUS"); COL_UPDATE(); }
"*"                         { SAVE_POS(); PRINT_TOKEN("STAR"); COL_UPDATE(); }
"/"                         { SAVE_POS(); PRINT_TOKEN("DIV"); COL_UPDATE(); }
"%"                         { SAVE_POS(); PRINT_TOKEN("MOD"); COL_UPDATE(); }
"!"                         { SAVE_POS(); PRINT_TOKEN("NOT"); COL_UPDATE(); }
">"                         { SAVE_POS(); PRINT_TOKEN("GT"); COL_UPDATE(); }
"<"                         { SAVE_POS(); PRINT_TOKEN("LT"); COL_UPDATE(); }
"^"                         { SAVE_POS(); PRINT_TOKEN("XOR"); COL_UPDATE(); }

    /* Delimitadores */

"{"                         { SAVE_POS(); PRINT_TOKEN("LBRACE"); COL_UPDATE(); }
"}"                         { SAVE_POS(); PRINT_TOKEN("RBRACE"); COL_UPDATE(); }
"("                         { SAVE_POS(); PRINT_TOKEN("LPAR"); COL_UPDATE(); }
")"                         { SAVE_POS(); PRINT_TOKEN("RPAR"); COL_UPDATE(); }
"["                         { SAVE_POS(); PRINT_TOKEN("LSQ"); COL_UPDATE(); }
"]"                         { SAVE_POS(); PRINT_TOKEN("RSQ"); COL_UPDATE(); }
";"                         { SAVE_POS(); PRINT_TOKEN("SEMICOLON"); COL_UPDATE(); }
","                         { SAVE_POS(); PRINT_TOKEN("COMMA"); COL_UPDATE(); }

    /* Decimal (ANTES de NATURAL para evitar conflitos por conta do ".") */

{DIGITS}"."{DIGITS}{EXPONENT}?    { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); }
{DIGITS}"."{EXPONENT}             { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); }
"."{DIGITS}{EXPONENT}?            { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); }
{DIGITS}"."                       { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); }
{DIGITS}{EXPONENT}                { SAVE_POS(); PRINT_TOKEN_VAL("DECIMAL", yytext); COL_UPDATE(); }      

    /* NATURAL */
0                                 { SAVE_POS(); PRINT_TOKEN_VAL("NATURAL", yytext); COL_UPDATE(); }
{DIGIT_NZ}({DIGIT}|_)*{DIGIT}     { SAVE_POS(); PRINT_TOKEN_VAL("NATURAL", yytext); COL_UPDATE(); }
{DIGIT_NZ}                        { SAVE_POS(); PRINT_TOKEN_VAL("NATURAL", yytext); COL_UPDATE(); }

    /* Identifier */

{LETTER}{ALNUM}*                  { SAVE_POS(); PRINT_TOKEN_VAL("IDENTIFIER", yytext); COL_UPDATE(); }

    /* Espaços em branco */

" "                         { col++; }
\t                          { col++; }
\f                          { col++; }
\r\n                        { line++; col = 1; }
\r                          { line++; col = 1; }
\n                          { line++; col = 1; }

    /* Erro léxical */
.                           {

                            printf("Line %d, col %d: illegal character (%s)\n", line, col, yytext);
                            col++;

                            }
%%

int main(int argc, char *argv[]) {

    for (int i = 1; i < argc; i++) {

        if (strcmp(argv[i], "-l") == 0) {
            print_tokens = 1;
            
        } else if (strcmp(argv[i], "-e1") == 0) {
            print_tokens = 0;
        }
    }
    
    yylex();
    
    return 0;
}

int yywrap() {
    return 1;
}