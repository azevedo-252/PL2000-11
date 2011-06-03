%{
	#include <stdio.h>
	#include "structures.h"

	int addressG = 0;

	ListaVars *nodo;

%}


/*%token ARRAY SIZE*/
%token PROGRAM DECLARATIONS STATEMENTS ARROW INTEGER BOOLEAN STRING FORWARD BACKWARD RRIGHT RLEFT
%token PEN UP DOWN GOTO WHERE OR AND POW EQUAL DIF MINOREQUAL MAJOREQUAL IN SAY ASK IF THEN ELSE WHILE
%token <stringvalue>TRUE FALSE IDENTIFIER NUMBER STR SUCC PRED

%left MINOR MAJOR MINOREQUAL MAJOREQUAL EQUAL AND POW DIF OR
%left <stringvalue>'+' '-'
%left '*' '/'


/* TODO verficiar depois o que é e nao é preciso */
%type <stringvalue>Factor Term Single_Expression Expression SuccPred
%type <intvalue>Type SuccOrPred Add_Op Mul_Op
%type <varTipo>Var 
%type <constTipo>Constant Value_Var Inic_Var

%union{
	int intvalue;
	char* stringvalue;
	VarTipo *varTipo;
	ConstTipo *constTipo;
}




%start Liss

%%



Liss 			: PROGRAM IDENTIFIER '{' Body '}' {printf("stop\n");}
			;
	
Body 			: DECLARATIONS Declarations STATEMENTS Statements {}
			;


Declarations		: Declaration
			| Declarations Declaration
			;
	
Declaration 		: Variable_Declaration
			;



Variable_Declaration 	: Vars ARROW Type ';' 	{
							ListaVars *aux = nodo;
							while(aux) {
								// verficiar na hashtable se ja existe uma variavel com este nome, se ja passa para a proxima var
								// insere nome, tipo e address na hashtable
								switch($3) {
									case 0:
									break;
								}
							}
						}
			;

Vars 			: Var 	{insereEmListaVars($1, 0);
				}
			| Vars ',' Var 	{insereEmListaVars($3, 1);
					}
			;

Var 			: IDENTIFIER Value_Var {
							$$->id=$1;
							$$->type=$2->type;
							if ($2->type != -1) {
								$$->value=$2->value;
							}
					       }
			;
	
Value_Var 		: {$$->type=-1;}
			| '=' Inic_Var {$$=$2;}
			;

Type 			: INTEGER {$$ = 0;}
			| BOOLEAN {$$ = 1;}	
			| STRING  {$$ = 2;}
			/*| ARRAY SIZE NUMBER*/
			;
	
Inic_Var 		: Constant {$$ = $1;}
			/*| Array_Definition*/
			;
	
Constant	 	: NUMBER {$$->value = $1; $$->type=0;}
			| STR 	 {$$->value = $1; $$->type=1;}
			| TRUE   {$$->value = $1; $$->type=2;}
			| FALSE  {$$->value = $1; $$->type=2;}
			;
	


Array_Definition 	: '[' Array_Initialization ']'
			;
	
Array_Initialization 	: Elem
			| Array_Initialization ',' Elem
			;
	
Elem 			: NUMBER
			;
	


Statements 		: Statement ';'
			| Statements Statement ';'
			;
	
Statement 		: Turtle_Commands
			| Assignment
			| Conditional_Statement
			| Iterative_Statement
			;
	


Turtle_Commands 	: Step
			| Rotate
			| Mode
			| Dialogue
			| Location
			;

Step 			: FORWARD Expression 
			| BACKWARD Expression
			;

Rotate 			: RRIGHT
			| RLEFT
			;
	
Mode 			: PEN UP
			| PEN DOWN
			;
	
Dialogue 		: Say_Statement
			| Ask_Statement
			;
	
Location 		: GOTO NUMBER ',' NUMBER
			| WHERE '?'
			;
	


Assignment 		: Variable '=' Expression
			;
	
Variable 		: IDENTIFIER Array_Acess
			;
	
Array_Acess 		:
			| '[' Single_Expression ']'
			;
	


Expression 		: Single_Expression
			| Expression Rel_Op Single_Expression    //VER ISTO! ESTAVA REL_OPER, MAS ACHO QUE E REL_OP
			;
	


Single_Expression 	: Term
			| Single_Expression Add_Op Term
			;



Term 			: Factor
			| Term Mul_Op Factor
			;	



Factor 			: Constant
			| Variable
			| SuccOrPred
			| '(' Expression ')'
			;
	


Add_Op  		: '+'
			| '-'
			| OR
			;
	
Mul_Op 			: '*'
			| '/'
			| AND
			| POW
			;
	 
Rel_Op 			: EQUAL
			| DIF 
			| MAJOR 
			| MINOR
			| MAJOREQUAL
			| MINOREQUAL
			| IN
			;
	


SuccOrPred 		: SuccPred IDENTIFIER
			;
	
SuccPred 		: SUCC
			| PRED
			;



Say_Statement 		: SAY '(' Expression ')'
			;
	
Ask_Statement 		: ASK '(' STR ',' Variable ')'
			;
	


Conditional_Statement	: IfThenElse_Stat
			;
	
Iterative_Statement 	: While_Stat
			;
	


IfThenElse_Stat 	: IF Expression THEN '{' Statements '}' Else_Expression
			;

Else_Expression 	:
			| ELSE '{' Statements '}'
			;
	


While_Stat 		: WHILE '(' Expression ')' '{' Statements '}'
			;

%%

void insereEmListaVars(VarTipo *var, int first){
	ListaVars *aux = (ListaVars*)malloc(sizeof(ListaVars));
	aux->id = var->id;
	aux->value = var->value;
	aux->type = var->type;
	if(first == 1){aux->next = NULL;}
	else {aux->next = nodo;}
	nodo = aux;
}

int yyerror(char *s){
	fprintf(stderr, "ERRO: %s \n", s);
	return 0;
}

int main() {
	//nodo = NULL;
	//inithashtab();
	yyparse();
	return 0;
}	
