%{
#include "structures.h"
#include "hashFunctions.h"
#include "y.tab.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

%}

%option yylineno

PROGRAM 	[Pp][Rr][Oo][Gg][Rr][Aa][Mm]
DECLARATIONS 	[Dd][Ee][Cc][Ll][Aa][Rr][Aa][Tt][Ii][Oo][Nn][Ss]
STATEMENTS 	[Ss][Tt][Aa][Tt][Ee][Mm][Ee][Nn][Tt][Ss]
SUCC 		[Ss][Uu][Cc][Cc]
PRED 		[Pp][Rr][Ee][Dd]
IF 			[Ii][Ff]
ELSE		[Ee][Ll][Ss][Ee]
THEN		[Tt][Hh][Ee][Nn]
WHILE		[Ww][Hh][Ii][Ll][Ee]
INTEGER		[Ii][Nn][Tt][Ee][Gg][Ee][Rr]
BOOLEAN		[Bb][Oo][Oo][Ll][Ee][Aa][Nn]
STRING		[Ss][Tt][Rr][Ii][Nn][Gg]
ARRAY		[Aa][Rr][Rr][Aa][Yy]
SIZE		[Ss][Ii][Zz][Ee]
TRUE		[T][R][U][E]
FALSE		[F][A][L][S][E]
FORWARD		[Ff][Oo][Rr][Ww][Aa][Rr][Dd]
BACKWARD	[Bb][Aa][Cc][Kk][Ww][Aa][Rr][Dd]
RRIGHT		[Rr][Rr][Ii][Gg][Hh][Tt]
RLEFT		[Rr][Ll][Ee][Ff][Tt]
PEN			[Pp][Ee][Nn]
UP			[Uu][Pp]
DOWN		[Dd][Oo][Ww][Nn]
GOTO		[Gg][Oo][Tt][Oo]
WHERE		[Ww][Hh][Ee][Rr][Ee]
SAY			[Ss][Aa][Yy]
ASK			[Aa][Ss][Kk]
IN			[Ii][Nn]

NUMBER 						[0-9]+
IDENTIFIER 					[a-zA-Z][a-zA-Z0-9]*
STR						\"([^"\n]|\\\")*\"

%%

{PROGRAM}					{ return PROGRAM; }
{DECLARATIONS}					{ return DECLARATIONS; }
{STATEMENTS}					{ return STATEMENTS; }
"->"						{ return ARROW; }
{INTEGER}					{ return INTEGER; }
{BOOLEAN}					{ return BOOLEAN; }
{STRING}					{ return STRING; }
{ARRAY}						{ /*return ARRAY;*/ }
{SIZE}						{ /*return SIZE;*/ }
{TRUE}						{ yylval.stringvalue=(char*)strdup(yytext); return TRUE; }
{FALSE}						{ yylval.stringvalue=(char*)strdup(yytext); return FALSE; }
{FORWARD}					{ return FORWARD; }
{BACKWARD}					{ return BACKWARD; }
{RRIGHT}					{ return RRIGHT; }
{RLEFT}						{ return RLEFT; }
{PEN}						{ return PEN; }
{UP}						{ return UP; }
{DOWN}						{ return DOWN; }
{GOTO}						{ return GOTO; }
{WHERE}						{ return WHERE; }
"||"						{ return OR; }
"&&"						{ return AND; }
"**"						{ return POW; }
"=="						{ return EQUAL; }
"!="						{ return DIF; }
"<"						{ return MINOR; }
">"						{ return MAJOR; }
"<="						{ return MINOREQUAL; }
">="						{ return MAJOREQUAL; }
{IN}						{ return IN; }
[=\-,;!?/()\[\]\{\}*+]				{return(yytext[0]);}
{SUCC}						{ yylval.stringvalue=(char*)strdup(yytext); return SUCC; }
{PRED}						{ yylval.stringvalue=(char*)strdup(yytext); return PRED; }
{SAY}						{ return SAY; }
{ASK}						{ return ASK; }
{IF}						{ return IF; }
{THEN}						{ return THEN; }
{ELSE}						{ return ELSE; }
{WHILE}						{ return WHILE; }

{NUMBER}					{ yylval.stringvalue = strdup(yytext); return NUMBER; }
{IDENTIFIER}					{ yylval.stringvalue = strdup(yytext); return IDENTIFIER; }
{STR}						{ yylval.stringvalue = strdup(yytext); return STR; }

[\ \n\t\r]+					{;}

<*>.|\n						{ fprintf(stderr,"ERRO: %d '%s'\n",yylineno, yytext);}

%%

int yywrap() {
 return 1;
}

/*int yyerror(char *s){
	fprintf(stderr,"ERRO: %d %s\n",yylineno, s);
	return 0;
}*/
