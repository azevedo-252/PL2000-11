
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
     PROGRAM = 258,
     DECLARATIONS = 259,
     STATEMENTS = 260,
     ARROW = 261,
     INTEGER = 262,
     BOOLEAN = 263,
     FORWARD = 264,
     BACKWARD = 265,
     RRIGHT = 266,
     RLEFT = 267,
     PEN = 268,
     UP = 269,
     DOWN = 270,
     GOTO = 271,
     WHERE = 272,
     OR = 273,
     AND = 274,
     POW = 275,
     EQUAL = 276,
     DIF = 277,
     MINOREQUAL = 278,
     MAJOREQUAL = 279,
     IN = 280,
     SAY = 281,
     ASK = 282,
     IF = 283,
     THEN = 284,
     ELSE = 285,
     WHILE = 286,
     TRUE = 287,
     FALSE = 288,
     IDENTIFIER = 289,
     NUMBER = 290,
     STRING = 291,
     SUCC = 292,
     PRED = 293,
     MAJOR = 294,
     MINOR = 295
   };
#endif
/* Tokens.  */
#define PROGRAM 258
#define DECLARATIONS 259
#define STATEMENTS 260
#define ARROW 261
#define INTEGER 262
#define BOOLEAN 263
#define FORWARD 264
#define BACKWARD 265
#define RRIGHT 266
#define RLEFT 267
#define PEN 268
#define UP 269
#define DOWN 270
#define GOTO 271
#define WHERE 272
#define OR 273
#define AND 274
#define POW 275
#define EQUAL 276
#define DIF 277
#define MINOREQUAL 278
#define MAJOREQUAL 279
#define IN 280
#define SAY 281
#define ASK 282
#define IF 283
#define THEN 284
#define ELSE 285
#define WHILE 286
#define TRUE 287
#define FALSE 288
#define IDENTIFIER 289
#define NUMBER 290
#define STRING 291
#define SUCC 292
#define PRED 293
#define MAJOR 294
#define MINOR 295




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 26 "logo.y"

	int intvalue;
	char* stringvalue;
	VarTipo *varTipo;
	ConstTipo *constTipo;



/* Line 1676 of yacc.c  */
#line 141 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


