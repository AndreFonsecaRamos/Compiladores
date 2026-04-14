/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison implementation for Yacc-like parsers in C

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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30802

/* Bison version string.  */
#define YYBISON_VERSION "3.8.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 4 "jucompiler.y"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ast.h"

int yylex(void);
void yyerror(char *s);

extern int print_tokens;
extern int token_line, token_col; 
extern char* yytext;
int flag_l = 0;
int flag_e1 = 0;

struct node *ast_root;
int num_errors = 0;

#line 90 "y.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
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
#line 23 "jucompiler.y"

    char *lexeme;
    struct node *node;

#line 254 "y.tab.c"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_IDENTIFIER = 3,                 /* IDENTIFIER  */
  YYSYMBOL_NATURAL = 4,                    /* NATURAL  */
  YYSYMBOL_DECIMAL = 5,                    /* DECIMAL  */
  YYSYMBOL_STRLIT = 6,                     /* STRLIT  */
  YYSYMBOL_BOOLLIT = 7,                    /* BOOLLIT  */
  YYSYMBOL_CLASS = 8,                      /* CLASS  */
  YYSYMBOL_PUBLIC = 9,                     /* PUBLIC  */
  YYSYMBOL_STATIC = 10,                    /* STATIC  */
  YYSYMBOL_PRINT = 11,                     /* PRINT  */
  YYSYMBOL_PARSEINT = 12,                  /* PARSEINT  */
  YYSYMBOL_DOTLENGTH = 13,                 /* DOTLENGTH  */
  YYSYMBOL_BOOL = 14,                      /* BOOL  */
  YYSYMBOL_DOUBLE = 15,                    /* DOUBLE  */
  YYSYMBOL_ELSE = 16,                      /* ELSE  */
  YYSYMBOL_IF = 17,                        /* IF  */
  YYSYMBOL_INT = 18,                       /* INT  */
  YYSYMBOL_RETURN = 19,                    /* RETURN  */
  YYSYMBOL_STRING = 20,                    /* STRING  */
  YYSYMBOL_VOID = 21,                      /* VOID  */
  YYSYMBOL_WHILE = 22,                     /* WHILE  */
  YYSYMBOL_RESERVED = 23,                  /* RESERVED  */
  YYSYMBOL_AND = 24,                       /* AND  */
  YYSYMBOL_OR = 25,                        /* OR  */
  YYSYMBOL_EQ = 26,                        /* EQ  */
  YYSYMBOL_NE = 27,                        /* NE  */
  YYSYMBOL_GE = 28,                        /* GE  */
  YYSYMBOL_LE = 29,                        /* LE  */
  YYSYMBOL_LSHIFT = 30,                    /* LSHIFT  */
  YYSYMBOL_RSHIFT = 31,                    /* RSHIFT  */
  YYSYMBOL_ARROW = 32,                     /* ARROW  */
  YYSYMBOL_ASSIGN = 33,                    /* ASSIGN  */
  YYSYMBOL_PLUS = 34,                      /* PLUS  */
  YYSYMBOL_MINUS = 35,                     /* MINUS  */
  YYSYMBOL_STAR = 36,                      /* STAR  */
  YYSYMBOL_DIV = 37,                       /* DIV  */
  YYSYMBOL_MOD = 38,                       /* MOD  */
  YYSYMBOL_NOT = 39,                       /* NOT  */
  YYSYMBOL_GT = 40,                        /* GT  */
  YYSYMBOL_LT = 41,                        /* LT  */
  YYSYMBOL_XOR = 42,                       /* XOR  */
  YYSYMBOL_LBRACE = 43,                    /* LBRACE  */
  YYSYMBOL_RBRACE = 44,                    /* RBRACE  */
  YYSYMBOL_LPAR = 45,                      /* LPAR  */
  YYSYMBOL_RPAR = 46,                      /* RPAR  */
  YYSYMBOL_LSQ = 47,                       /* LSQ  */
  YYSYMBOL_RSQ = 48,                       /* RSQ  */
  YYSYMBOL_SEMICOLON = 49,                 /* SEMICOLON  */
  YYSYMBOL_COMMA = 50,                     /* COMMA  */
  YYSYMBOL_NO_ELSE = 51,                   /* NO_ELSE  */
  YYSYMBOL_UNARY_MINUS = 52,               /* UNARY_MINUS  */
  YYSYMBOL_UNARY_PLUS = 53,                /* UNARY_PLUS  */
  YYSYMBOL_YYACCEPT = 54,                  /* $accept  */
  YYSYMBOL_Program = 55,                   /* Program  */
  YYSYMBOL_DeclList = 56,                  /* DeclList  */
  YYSYMBOL_MethodDecl = 57,                /* MethodDecl  */
  YYSYMBOL_MethodHeader = 58,              /* MethodHeader  */
  YYSYMBOL_FormalParams = 59,              /* FormalParams  */
  YYSYMBOL_FormalParamsList = 60,          /* FormalParamsList  */
  YYSYMBOL_MethodBody = 61,                /* MethodBody  */
  YYSYMBOL_MethodBodyContent = 62,         /* MethodBodyContent  */
  YYSYMBOL_FieldDecl = 63,                 /* FieldDecl  */
  YYSYMBOL_VarDecl = 64,                   /* VarDecl  */
  YYSYMBOL_FieldIDList = 65,               /* FieldIDList  */
  YYSYMBOL_Type = 66,                      /* Type  */
  YYSYMBOL_Statement = 67,                 /* Statement  */
  YYSYMBOL_StatementList = 68,             /* StatementList  */
  YYSYMBOL_Assignment = 69,                /* Assignment  */
  YYSYMBOL_MethodInvocation = 70,          /* MethodInvocation  */
  YYSYMBOL_ExprList = 71,                  /* ExprList  */
  YYSYMBOL_ParseArgs = 72,                 /* ParseArgs  */
  YYSYMBOL_Expr = 73                       /* Expr  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_uint8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
#if defined __GNUC__ && ! defined __ICC && 406 <= __GNUC__ * 100 + __GNUC_MINOR__
# if __GNUC__ * 100 + __GNUC_MINOR__ < 407
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")
# else
#  define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                           \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# endif
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  4
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   469

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  54
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  20
/* YYNRULES -- Number of rules.  */
#define YYNRULES  81
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  167

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   308


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53
};

#if YYDEBUG
/* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,    60,    60,    71,    78,    83,    94,    95,    99,   109,
     113,   121,   127,   133,   139,   148,   162,   172,   180,   184,
     197,   198,   203,   217,   235,   239,   260,   265,   269,   270,
     271,   275,   278,   285,   293,   299,   303,   304,   305,   306,
     307,   308,   312,   316,   320,   321,   333,   341,   352,   356,
     360,   364,   371,   376,   380,   381,   382,   383,   384,   385,
     386,   387,   388,   389,   390,   391,   392,   393,   394,   395,
     397,   398,   399,   401,   402,   404,   405,   407,   412,   413,
     414,   415
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "IDENTIFIER",
  "NATURAL", "DECIMAL", "STRLIT", "BOOLLIT", "CLASS", "PUBLIC", "STATIC",
  "PRINT", "PARSEINT", "DOTLENGTH", "BOOL", "DOUBLE", "ELSE", "IF", "INT",
  "RETURN", "STRING", "VOID", "WHILE", "RESERVED", "AND", "OR", "EQ", "NE",
  "GE", "LE", "LSHIFT", "RSHIFT", "ARROW", "ASSIGN", "PLUS", "MINUS",
  "STAR", "DIV", "MOD", "NOT", "GT", "LT", "XOR", "LBRACE", "RBRACE",
  "LPAR", "RPAR", "LSQ", "RSQ", "SEMICOLON", "COMMA", "NO_ELSE",
  "UNARY_MINUS", "UNARY_PLUS", "$accept", "Program", "DeclList",
  "MethodDecl", "MethodHeader", "FormalParams", "FormalParamsList",
  "MethodBody", "MethodBodyContent", "FieldDecl", "VarDecl", "FieldIDList",
  "Type", "Statement", "StatementList", "Assignment", "MethodInvocation",
  "ExprList", "ParseArgs", "Expr", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#define YYPACT_NINF (-77)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
static const yytype_int16 yypact[] =
{
       5,    18,    28,    12,   -77,    23,     7,    50,   -77,   -77,
      30,   -77,   -77,   -77,   219,   -77,   -77,   -77,   -77,   -77,
     -77,   -77,    62,    26,    67,    31,   -77,   -77,    33,    48,
       8,   147,    -9,    36,   -77,    29,    77,    35,   -28,    45,
      51,    52,   124,    56,   -77,   -77,   -77,   -77,    90,   -77,
      46,    54,    57,   -77,    65,   -77,   109,    73,   -77,   -77,
     -77,   196,   171,   184,    13,   196,    -1,   -77,   -77,   -77,
     196,   196,   196,     3,   -77,   -77,   -77,   218,   196,    42,
     -77,   -77,   -77,   -77,   -77,   -77,   115,    72,   361,    79,
     -77,   -17,   361,    80,   269,    84,    85,   292,   -77,   -77,
     -77,   -77,    87,   315,   196,   196,   196,   196,   196,   196,
     196,   196,   196,   196,   196,   196,   196,   196,   196,   196,
     -77,   338,   -77,   -77,    -3,   -77,   102,   -77,   -77,   196,
      88,    89,   -77,   196,    70,   -77,   -77,   397,   380,   428,
     428,   190,   190,   177,   177,    -2,    -2,   -77,   -77,   -77,
     190,   190,   414,    70,   -77,   136,   361,   -77,   -77,   244,
     141,   -77,   -77,    94,    70,   -77,   -77
};

/* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
   Performed when YYTABLE does not specify something else to do.  Zero
   means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       0,     0,     0,     0,     1,     0,     0,     0,     3,     9,
       0,     7,     8,    24,     0,     2,     6,     4,     5,    28,
      30,    29,     0,     0,     0,     0,    20,    10,    27,     0,
       0,     0,     0,     0,    14,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    44,    19,    40,    22,     0,    21,
       0,     0,     0,    13,     0,    23,     0,     0,    12,    18,
      43,     0,     0,     0,     0,     0,    78,    79,    80,    81,
       0,     0,     0,     0,    36,    75,    76,     0,     0,     0,
      27,    38,    37,    39,    11,    26,     0,    15,    46,     0,
      48,     0,    51,     0,     0,     0,     0,     0,    77,    71,
      70,    72,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
      35,     0,    31,    45,     0,    16,     0,    49,    47,     0,
       0,     0,    53,     0,     0,    74,    73,    59,    60,    64,
      69,    65,    67,    62,    63,    54,    55,    56,    57,    58,
      66,    68,    61,     0,    25,     0,    50,    42,    41,     0,
      32,    34,    17,     0,     0,    52,    33
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int16 yypgoto[] =
{
     -77,   -77,   -77,   150,   -77,   133,   -77,   -77,   -77,   158,
     -77,    91,   -12,   -76,   -77,   -77,   -30,   -77,   -29,    37
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     2,    10,    11,    23,    35,    87,    27,    30,    12,
      47,    32,    36,    49,    79,    50,    75,    91,    76,    77
};

/* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule whose
   number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      51,    52,    24,   123,   102,    61,    66,    67,    68,    37,
      69,    38,    98,     1,    95,    40,    96,    62,    48,    39,
      40,     3,    19,    20,     6,    41,    21,    42,     4,   128,
      43,     6,     7,   129,   114,   115,   116,    70,    71,     7,
      55,    56,    72,    37,    62,    38,   154,    56,    73,    51,
      52,    44,    45,    39,    40,     5,    13,    46,   160,    41,
      14,    42,    19,    20,    43,    25,    21,     8,    33,    26,
      28,    37,     9,    38,    15,    58,    29,   161,    31,    16,
      59,    39,    40,    57,    60,    44,   122,    41,   166,    42,
      63,    46,    43,    80,    34,    81,    64,    65,    88,    92,
      94,    78,    97,    82,    51,    52,    83,    99,   100,   101,
     103,    84,    85,    44,   155,   121,    19,    20,   125,    46,
      21,    86,   126,    51,    52,   127,   130,    66,    67,    68,
     132,    69,   133,   135,    51,    52,    40,   157,   158,   162,
     165,   137,   138,   139,   140,   141,   142,   143,   144,   145,
     146,   147,   148,   149,   150,   151,   152,   164,    70,    71,
      17,    19,    20,    72,    54,    21,   156,    33,    18,    73,
     159,   124,    89,    74,    66,    67,    68,     0,    69,     0,
       0,     0,     0,    40,     0,     0,     0,    66,    67,    68,
      93,    69,     0,    53,     0,     0,    40,     0,     0,    66,
      67,    68,     0,    69,     0,    70,    71,     0,    40,     0,
      72,   112,   113,   114,   115,   116,    73,    90,    70,    71,
     110,   111,     0,    72,   112,   113,   114,   115,   116,    73,
      70,    71,     0,    19,    20,    72,     0,    21,     0,     0,
      22,    73,   104,   105,   106,   107,   108,   109,   110,   111,
       0,     0,   112,   113,   114,   115,   116,     0,   117,   118,
     119,     0,     0,     0,     0,     0,     0,   120,   104,   105,
     106,   107,   108,   109,   110,   111,     0,     0,   112,   113,
     114,   115,   116,     0,   117,   118,   119,     0,     0,     0,
       0,     0,   163,   104,   105,   106,   107,   108,   109,   110,
     111,     0,     0,   112,   113,   114,   115,   116,     0,   117,
     118,   119,     0,     0,     0,   131,   104,   105,   106,   107,
     108,   109,   110,   111,     0,     0,   112,   113,   114,   115,
     116,     0,   117,   118,   119,     0,     0,     0,   134,   104,
     105,   106,   107,   108,   109,   110,   111,     0,     0,   112,
     113,   114,   115,   116,     0,   117,   118,   119,     0,     0,
       0,   136,   104,   105,   106,   107,   108,   109,   110,   111,
       0,     0,   112,   113,   114,   115,   116,     0,   117,   118,
     119,     0,     0,     0,   153,   104,   105,   106,   107,   108,
     109,   110,   111,     0,     0,   112,   113,   114,   115,   116,
       0,   117,   118,   119,   104,     0,   106,   107,   108,   109,
     110,   111,     0,     0,   112,   113,   114,   115,   116,     0,
     117,   118,   119,   106,   107,   108,   109,   110,   111,     0,
       0,   112,   113,   114,   115,   116,     0,   117,   118,   119,
     106,   107,   108,   109,   110,   111,     0,     0,   112,   113,
     114,   115,   116,     0,   117,   118,   108,   109,   110,   111,
       0,     0,   112,   113,   114,   115,   116,     0,   117,   118
};

static const yytype_int16 yycheck[] =
{
      30,    30,    14,    79,     1,    33,     3,     4,     5,     1,
       7,     3,    13,     8,     1,    12,     3,    45,    30,    11,
      12,     3,    14,    15,     1,    17,    18,    19,     0,    46,
      22,     1,     9,    50,    36,    37,    38,    34,    35,     9,
      49,    50,    39,     1,    45,     3,    49,    50,    45,    79,
      79,    43,    44,    11,    12,    43,    49,    49,   134,    17,
      10,    19,    14,    15,    22,     3,    18,    44,    20,    43,
       3,     1,    49,     3,    44,    46,    45,   153,    45,    49,
       3,    11,    12,    47,    49,    43,    44,    17,   164,    19,
      45,    49,    22,     3,    46,    49,    45,    45,    61,    62,
      63,    45,    65,    49,   134,   134,    49,    70,    71,    72,
      73,    46,     3,    43,   126,    78,    14,    15,     3,    49,
      18,    48,    50,   153,   153,    46,    46,     3,     4,     5,
      46,     7,    47,    46,   164,   164,    12,    49,    49,     3,
      46,   104,   105,   106,   107,   108,   109,   110,   111,   112,
     113,   114,   115,   116,   117,   118,   119,    16,    34,    35,
      10,    14,    15,    39,    31,    18,   129,    20,    10,    45,
     133,    80,     1,    49,     3,     4,     5,    -1,     7,    -1,
      -1,    -1,    -1,    12,    -1,    -1,    -1,     3,     4,     5,
       6,     7,    -1,    46,    -1,    -1,    12,    -1,    -1,     3,
       4,     5,    -1,     7,    -1,    34,    35,    -1,    12,    -1,
      39,    34,    35,    36,    37,    38,    45,    46,    34,    35,
      30,    31,    -1,    39,    34,    35,    36,    37,    38,    45,
      34,    35,    -1,    14,    15,    39,    -1,    18,    -1,    -1,
      21,    45,    24,    25,    26,    27,    28,    29,    30,    31,
      -1,    -1,    34,    35,    36,    37,    38,    -1,    40,    41,
      42,    -1,    -1,    -1,    -1,    -1,    -1,    49,    24,    25,
      26,    27,    28,    29,    30,    31,    -1,    -1,    34,    35,
      36,    37,    38,    -1,    40,    41,    42,    -1,    -1,    -1,
      -1,    -1,    48,    24,    25,    26,    27,    28,    29,    30,
      31,    -1,    -1,    34,    35,    36,    37,    38,    -1,    40,
      41,    42,    -1,    -1,    -1,    46,    24,    25,    26,    27,
      28,    29,    30,    31,    -1,    -1,    34,    35,    36,    37,
      38,    -1,    40,    41,    42,    -1,    -1,    -1,    46,    24,
      25,    26,    27,    28,    29,    30,    31,    -1,    -1,    34,
      35,    36,    37,    38,    -1,    40,    41,    42,    -1,    -1,
      -1,    46,    24,    25,    26,    27,    28,    29,    30,    31,
      -1,    -1,    34,    35,    36,    37,    38,    -1,    40,    41,
      42,    -1,    -1,    -1,    46,    24,    25,    26,    27,    28,
      29,    30,    31,    -1,    -1,    34,    35,    36,    37,    38,
      -1,    40,    41,    42,    24,    -1,    26,    27,    28,    29,
      30,    31,    -1,    -1,    34,    35,    36,    37,    38,    -1,
      40,    41,    42,    26,    27,    28,    29,    30,    31,    -1,
      -1,    34,    35,    36,    37,    38,    -1,    40,    41,    42,
      26,    27,    28,    29,    30,    31,    -1,    -1,    34,    35,
      36,    37,    38,    -1,    40,    41,    28,    29,    30,    31,
      -1,    -1,    34,    35,    36,    37,    38,    -1,    40,    41
};

/* YYSTOS[STATE-NUM] -- The symbol kind of the accessing symbol of
   state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,     8,    55,     3,     0,    43,     1,     9,    44,    49,
      56,    57,    63,    49,    10,    44,    49,    57,    63,    14,
      15,    18,    21,    58,    66,     3,    43,    61,     3,    45,
      62,    45,    65,    20,    46,    59,    66,     1,     3,    11,
      12,    17,    19,    22,    43,    44,    49,    64,    66,    67,
      69,    70,    72,    46,    59,    49,    50,    47,    46,     3,
      49,    33,    45,    45,    45,    45,     3,     4,     5,     7,
      34,    35,    39,    45,    49,    70,    72,    73,    45,    68,
       3,    49,    49,    49,    46,     3,    48,    60,    73,     1,
      46,    71,    73,     6,    73,     1,     3,    73,    13,    73,
      73,    73,     1,    73,    24,    25,    26,    27,    28,    29,
      30,    31,    34,    35,    36,    37,    38,    40,    41,    42,
      49,    73,    44,    67,    65,     3,    50,    46,    46,    50,
      46,    46,    46,    47,    46,    46,    46,    73,    73,    73,
      73,    73,    73,    73,    73,    73,    73,    73,    73,    73,
      73,    73,    73,    46,    49,    66,    73,    49,    49,    73,
      67,    67,     3,    48,    16,    46,    67
};

/* YYR1[RULE-NUM] -- Symbol kind of the left-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr1[] =
{
       0,    54,    55,    55,    56,    56,    56,    56,    56,    56,
      57,    58,    58,    58,    58,    59,    59,    60,    60,    61,
      62,    62,    62,    63,    63,    64,    65,    65,    66,    66,
      66,    67,    67,    67,    67,    67,    67,    67,    67,    67,
      67,    67,    67,    67,    68,    68,    69,    70,    70,    70,
      71,    71,    72,    72,    73,    73,    73,    73,    73,    73,
      73,    73,    73,    73,    73,    73,    73,    73,    73,    73,
      73,    73,    73,    73,    73,    73,    73,    73,    73,    73,
      73,    73
};

/* YYR2[RULE-NUM] -- Number of symbols on the right-hand side of rule RULE-NUM.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     5,     4,     2,     2,     2,     1,     1,     1,
       4,     5,     5,     4,     4,     3,     4,     4,     0,     3,
       0,     2,     2,     6,     2,     4,     3,     0,     1,     1,
       1,     3,     5,     7,     5,     3,     2,     2,     2,     2,
       1,     5,     5,     2,     0,     2,     3,     4,     3,     4,
       3,     1,     7,     4,     3,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     3,     3,     3,     3,     3,
       2,     2,     2,     3,     3,     1,     1,     2,     1,     1,
       1,     1
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab
#define YYNOMEM         goto yyexhaustedlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)




# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */

  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    YYNOMEM;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        YYNOMEM;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          YYNOMEM;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */


  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* Program: CLASS IDENTIFIER LBRACE DeclList RBRACE  */
#line 60 "jucompiler.y"
                                            {
        ast_root = newnode(Program, NULL);
        addchild(ast_root, newnode(Id, (yyvsp[-3].lexeme)));
        if ((yyvsp[-1].node) != NULL) {
            struct node_list *current = (yyvsp[-1].node)->children;
            while (current != NULL) {
                addchild(ast_root, current->node);
                current = current->next;
            }
        }
    }
#line 1483 "y.tab.c"
    break;

  case 3: /* Program: CLASS IDENTIFIER LBRACE RBRACE  */
#line 71 "jucompiler.y"
                                     {
        ast_root = newnode(Program, NULL);
        addchild(ast_root, newnode(Id, (yyvsp[-2].lexeme)));
    }
#line 1492 "y.tab.c"
    break;

  case 4: /* DeclList: DeclList MethodDecl  */
#line 78 "jucompiler.y"
                        {
        if ((yyvsp[-1].node) == NULL) (yyval.node) = newnode(Program, NULL);
        else (yyval.node) = (yyvsp[-1].node);
        addchild((yyval.node), (yyvsp[0].node));
    }
#line 1502 "y.tab.c"
    break;

  case 5: /* DeclList: DeclList FieldDecl  */
#line 83 "jucompiler.y"
                         {
        if ((yyvsp[-1].node) == NULL) (yyval.node) = newnode(Program, NULL);
        else (yyval.node) = (yyvsp[-1].node);
        if ((yyvsp[0].node) != NULL) {
            struct node_list *current = (yyvsp[0].node)->children;
            while (current != NULL) {
                addchild((yyval.node), current->node);
                current = current->next;
            }
        }
    }
#line 1518 "y.tab.c"
    break;

  case 6: /* DeclList: DeclList SEMICOLON  */
#line 94 "jucompiler.y"
                         { (yyval.node) = (yyvsp[-1].node); }
#line 1524 "y.tab.c"
    break;

  case 7: /* DeclList: MethodDecl  */
#line 95 "jucompiler.y"
                 {
        (yyval.node) = newnode(Program, NULL);
        addchild((yyval.node), (yyvsp[0].node));
    }
#line 1533 "y.tab.c"
    break;

  case 8: /* DeclList: FieldDecl  */
#line 99 "jucompiler.y"
                {
        (yyval.node) = newnode(Program, NULL);
        if ((yyvsp[0].node) != NULL) {
            struct node_list *current = (yyvsp[0].node)->children;
            while (current != NULL) {
                addchild((yyval.node), current->node);
                current = current->next;
            }
        }
    }
#line 1548 "y.tab.c"
    break;

  case 9: /* DeclList: SEMICOLON  */
#line 109 "jucompiler.y"
                { (yyval.node) = NULL; }
#line 1554 "y.tab.c"
    break;

  case 10: /* MethodDecl: PUBLIC STATIC MethodHeader MethodBody  */
#line 113 "jucompiler.y"
                                          {
        (yyval.node) = newnode(MethodDecl, NULL);
        addchild((yyval.node), (yyvsp[-1].node));
        addchild((yyval.node), (yyvsp[0].node));
    }
#line 1564 "y.tab.c"
    break;

  case 11: /* MethodHeader: Type IDENTIFIER LPAR FormalParams RPAR  */
#line 121 "jucompiler.y"
                                           {
        (yyval.node) = newnode(MethodHeader, NULL);
        addchild((yyval.node), (yyvsp[-4].node));
        addchild((yyval.node), newnode(Id, (yyvsp[-3].lexeme)));
        addchild((yyval.node), (yyvsp[-1].node));
    }
#line 1575 "y.tab.c"
    break;

  case 12: /* MethodHeader: VOID IDENTIFIER LPAR FormalParams RPAR  */
#line 127 "jucompiler.y"
                                             {
        (yyval.node) = newnode(MethodHeader, NULL);
        addchild((yyval.node), newnode(Void, NULL));
        addchild((yyval.node), newnode(Id, (yyvsp[-3].lexeme)));
        addchild((yyval.node), (yyvsp[-1].node));
    }
#line 1586 "y.tab.c"
    break;

  case 13: /* MethodHeader: Type IDENTIFIER LPAR RPAR  */
#line 133 "jucompiler.y"
                                {
        (yyval.node) = newnode(MethodHeader, NULL);
        addchild((yyval.node), (yyvsp[-3].node));
        addchild((yyval.node), newnode(Id, (yyvsp[-2].lexeme)));
        addchild((yyval.node), newnode(MethodParams, NULL));
    }
#line 1597 "y.tab.c"
    break;

  case 14: /* MethodHeader: VOID IDENTIFIER LPAR RPAR  */
#line 139 "jucompiler.y"
                                {
        (yyval.node) = newnode(MethodHeader, NULL);
        addchild((yyval.node), newnode(Void, NULL));
        addchild((yyval.node), newnode(Id, (yyvsp[-2].lexeme)));
        addchild((yyval.node), newnode(MethodParams, NULL));
    }
#line 1608 "y.tab.c"
    break;

  case 15: /* FormalParams: Type IDENTIFIER FormalParamsList  */
#line 148 "jucompiler.y"
                                     {
        (yyval.node) = newnode(MethodParams, NULL);
        struct node *param = newnode(ParamDecl, NULL);
        addchild(param, (yyvsp[-2].node));
        addchild(param, newnode(Id, (yyvsp[-1].lexeme)));
        addchild((yyval.node), param);
        if ((yyvsp[0].node) != NULL) {
            struct node_list *current = (yyvsp[0].node)->children;
            while (current != NULL) {
                addchild((yyval.node), current->node);
                current = current->next;
            }
        }
    }
#line 1627 "y.tab.c"
    break;

  case 16: /* FormalParams: STRING LSQ RSQ IDENTIFIER  */
#line 162 "jucompiler.y"
                                {
        (yyval.node) = newnode(MethodParams, NULL);
        struct node *param = newnode(ParamDecl, NULL);
        addchild(param, newnode(StringArray, NULL));
        addchild(param, newnode(Id, (yyvsp[0].lexeme)));
        addchild((yyval.node), param);
    }
#line 1639 "y.tab.c"
    break;

  case 17: /* FormalParamsList: FormalParamsList COMMA Type IDENTIFIER  */
#line 172 "jucompiler.y"
                                           {
        if ((yyvsp[-3].node) == NULL) (yyval.node) = newnode(Program, NULL);
        else (yyval.node) = (yyvsp[-3].node);
        struct node *param = newnode(ParamDecl, NULL);
        addchild(param, (yyvsp[-1].node));
        addchild(param, newnode(Id, (yyvsp[0].lexeme)));
        addchild((yyval.node), param);
    }
#line 1652 "y.tab.c"
    break;

  case 18: /* FormalParamsList: %empty  */
#line 180 "jucompiler.y"
                  { (yyval.node) = NULL; }
#line 1658 "y.tab.c"
    break;

  case 19: /* MethodBody: LBRACE MethodBodyContent RBRACE  */
#line 184 "jucompiler.y"
                                    {
        (yyval.node) = newnode(MethodBody, NULL);
        if ((yyvsp[-1].node) != NULL) {
            struct node_list *current = (yyvsp[-1].node)->children;
            while (current != NULL) {
                addchild((yyval.node), current->node);
                current = current->next;
            }
        }
    }
#line 1673 "y.tab.c"
    break;

  case 20: /* MethodBodyContent: %empty  */
#line 197 "jucompiler.y"
                { (yyval.node) = NULL; }
#line 1679 "y.tab.c"
    break;

  case 21: /* MethodBodyContent: MethodBodyContent Statement  */
#line 198 "jucompiler.y"
                                  {
        if ((yyvsp[-1].node) == NULL) (yyval.node) = newnode(Program, NULL); 
        else (yyval.node) = (yyvsp[-1].node);
        if ((yyvsp[0].node) != NULL) addchild((yyval.node), (yyvsp[0].node)); 
    }
#line 1689 "y.tab.c"
    break;

  case 22: /* MethodBodyContent: MethodBodyContent VarDecl  */
#line 203 "jucompiler.y"
                                {
        if ((yyvsp[-1].node) == NULL) (yyval.node) = newnode(Program, NULL); 
        else (yyval.node) = (yyvsp[-1].node);
        if ((yyvsp[0].node) != NULL) {
            struct node_list *current = (yyvsp[0].node)->children;
            while (current != NULL) {
                addchild((yyval.node), current->node);
                current = current->next;
            }
        }
    }
#line 1705 "y.tab.c"
    break;

  case 23: /* FieldDecl: PUBLIC STATIC Type IDENTIFIER FieldIDList SEMICOLON  */
#line 217 "jucompiler.y"
                                                        {
        (yyval.node) = newnode(Program, NULL); 
        struct node *first_field = newnode(FieldDecl, NULL);
        addchild(first_field, (yyvsp[-3].node)); 
        addchild(first_field, newnode(Id, (yyvsp[-2].lexeme)));
        addchild((yyval.node), first_field);
        
        if ((yyvsp[-1].node) != NULL) {
            struct node_list *current = (yyvsp[-1].node)->children;
            while (current != NULL) {
                struct node *extra_field = newnode(FieldDecl, NULL);
                addchild(extra_field, newnode((yyvsp[-3].node)->category, NULL)); 
                addchild(extra_field, current->node); 
                addchild((yyval.node), extra_field);
                current = current->next;
            }
        }
    }
#line 1728 "y.tab.c"
    break;

  case 24: /* FieldDecl: error SEMICOLON  */
#line 235 "jucompiler.y"
                      { (yyval.node) = NULL; num_errors++; }
#line 1734 "y.tab.c"
    break;

  case 25: /* VarDecl: Type IDENTIFIER FieldIDList SEMICOLON  */
#line 239 "jucompiler.y"
                                          {
        (yyval.node) = newnode(Program, NULL); 
        struct node *first_var = newnode(VarDecl, NULL);
        addchild(first_var, (yyvsp[-3].node));
        addchild(first_var, newnode(Id, (yyvsp[-2].lexeme)));
        addchild((yyval.node), first_var);
        
        if ((yyvsp[-1].node) != NULL) {
            struct node_list *current = (yyvsp[-1].node)->children;
            while (current != NULL) {
                struct node *extra_var = newnode(VarDecl, NULL);
                addchild(extra_var, newnode((yyvsp[-3].node)->category, NULL)); 
                addchild(extra_var, current->node); 
                addchild((yyval.node), extra_var);
                current = current->next;
            }
        }
    }
#line 1757 "y.tab.c"
    break;

  case 26: /* FieldIDList: FieldIDList COMMA IDENTIFIER  */
#line 260 "jucompiler.y"
                                 {
        if ((yyvsp[-2].node) == NULL) (yyval.node) = newnode(Program, NULL);
        else (yyval.node) = (yyvsp[-2].node);
        addchild((yyval.node), newnode(Id, (yyvsp[0].lexeme))); 
    }
#line 1767 "y.tab.c"
    break;

  case 27: /* FieldIDList: %empty  */
#line 265 "jucompiler.y"
                  { (yyval.node) = NULL; }
#line 1773 "y.tab.c"
    break;

  case 28: /* Type: BOOL  */
#line 269 "jucompiler.y"
             { (yyval.node) = newnode(Bool, NULL); }
#line 1779 "y.tab.c"
    break;

  case 29: /* Type: INT  */
#line 270 "jucompiler.y"
             { (yyval.node) = newnode(Int, NULL); }
#line 1785 "y.tab.c"
    break;

  case 30: /* Type: DOUBLE  */
#line 271 "jucompiler.y"
             { (yyval.node) = newnode(Double, NULL); }
#line 1791 "y.tab.c"
    break;

  case 31: /* Statement: LBRACE StatementList RBRACE  */
#line 275 "jucompiler.y"
                                { 
        (yyval.node) = create_block_node((yyvsp[-1].node)); 
    }
#line 1799 "y.tab.c"
    break;

  case 32: /* Statement: IF LPAR Expr RPAR Statement  */
#line 278 "jucompiler.y"
                                                {
        (yyval.node) = newnode(If, NULL);
        addchild((yyval.node), (yyvsp[-2].node)); 
        if ((yyvsp[0].node) != NULL) addchild((yyval.node), (yyvsp[0].node));
        else addchild((yyval.node), newnode(Block, NULL));
        addchild((yyval.node), newnode(Block, NULL));
    }
#line 1811 "y.tab.c"
    break;

  case 33: /* Statement: IF LPAR Expr RPAR Statement ELSE Statement  */
#line 285 "jucompiler.y"
                                                 {
        (yyval.node) = newnode(If, NULL);
        addchild((yyval.node), (yyvsp[-4].node)); 
        if ((yyvsp[-2].node) != NULL) addchild((yyval.node), (yyvsp[-2].node)); 
        else addchild((yyval.node), newnode(Block, NULL)); 
        if ((yyvsp[0].node) != NULL) addchild((yyval.node), (yyvsp[0].node)); 
        else addchild((yyval.node), newnode(Block, NULL)); 
    }
#line 1824 "y.tab.c"
    break;

  case 34: /* Statement: WHILE LPAR Expr RPAR Statement  */
#line 293 "jucompiler.y"
                                     {
        (yyval.node) = newnode(While, NULL);
        addchild((yyval.node), (yyvsp[-2].node)); 
        if ((yyvsp[0].node) != NULL) addchild((yyval.node), (yyvsp[0].node)); 
        else addchild((yyval.node), newnode(Block, NULL)); 
    }
#line 1835 "y.tab.c"
    break;

  case 35: /* Statement: RETURN Expr SEMICOLON  */
#line 299 "jucompiler.y"
                            {
        (yyval.node) = newnode(Return, NULL);
        addchild((yyval.node), (yyvsp[-1].node));
    }
#line 1844 "y.tab.c"
    break;

  case 36: /* Statement: RETURN SEMICOLON  */
#line 303 "jucompiler.y"
                       { (yyval.node) = newnode(Return, NULL); }
#line 1850 "y.tab.c"
    break;

  case 37: /* Statement: MethodInvocation SEMICOLON  */
#line 304 "jucompiler.y"
                                 { (yyval.node) = (yyvsp[-1].node); }
#line 1856 "y.tab.c"
    break;

  case 38: /* Statement: Assignment SEMICOLON  */
#line 305 "jucompiler.y"
                           { (yyval.node) = (yyvsp[-1].node); }
#line 1862 "y.tab.c"
    break;

  case 39: /* Statement: ParseArgs SEMICOLON  */
#line 306 "jucompiler.y"
                          { (yyval.node) = (yyvsp[-1].node); }
#line 1868 "y.tab.c"
    break;

  case 40: /* Statement: SEMICOLON  */
#line 307 "jucompiler.y"
                { (yyval.node) = NULL; }
#line 1874 "y.tab.c"
    break;

  case 41: /* Statement: PRINT LPAR Expr RPAR SEMICOLON  */
#line 308 "jucompiler.y"
                                     {
        (yyval.node) = newnode(Print, NULL);
        addchild((yyval.node), (yyvsp[-2].node));
    }
#line 1883 "y.tab.c"
    break;

  case 42: /* Statement: PRINT LPAR STRLIT RPAR SEMICOLON  */
#line 312 "jucompiler.y"
                                       {
        (yyval.node) = newnode(Print, NULL);
        addchild((yyval.node), newnode(StrLit, (yyvsp[-2].lexeme)));
    }
#line 1892 "y.tab.c"
    break;

  case 43: /* Statement: error SEMICOLON  */
#line 316 "jucompiler.y"
                      { (yyval.node) = NULL; num_errors++; }
#line 1898 "y.tab.c"
    break;

  case 44: /* StatementList: %empty  */
#line 320 "jucompiler.y"
                { (yyval.node) = NULL; }
#line 1904 "y.tab.c"
    break;

  case 45: /* StatementList: StatementList Statement  */
#line 321 "jucompiler.y"
                              { 
        if ((yyvsp[-1].node) == NULL) {
            (yyval.node) = newnode(Program, NULL); 
            if ((yyvsp[0].node) != NULL) addchild((yyval.node), (yyvsp[0].node));
        } else {
            if ((yyvsp[0].node) != NULL) addchild((yyvsp[-1].node), (yyvsp[0].node));
            (yyval.node) = (yyvsp[-1].node);
        }
    }
#line 1918 "y.tab.c"
    break;

  case 46: /* Assignment: IDENTIFIER ASSIGN Expr  */
#line 333 "jucompiler.y"
                           { 
        (yyval.node) = newnode(Assign, NULL); 
        addchild((yyval.node), newnode(Id, (yyvsp[-2].lexeme))); 
        addchild((yyval.node), (yyvsp[0].node)); 
    }
#line 1928 "y.tab.c"
    break;

  case 47: /* MethodInvocation: IDENTIFIER LPAR ExprList RPAR  */
#line 341 "jucompiler.y"
                                  { 
        (yyval.node) = newnode(Call, NULL); 
        addchild((yyval.node), newnode(Id, (yyvsp[-3].lexeme))); 
        if ((yyvsp[-1].node) != NULL) {
            struct node_list *current = (yyvsp[-1].node)->children;
            while (current != NULL) {
                addchild((yyval.node), current->node);
                current = current->next;
            }
        }
    }
#line 1944 "y.tab.c"
    break;

  case 48: /* MethodInvocation: IDENTIFIER LPAR RPAR  */
#line 352 "jucompiler.y"
                           { 
        (yyval.node) = newnode(Call, NULL); 
        addchild((yyval.node), newnode(Id, (yyvsp[-2].lexeme))); 
    }
#line 1953 "y.tab.c"
    break;

  case 49: /* MethodInvocation: IDENTIFIER LPAR error RPAR  */
#line 356 "jucompiler.y"
                                 { (yyval.node) = NULL; num_errors++; }
#line 1959 "y.tab.c"
    break;

  case 50: /* ExprList: ExprList COMMA Expr  */
#line 360 "jucompiler.y"
                        { 
        addchild((yyvsp[-2].node), (yyvsp[0].node)); 
        (yyval.node) = (yyvsp[-2].node); 
    }
#line 1968 "y.tab.c"
    break;

  case 51: /* ExprList: Expr  */
#line 364 "jucompiler.y"
           { 
        (yyval.node) = newnode(Program, NULL);
        addchild((yyval.node), (yyvsp[0].node)); 
    }
#line 1977 "y.tab.c"
    break;

  case 52: /* ParseArgs: PARSEINT LPAR IDENTIFIER LSQ Expr RSQ RPAR  */
#line 371 "jucompiler.y"
                                               { 
        (yyval.node) = newnode(ParseArgs, NULL); 
        addchild((yyval.node), newnode(Id, (yyvsp[-4].lexeme))); 
        addchild((yyval.node), (yyvsp[-2].node)); 
    }
#line 1987 "y.tab.c"
    break;

  case 53: /* ParseArgs: PARSEINT LPAR error RPAR  */
#line 376 "jucompiler.y"
                               { (yyval.node) = NULL; num_errors++; }
#line 1993 "y.tab.c"
    break;

  case 54: /* Expr: Expr PLUS Expr  */
#line 380 "jucompiler.y"
                       { (yyval.node) = newnode(Add, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 1999 "y.tab.c"
    break;

  case 55: /* Expr: Expr MINUS Expr  */
#line 381 "jucompiler.y"
                       { (yyval.node) = newnode(Sub, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2005 "y.tab.c"
    break;

  case 56: /* Expr: Expr STAR Expr  */
#line 382 "jucompiler.y"
                       { (yyval.node) = newnode(Mul, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2011 "y.tab.c"
    break;

  case 57: /* Expr: Expr DIV Expr  */
#line 383 "jucompiler.y"
                       { (yyval.node) = newnode(Div, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2017 "y.tab.c"
    break;

  case 58: /* Expr: Expr MOD Expr  */
#line 384 "jucompiler.y"
                       { (yyval.node) = newnode(Mod, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2023 "y.tab.c"
    break;

  case 59: /* Expr: Expr AND Expr  */
#line 385 "jucompiler.y"
                       { (yyval.node) = newnode(And, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2029 "y.tab.c"
    break;

  case 60: /* Expr: Expr OR Expr  */
#line 386 "jucompiler.y"
                       { (yyval.node) = newnode(Or, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2035 "y.tab.c"
    break;

  case 61: /* Expr: Expr XOR Expr  */
#line 387 "jucompiler.y"
                       { (yyval.node) = newnode(Xor, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2041 "y.tab.c"
    break;

  case 62: /* Expr: Expr LSHIFT Expr  */
#line 388 "jucompiler.y"
                       { (yyval.node) = newnode(Lshift, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2047 "y.tab.c"
    break;

  case 63: /* Expr: Expr RSHIFT Expr  */
#line 389 "jucompiler.y"
                       { (yyval.node) = newnode(Rshift, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2053 "y.tab.c"
    break;

  case 64: /* Expr: Expr EQ Expr  */
#line 390 "jucompiler.y"
                       { (yyval.node) = newnode(Eq, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2059 "y.tab.c"
    break;

  case 65: /* Expr: Expr GE Expr  */
#line 391 "jucompiler.y"
                       { (yyval.node) = newnode(Ge, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2065 "y.tab.c"
    break;

  case 66: /* Expr: Expr GT Expr  */
#line 392 "jucompiler.y"
                       { (yyval.node) = newnode(Gt, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2071 "y.tab.c"
    break;

  case 67: /* Expr: Expr LE Expr  */
#line 393 "jucompiler.y"
                       { (yyval.node) = newnode(Le, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2077 "y.tab.c"
    break;

  case 68: /* Expr: Expr LT Expr  */
#line 394 "jucompiler.y"
                       { (yyval.node) = newnode(Lt, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2083 "y.tab.c"
    break;

  case 69: /* Expr: Expr NE Expr  */
#line 395 "jucompiler.y"
                       { (yyval.node) = newnode(Ne, NULL); addchild((yyval.node), (yyvsp[-2].node)); addchild((yyval.node), (yyvsp[0].node)); }
#line 2089 "y.tab.c"
    break;

  case 70: /* Expr: MINUS Expr  */
#line 397 "jucompiler.y"
                                   { (yyval.node) = newnode(Minus, NULL); addchild((yyval.node), (yyvsp[0].node)); }
#line 2095 "y.tab.c"
    break;

  case 71: /* Expr: PLUS Expr  */
#line 398 "jucompiler.y"
                                   { (yyval.node) = newnode(Plus, NULL); addchild((yyval.node), (yyvsp[0].node)); }
#line 2101 "y.tab.c"
    break;

  case 72: /* Expr: NOT Expr  */
#line 399 "jucompiler.y"
                                   { (yyval.node) = newnode(Not, NULL); addchild((yyval.node), (yyvsp[0].node)); }
#line 2107 "y.tab.c"
    break;

  case 73: /* Expr: LPAR Expr RPAR  */
#line 401 "jucompiler.y"
                                   { (yyval.node) = (yyvsp[-1].node); }
#line 2113 "y.tab.c"
    break;

  case 74: /* Expr: LPAR error RPAR  */
#line 402 "jucompiler.y"
                      { (yyval.node) = NULL; num_errors++; }
#line 2119 "y.tab.c"
    break;

  case 75: /* Expr: MethodInvocation  */
#line 404 "jucompiler.y"
                                   { (yyval.node) = (yyvsp[0].node); }
#line 2125 "y.tab.c"
    break;

  case 76: /* Expr: ParseArgs  */
#line 405 "jucompiler.y"
                                   { (yyval.node) = (yyvsp[0].node); }
#line 2131 "y.tab.c"
    break;

  case 77: /* Expr: IDENTIFIER DOTLENGTH  */
#line 407 "jucompiler.y"
                           { 
        (yyval.node) = newnode(Length, NULL); 
        addchild((yyval.node), newnode(Id, (yyvsp[-1].lexeme))); 
    }
#line 2140 "y.tab.c"
    break;

  case 78: /* Expr: IDENTIFIER  */
#line 412 "jucompiler.y"
                                   { (yyval.node) = newnode(Id, (yyvsp[0].lexeme)); }
#line 2146 "y.tab.c"
    break;

  case 79: /* Expr: NATURAL  */
#line 413 "jucompiler.y"
                                   { (yyval.node) = newnode(Natural, (yyvsp[0].lexeme)); }
#line 2152 "y.tab.c"
    break;

  case 80: /* Expr: DECIMAL  */
#line 414 "jucompiler.y"
                                   { (yyval.node) = newnode(Decimal, (yyvsp[0].lexeme)); }
#line 2158 "y.tab.c"
    break;

  case 81: /* Expr: BOOLLIT  */
#line 415 "jucompiler.y"
                                   { (yyval.node) = newnode(BoolLit, (yyvsp[0].lexeme)); }
#line 2164 "y.tab.c"
    break;


#line 2168 "y.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;
  ++yynerrs;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturnlab;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturnlab;


/*-----------------------------------------------------------.
| yyexhaustedlab -- YYNOMEM (memory exhaustion) comes here.  |
`-----------------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturnlab;


/*----------------------------------------------------------.
| yyreturnlab -- parsing is finished, clean up and return.  |
`----------------------------------------------------------*/
yyreturnlab:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 418 "jucompiler.y"


int main(int argc, char *argv[]) {
    int flag_t = 0;

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
    }
    
    if (flag_l || flag_e1){
        while(yylex());
    } 
    else {
        yyparse();
        // Só imprime a árvore se os erros forem estritamente zero!
        if (num_errors == 0 && flag_t == 1) { 
            print_ast(ast_root, 0);
        }
    }
    
    return 0;
}

extern char error_token[]; // Puxa o token seguro do Lexer
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
