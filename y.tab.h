
/* A Bison parser, made by GNU Bison 2.4.1.  */

/* Skeleton interface for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.
   
   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     BODY = 258,
     PROGRAM = 259,
     DECLARATIONS = 260,
     STATEMENTS = 261,
     ARROW = 262,
     INTEGER = 263,
     BOOLEAN = 264,
     ARRAY = 265,
     SIZE = 266,
     TRUE = 267,
     FALSE = 268,
     FORWARD = 269,
     BACKWARD = 270,
     RRIGHT = 271,
     RLEFT = 272,
     PEN = 273,
     UP = 274,
     DOWN = 275,
     GOTO = 276,
     WHERE = 277,
     OR = 278,
     AND = 279,
     POW = 280,
     DOUBLEEQUAL = 281,
     DIFFERENT = 282,
     MENOREQUAL = 283,
     MAIOREQUAL = 284,
     IN = 285,
     SUCC = 286,
     PRED = 287,
     SAY = 288,
     ASK = 289,
     IF = 290,
     THEN = 291,
     ELSE = 292,
     WHILE = 293,
     identifier = 294,
     number = 295,
     string = 296
   };
#endif
/* Tokens.  */
#define BODY 258
#define PROGRAM 259
#define DECLARATIONS 260
#define STATEMENTS 261
#define ARROW 262
#define INTEGER 263
#define BOOLEAN 264
#define ARRAY 265
#define SIZE 266
#define TRUE 267
#define FALSE 268
#define FORWARD 269
#define BACKWARD 270
#define RRIGHT 271
#define RLEFT 272
#define PEN 273
#define UP 274
#define DOWN 275
#define GOTO 276
#define WHERE 277
#define OR 278
#define AND 279
#define POW 280
#define DOUBLEEQUAL 281
#define DIFFERENT 282
#define MENOREQUAL 283
#define MAIOREQUAL 284
#define IN 285
#define SUCC 286
#define PRED 287
#define SAY 288
#define ASK 289
#define IF 290
#define THEN 291
#define ELSE 292
#define WHILE 293
#define identifier 294
#define number 295
#define string 296




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 5 "logo.y"

	int intvalue;
	char* stringvalue;



/* Line 1676 of yacc.c  */
#line 141 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


