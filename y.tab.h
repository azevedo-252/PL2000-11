
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
     STRING = 264,
     FORWARD = 265,
     BACKWARD = 266,
     RRIGHT = 267,
     RLEFT = 268,
     PEN = 269,
     UP = 270,
     DOWN = 271,
     GOTO = 272,
     WHERE = 273,
     OR = 274,
     AND = 275,
     POW = 276,
     EQUAL = 277,
     DIF = 278,
     MINOREQUAL = 279,
     MAJOREQUAL = 280,
     IN = 281,
     SAY = 282,
     ASK = 283,
     IF = 284,
     THEN = 285,
     ELSE = 286,
     WHILE = 287,
     TRUE = 288,
     FALSE = 289,
     IDENTIFIER = 290,
     NUMBER = 291,
     STR = 292,
     SUCC = 293,
     PRED = 294,
     MAJOR = 295,
     MINOR = 296
   };
#endif
/* Tokens.  */
#define PROGRAM 258
#define DECLARATIONS 259
#define STATEMENTS 260
#define ARROW 261
#define INTEGER 262
#define BOOLEAN 263
#define STRING 264
#define FORWARD 265
#define BACKWARD 266
#define RRIGHT 267
#define RLEFT 268
#define PEN 269
#define UP 270
#define DOWN 271
#define GOTO 272
#define WHERE 273
#define OR 274
#define AND 275
#define POW 276
#define EQUAL 277
#define DIF 278
#define MINOREQUAL 279
#define MAJOREQUAL 280
#define IN 281
#define SAY 282
#define ASK 283
#define IF 284
#define THEN 285
#define ELSE 286
#define WHILE 287
#define TRUE 288
#define FALSE 289
#define IDENTIFIER 290
#define NUMBER 291
#define STR 292
#define SUCC 293
#define PRED 294
#define MAJOR 295
#define MINOR 296




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
{

/* Line 1676 of yacc.c  */
#line 35 "logo.y"

	int intvalue;
	char* stringvalue;
	VarTipo varTipo;
	ConstTipo constTipo;



/* Line 1676 of yacc.c  */
#line 143 "y.tab.h"
} YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif

extern YYSTYPE yylval;


