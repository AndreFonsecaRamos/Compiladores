/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    IDENTIFIER = 258,              /* IDENTIFIER  */
    NATURAL = 259,                 /* NATURAL  */
    DECIMAL = 260,                 /* DECIMAL  */
    STRLIT = 261,                  /* STRLIT  */
    BOOLLIT = 262,                 /* BOOLLIT  */
    CLASS = 263,                   /* CLASS  */
    PUBLIC = 264,                  /* PUBLIC  */
    STATIC = 265,                  /* STATIC  */
    PRINT = 266,                   /* PRINT  */
    PARSEINT = 267,                /* PARSEINT  */
    DOTLENGTH = 268,               /* DOTLENGTH  */
    BOOL = 269,                    /* BOOL  */
    DOUBLE = 270,                  /* DOUBLE  */
    ELSE = 271,                    /* ELSE  */
    IF = 272,                      /* IF  */
    INT = 273,                     /* INT  */
    RETURN = 274,                  /* RETURN  */
    STRING = 275,                  /* STRING  */
    VOID = 276,                    /* VOID  */
    WHILE = 277,                   /* WHILE  */
    RESERVED = 278,                /* RESERVED  */
    AND = 279,                     /* AND  */
    OR = 280,                      /* OR  */
    EQ = 281,                      /* EQ  */
    NE = 282,                      /* NE  */
    GE = 283,                      /* GE  */
    LE = 284,                      /* LE  */
    LSHIFT = 285,                  /* LSHIFT  */
    RSHIFT = 286,                  /* RSHIFT  */
    ARROW = 287,                   /* ARROW  */
    ASSIGN = 288,                  /* ASSIGN  */
    PLUS = 289,                    /* PLUS  */
    MINUS = 290,                   /* MINUS  */
    STAR = 291,                    /* STAR  */
    DIV = 292,                     /* DIV  */
    MOD = 293,                     /* MOD  */
    NOT = 294,                     /* NOT  */
    GT = 295,                      /* GT  */
    LT = 296,                      /* LT  */
    XOR = 297,                     /* XOR  */
    LBRACE = 298,                  /* LBRACE  */
    RBRACE = 299,                  /* RBRACE  */
    LPAR = 300,                    /* LPAR  */
    RPAR = 301,                    /* RPAR  */
    LSQ = 302,                     /* LSQ  */
    RSQ = 303,                     /* RSQ  */
    SEMICOLON = 304,               /* SEMICOLON  */
    COMMA = 305,                   /* COMMA  */
    NO_ELSE = 306,                 /* NO_ELSE  */
    UNARY_MINUS = 307,             /* UNARY_MINUS  */
    UNARY_PLUS = 308               /* UNARY_PLUS  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define IDENTIFIER 258
#define NATURAL 259
#define DECIMAL 260
#define STRLIT 261
#define BOOLLIT 262
#define CLASS 263
#define PUBLIC 264
#define STATIC 265
#define PRINT 266
#define PARSEINT 267
#define DOTLENGTH 268
#define BOOL 269
#define DOUBLE 270
#define ELSE 271
#define IF 272
#define INT 273
#define RETURN 274
#define STRING 275
#define VOID 276
#define WHILE 277
#define RESERVED 278
#define AND 279
#define OR 280
#define EQ 281
#define NE 282
#define GE 283
#define LE 284
#define LSHIFT 285
#define RSHIFT 286
#define ARROW 287
#define ASSIGN 288
#define PLUS 289
#define MINUS 290
#define STAR 291
#define DIV 292
#define MOD 293
#define NOT 294
#define GT 295
#define LT 296
#define XOR 297
#define LBRACE 298
#define RBRACE 299
#define LPAR 300
#define RPAR 301
#define LSQ 302
#define RSQ 303
#define SEMICOLON 304
#define COMMA 305
#define NO_ELSE 306
#define UNARY_MINUS 307
#define UNARY_PLUS 308

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 26 "jucompiler.y"

    char *lexeme;
    struct node *node;

#line 178 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif

/* Location type.  */
#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE YYLTYPE;
struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
};
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


extern YYSTYPE yylval;
extern YYLTYPE yylloc;

int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
