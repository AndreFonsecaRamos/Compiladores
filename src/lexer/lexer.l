/*
 * Andre Fonseca Ramos - Nº2023227306
 */

%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    #define YY_USER_ACTION \
        syn_col = curcol; \
        curcol += yyleng;

    int show_tokens = 0;
    int curline = 1;
    int curcol = 1;
    int syn_col = 1;

    int start_line = 0;
    int start_col = 0;

    /* Flag para suprimir STRLIT quando há escape inválido */
    int str_has_error = 0;

    /* Buffer Dinamico */
    char *str_buffer = NULL;
    int str_buffer_size = 0;
    int str_buffer_index = 0;
    
    void add_to_buffer(char *str) {
        int len = strlen(str);
        if (str_buffer == NULL) {
            str_buffer_size = 4096;
            str_buffer = (char*)malloc(str_buffer_size);
        }
        while (str_buffer_index + len + 1 >= str_buffer_size) {
            str_buffer_size *= 2;
            str_buffer = (char*)realloc(str_buffer, str_buffer_size);
        }
        strcpy(&str_buffer[str_buffer_index], str);
        str_buffer_index += len;
    }

    void reset_buffer() {
        str_buffer_index = 0;
        if (str_buffer != NULL) {
            str_buffer[0] = '\0';
        }
    }
%}

%X COMMENT
%X STR

digit      [0-9]
nonzero    [1-9]
/* Dígitos opcionais após o nonzero, depois grupos de (underscores + dígitos) */
natural    (0|{nonzero}[0-9]*(_+[0-9]+)*)
dec_seq    ([0-9]+(_+[0-9]+)*)
/* Expoente usa dec_seq — começa e termina num dígito, underscores no meio permitidos */
expo       ([eE][+-]?{dec_seq})
identifier [a-zA-Z_$][a-zA-Z_$0-9]*

%%

"//"[^\n\r]*                        { ; }

"/*"                                { BEGIN(COMMENT); start_line = curline; start_col = syn_col; }
<COMMENT>"*/"                       { BEGIN(INITIAL); }
<COMMENT>\n|\r|\r\n                 { curline++; curcol = 1; }
<COMMENT>.                          { ; }
<COMMENT><<EOF>>                    { printf("Line %d, col %d: unterminated comment\n", start_line, start_col); BEGIN(INITIAL); return 0; }

\"                                  { 
                                      BEGIN(STR); 
                                      start_line = curline; 
                                      start_col = syn_col; 
                                      str_has_error = 0;
                                      reset_buffer();
                                      add_to_buffer("\""); 
                                    }
<STR>\"                             { 
                                      BEGIN(INITIAL); 
                                      add_to_buffer("\""); 
                                      if(show_tokens && !str_has_error) printf("STRLIT(%s)\n", str_buffer); 
                                    }
<STR>\\n                               { add_to_buffer(yytext); }
<STR>\\f                               { add_to_buffer(yytext); }
<STR>\\r                               { add_to_buffer(yytext); }
<STR>\\t                               { add_to_buffer(yytext); }
<STR>\\\\                              { add_to_buffer(yytext); }
<STR>\\\"                              { add_to_buffer(yytext); }
<STR>\\[^\n\r]                         { 
                                          printf("Line %d, col %d: invalid escape sequence (%s)\n", curline, syn_col, yytext);
                                          str_has_error = 1;
                                          add_to_buffer(yytext);
                                        }
<STR>\\                                { 
                                          printf("Line %d, col %d: invalid escape sequence (\\)\n", curline, syn_col);
                                          str_has_error = 1;
                                          add_to_buffer(yytext);
                                        }
<STR>\n|\r|\r\n                     { 
                                      printf("Line %d, col %d: unterminated string literal\n", start_line, start_col); 
                                      curline++; curcol = 1;
                                      BEGIN(INITIAL); 
                                    }
<STR><<EOF>>                        { 
                                      printf("Line %d, col %d: unterminated string literal\n", start_line, start_col); 
                                      BEGIN(INITIAL); return 0; 
                                    }
<STR>[^\\\n\r\"]+                   { add_to_buffer(yytext); }


"boolean"                           { if(show_tokens) printf("BOOL\n"); }
"class"                             { if(show_tokens) printf("CLASS\n"); }
"double"                            { if(show_tokens) printf("DOUBLE\n"); }
"else"                              { if(show_tokens) printf("ELSE\n"); }
"false"                             { if(show_tokens) printf("BOOLLIT(false)\n"); }
"if"                                { if(show_tokens) printf("IF\n"); }
"int"                               { if(show_tokens) printf("INT\n"); }
"public"                            { if(show_tokens) printf("PUBLIC\n"); }
"return"                            { if(show_tokens) printf("RETURN\n"); }
"static"                            { if(show_tokens) printf("STATIC\n"); }
"String"                            { if(show_tokens) printf("STRING\n"); }
"true"                              { if(show_tokens) printf("BOOLLIT(true)\n"); }
"void"                              { if(show_tokens) printf("VOID\n"); }
"while"                             { if(show_tokens) printf("WHILE\n"); }

"System.out.print"                  { if(show_tokens) printf("PRINT\n"); }
"Integer.parseInt"                  { if(show_tokens) printf("PARSEINT\n"); }
".length"                           { if(show_tokens) printf("DOTLENGTH\n"); }

"++"|"--"|"null"|"Integer"|"System" { if(show_tokens) printf("RESERVED(%s)\n", yytext); }
"abstract"|"assert"|"break"|"byte"|"case"|"catch"|"char"|"const"|"continue"|"default"|"do"|"enum"|"extends"|"final"|"finally"|"float"|"for"|"goto"|"implements"|"import"|"instanceof"|"interface"|"long"|"native"|"new"|"package"|"private"|"protected"|"short"|"strictfp"|"super"|"switch"|"synchronized"|"this"|"throw"|"throws"|"transient"|"try"|"volatile" { if(show_tokens) printf("RESERVED(%s)\n", yytext); }

"&&"                                { if(show_tokens) printf("AND\n"); }
"=="                                { if(show_tokens) printf("EQ\n"); }
">="                                { if(show_tokens) printf("GE\n"); }
"<="                                { if(show_tokens) printf("LE\n"); }
"!="                                { if(show_tokens) printf("NE\n"); }
"||"                                { if(show_tokens) printf("OR\n"); }
"->"                                { if(show_tokens) printf("ARROW\n"); }
"<<"                                { if(show_tokens) printf("LSHIFT\n"); }
">>"                                { if(show_tokens) printf("RSHIFT\n"); }
"="                                 { if(show_tokens) printf("ASSIGN\n"); }
"*"                                 { if(show_tokens) printf("STAR\n"); }
","                                 { if(show_tokens) printf("COMMA\n"); }
"/"                                 { if(show_tokens) printf("DIV\n"); }
">"                                 { if(show_tokens) printf("GT\n"); }
"<"                                 { if(show_tokens) printf("LT\n"); }
"-"                                 { if(show_tokens) printf("MINUS\n"); }
"+"                                 { if(show_tokens) printf("PLUS\n"); }
"%"                                 { if(show_tokens) printf("MOD\n"); }
"!"                                 { if(show_tokens) printf("NOT\n"); }
"{"                                 { if(show_tokens) printf("LBRACE\n"); }
"}"                                 { if(show_tokens) printf("RBRACE\n"); }
"("                                 { if(show_tokens) printf("LPAR\n"); }
")"                                 { if(show_tokens) printf("RPAR\n"); }
"["                                 { if(show_tokens) printf("LSQ\n"); }
"]"                                 { if(show_tokens) printf("RSQ\n"); }
";"                                 { if(show_tokens) printf("SEMICOLON\n"); }
"^"                                 { if(show_tokens) printf("XOR\n"); }

{natural}                           { if(show_tokens) printf("NATURAL(%s)\n", yytext); }
({dec_seq}"."{dec_seq}?{expo}?|"."{dec_seq}{expo}?|{dec_seq}{expo}) { if(show_tokens) printf("DECIMAL(%s)\n", yytext); }
{identifier}                        { if(show_tokens) printf("IDENTIFIER(%s)\n", yytext); }

\n|\r|\r\n                          { curline++; curcol = 1; }
[ \t\f\v]+                          { ; }
\357\273\277                        { ; /* Ignora o BOM do Windows no inicio de ficheiros */ }

.                                   { printf("Line %d, col %d: illegal character (%s)\n", curline, syn_col, yytext); }

%%

int main(int argc, char **argv) {
    if (argc > 1 && (strcmp(argv[1], "-e1") == 0 || strcmp(argv[1], "-1") == 0 || strcmp(argv[1], "-l") == 0)) {
        show_tokens = 1;
    }
    yylex();
    
    /* Limpa a memoria dinâmica antes de sair */
    if (str_buffer != NULL) {
        free(str_buffer);
    }
    return 0;
}

int yywrap() {
    return 1;
}