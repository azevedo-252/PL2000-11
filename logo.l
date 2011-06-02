%{
#include "y.tab.h"

%}



number 						[0-9]+
identifier 					[a-zA-Z][a-zA-Z0-9]*
string						\"([^"\n]|\\\")*\"

%%

"body"						{ return BODY; }
"program"					{ return PROGRAM; }
"declarations"					{ return DECLARATIONS; }
"statements"					{ return STATEMENTS; }
"->"						{ return ARROW; }
"integer"					{ return INTEGER; }
"boolean"					{ return BOOLEAN; }
"array"						{ return ARRAY; }
"size"						{ return SIZE; }
"true"						{ return TRUE; }
"false"						{ return FALSE; }
"forward"					{ return FORWARD; }
"backward"					{ return BACKWARD; }
"rright"					{ return RRIGHT; }
"rleft"						{ return RLEFT; }
"pen"						{ return PEN; }
"up"						{ return UP; }
"down"						{ return DOWN; }
"goto"						{ return GOTO; }
"where"						{ return WHERE; }
"||"						{ return OR; }
"&&"						{ return AND; }
"**"						{ return POW; }
"=="						{ return DOUBLEEQUAL; }
"!="						{ return DIFFERENT; }
"<="						{ return MENOREQUAL; }
">="						{ return MAIOREQUAL; }
"in"						{ return IN; }
"succ"						{ return SUCC; }
"pred"						{ return PRED; }
"say"						{ return SAY; }
"ask"						{ return ASK; }
"if"						{ return IF; }
"then"						{ return THEN; }
"else"						{ return ELSE; }
"while"						{ return WHILE; }

number						{ yylval.intvalue = atoi(yytext); return number; }
identifier					{ yylval.stringvalue = strdup(yytext); return identifier; }
string						{ yylval.stringvalue = strdup(yytext); return string; }
[<=>\-,;!?/()\[\]{}*+|&] 			{ return yytext[0]; }
[\n\t]						{ ; }

%%
