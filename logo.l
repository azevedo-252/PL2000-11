%{
#include "y.tab.h"

%}



number 						[0-9]+
identifier 					[a-zA-Z][a-zA-Z0-9]*
string						\"([^"\n]|\\\")*\"

%%

"program"					{ return PROGRAM; }
"declarations"					{ return DECLARATIONS; }
"statements"					{ return STATEMENTS; }
"->"						{ return ARROW; }
"integer"					{ return INTEGER; }
"boolean"					{ return BOOLEAN; }
"array"						{ return ARRAY; }
"size"						{ return SIZE; }
"true"						{ yylval.stringvalue=(char*)strdup(yytext); return TRUE; }
"false"						{ yylval.stringvalue=(char*)strdup(yytext); return FALSE; }
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
"=="						{ return EQUAL; }
"!="						{ return DIF; }
"<"						{ return MINOR; }
">"						{ return MAJOR; }
"<="						{ return MINOREQUAL; }
">="						{ return MAJOREQUAL; }
"in"						{ return IN; }
[+-]						{ yylval.stringvalue=(char*)strdup(yytext); return yytext[0]; }
[,;<>]						{ return yytext[0]; }
[?\[\]()/!*]					{ return yytext[0]; }
[{]						{ return yytext[0]; }
[}]						{ return yytext[0]; }
[=]						{ return yytext[0]; }
"succ"						{ yylval.stringvalue=(char*)strdup(yytext); return SUCC; }
"pred"						{ yylval.stringvalue=(char*)strdup(yytext); return PRED; }
"say"						{ return SAY; }
"ask"						{ return ASK; }
"if"						{ return IF; }
"then"						{ return THEN; }
"else"						{ return ELSE; }
"while"						{ return WHILE; }

{number}					{ yylval.intvalue = atoi(yytext); return number; }
{identifier}					{ yylval.stringvalue = strdup(yytext); return identifier; }
{string}					{ yylval.stringvalue = strdup(yytext); return string; }

[\n\t]						{ ; }

%%

int yywrap() {
 return 1;
}
