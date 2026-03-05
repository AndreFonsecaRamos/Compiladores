/* João Francisco - 2023228417 */
%{

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
INT_PART        {DIGITS}
FRAC_PART       {DIGITS}
EXPONENT        [eE][+-]?{DIGITS}

/* Start conditions */

%x COMMENT
%x STRLIT

%%
    /* Comentários de linha */

"//".*                      { COL_UPDATE(); }

    /* Comentários de bloco */

"/*"                        { SAVE_POS(); BEGIN(COMMENT); col += yyleng; }
<COMMENT>"*/"               { col += yyleng; BEGIN(INITIAL); }
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
                            if(print_tokens) {
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

<STRLIT>\n|\r               {

                            if(yytext[0] == '\n') { line++; col = 1; }
                            else if(yytext[0] == '\r') { col++; }
                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            BEGIN(INITIAL);

                            }

<STRLIT><<EOF>>             {

                            printf("Line %d, col %d: unterminated string literal\n", linha_inicio_string, coluna_inicio_string);
                            BEGIN(INITIAL);
                            
                            return 0;

                            }

<STRLIT>.                   { buffer_string[comprimento_string++] = yytext[0]; col++; }

    /* Identifier */

{LETTER}{ALNUM}*            { SAVE_POS(); PRINT_TOKEN_VAL("IDENTIFIER", yytext); COL_UPDATE(); }


    /* Espaços em branco */

" "                         { col++; }
\t                          { col++; }
\r                          { col++; }
\n                          { line++; col = 1; }

    /* Erro léxical */
.                           {

                            printf("Line %d, col %d: illegal character (%s)\n", line, col, yytext);
                            col++;

                            }

    /* Tokens Especias */

    

%%

#include <stdio.h>
#include <string.h>

extern int yylex();

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