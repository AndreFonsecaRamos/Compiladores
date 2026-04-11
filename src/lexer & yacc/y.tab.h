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
    CLASS = 258,                   /* CLASS  */
    PUBLIC = 259,                  /* PUBLIC  */
    STATIC = 260,                  /* STATIC  */
    PRINT = 261,                   /* PRINT  */
    PARSEINT = 262,                /* PARSEINT  */
    DOTLENGTH = 263,               /* DOTLENGTH  */
    BOOLLIT = 264,                 /* BOOLLIT  */
    BOOL = 265,                    /* BOOL  */
    DOUBLE = 266,                  /* DOUBLE  */
    ELSE = 267,                    /* ELSE  */
    IF = 268,                      /* IF  */
    INT = 269,                     /* INT  */
    RETURN = 270,                  /* RETURN  */
    STRING = 271,                  /* STRING  */
    VOID = 272,                    /* VOID  */
    WHILE = 273,                   /* WHILE  */
    RESERVED = 274,                /* RESERVED  */
    AND = 275,                     /* AND  */
    OR = 276,                      /* OR  */
    EQ = 277,                      /* EQ  */
    NE = 278,                      /* NE  */
    GE = 279,                      /* GE  */
    LE = 280,                      /* LE  */
    LSHIFT = 281,                  /* LSHIFT  */
    RSHIFT = 282,                  /* RSHIFT  */
    ARROW = 283,                   /* ARROW  */
    ASSIGN = 284,                  /* ASSIGN  */
    PLUS = 285,                    /* PLUS  */
    MINUS = 286,                   /* MINUS  */
    STAR = 287,                    /* STAR  */
    DIV = 288,                     /* DIV  */
    MOD = 289,                     /* MOD  */
    NOT = 290,                     /* NOT  */
    GT = 291,                      /* GT  */
    LT = 292,                      /* LT  */
    XOR = 293,                     /* XOR  */
    LBRACE = 294,                  /* LBRACE  */
    RBRACE = 295,                  /* RBRACE  */
    LPAR = 296,                    /* LPAR  */
    RPAR = 297,                    /* RPAR  */
    LSQ = 298,                     /* LSQ  */
    RSQ = 299,                     /* RSQ  */
    SEMICOLON = 300,               /* SEMICOLON  */
    COMMA = 301,                   /* COMMA  */
    DECIMAL = 302,                 /* DECIMAL  */
    NATURAL = 303,                 /* NATURAL  */
    IDENTIFIER = 304,              /* IDENTIFIER  */
    STRLIT = 305,                  /* STRLIT  */
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
#define CLASS 258
#define PUBLIC 259
#define STATIC 260
#define PRINT 261
#define PARSEINT 262
#define DOTLENGTH 263
#define BOOLLIT 264
#define BOOL 265
#define DOUBLE 266
#define ELSE 267
#define IF 268
#define INT 269
#define RETURN 270
#define STRING 271
#define VOID 272
#define WHILE 273
#define RESERVED 274
#define AND 275
#define OR 276
#define EQ 277
#define NE 278
#define GE 279
#define LE 280
#define LSHIFT 281
#define RSHIFT 282
#define ARROW 283
#define ASSIGN 284
#define PLUS 285
#define MINUS 286
#define STAR 287
#define DIV 288
#define MOD 289
#define NOT 290
#define GT 291
#define LT 292
#define XOR 293
#define LBRACE 294
#define RBRACE 295
#define LPAR 296
#define RPAR 297
#define LSQ 298
#define RSQ 299
#define SEMICOLON 300
#define COMMA 301
#define DECIMAL 302
#define NATURAL 303
#define IDENTIFIER 304
#define STRLIT 305
#define NO_ELSE 306
#define UNARY_MINUS 307
#define UNARY_PLUS 308

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
