%{
	#include <stdio.h>
	#include <ctype.h>
	#include <string.h>
	#include "structures.h"
	#include "hashFunctions.h"

	int addressG = 0;

	extern ListaVars *nodo;
	extern VarHashTable varHashTable;

%}
%error-verbose

/*%token ARRAY SIZE*/
%token PROGRAM DECLARATIONS STATEMENTS ARROW INTEGER BOOLEAN STRING FORWARD BACKWARD RRIGHT RLEFT
%token PEN UP DOWN GOTO WHERE OR AND POW EQUAL DIF MINOREQUAL MAJOREQUAL IN SAY ASK IF THEN ELSE WHILE
%token <stringvalue>TRUE FALSE IDENTIFIER NUMBER STR SUCC PRED

%left MINOR MAJOR MINOREQUAL MAJOREQUAL EQUAL AND POW DIF OR
%left '+' '-'
%left '*' '/'


/* TODO verficiar depois o que é e nao é preciso */
%type <stringvalue>Factor Term Single_Expression Expression SuccPred
%type <intvalue>Type SuccOrPred Add_Op Mul_Op
%type <varTipo>Var 
%type <constTipo>Constant Value_Var Inic_Var

%union{
	int intvalue;
	char* stringvalue;
	VarTipo varTipo;
	ConstTipo constTipo;
}



%start Liss

%%

/***************************Program**************/

Liss 			: PROGRAM IDENTIFIER '{' Body '}' {printf("STOP\n");}
			;
	
Body 			: DECLARATIONS Declarations  {varHashTable = initHash();/*TODO Aqui é suposto haver algo de inicializao da tartaruga...*/printf("START\n");}
 			  STATEMENTS {/*printHash();*/} Statements
			;


/***************************Declarations**************/

Declarations		: Declaration
			| Declarations Declaration
			;
	
Declaration 		: Variable_Declaration
			;


/***************************Declarations: Variables**************/

Variable_Declaration 	: Vars ARROW Type ';' 	{saveVars($3);}
			;

Vars 			: Var 	{insertInListaVars($1, 0);
				}
			| Vars ',' Var 	{insertInListaVars($3, 1);
					}
			;

Var 			: IDENTIFIER Value_Var { 
							$$.id=$1;
							$$.type=$2.type;
							if ($2.type != -1) {
								$$.value=$2.value;
							}
					       }
			;
	
Value_Var 		: {$$.type=-1;}
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
	
Constant	 	: '(' NUMBER ')' {$$.value = $2; $$.type=0;}/* TODO so pus estes parentises aqui porque ha exemplos em que aparecem la */
			| STR 	 {$$.value = $1; $$.type=2;}
			| TRUE   {$$.value = $1; $$.type=1;}
			| FALSE  {$$.value = $1; $$.type=1;}
			;
	

/***************************Declarations: Variables: Array_Definition**************/


/*Array_Definition 	: '[' Array_Initialization ']'
			;
	
Array_Initialization 	: Elem
			| Array_Initialization ',' Elem
			;
	
Elem 			: NUMBER
			;
*/	


/***************************Statements**************/

Statements 		: Statement ';'
			| Statements Statement ';'
			;
	
Statement 		: Turtle_Commands
			| Assignment
			| Conditional_Statement
			| Iterative_Statement
			;
	

/***************************Turtle Statement**************/


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
	

/***************************Assignment Statement**************/


Assignment 		: Variable '=' Expression
			;
	
Variable 		: IDENTIFIER Array_Acess
			;
	
Array_Acess 		:
			| '[' Single_Expression ']'
			;
	

/***************************Expression**************/

Expression 		: Single_Expression
			| Expression Rel_Op Single_Expression   
			;
	

/***************************Single Expression**************/

Single_Expression 	: Term
			| Single_Expression Add_Op Term
			;


/***************************Term**************/

Term 			: Factor
			| Term Mul_Op Factor
			;	


/***************************Factor**************/

Factor 			: Constant
			| Variable
			| SuccOrPred
			| '(' Expression ')'
			;
	

/***************************Operators**************/

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
	

/***************************SuccOrPred**************/

SuccOrPred 		: SuccPred IDENTIFIER
			;
	
SuccPred 		: SUCC
			| PRED
			;


/***************************IO Statements***********/
	
Say_Statement 		: SAY '(' Expression ')'		{ 
								  switch($3.type){ // DEPENDE MUITO DE COMO FOR IMPLEMENTADO O EXPRESSION (FACTOR)
									case 0: //INTEGER
										printf("writei\n");
										break;
									case 1: //BOOLEAN
										// Não escreve nada
										break;
									case 2: //STRING
										printf("writes\n");
										break;
								  }
								}
			;
	
Ask_Statement 		: ASK '(' STR ',' Variable ')'		{ 
							          printf("pushs %s\n",$3); 	// guardar na stack a STR a perguntar
								  printf("writes\n"); 		// escrever a STR a perguntar
							 	  printf("read\n"); 		/* lê uma string do teclado (concluída por um "\n") 
										       		   e arquiva esta string (sem o "\n") na heap e coloca
                                                                                       		   (empilha) o endereço na pilha..
									            		*/
								  printf("atoi\n"); 		// variaveis só podem integer ou boolean 	
								  VarData var = VarData searchVar($5);
								  printf("storeg %d\n",var->address); // pode ser storef se for uma variavel local
								}
			;
	

/***************************Consitional & Iterative Statements*******/

Conditional_Statement	: IfThenElse_Stat
			;
	
Iterative_Statement 	: While_Stat
			;
	

/***************************IfThenElse_Stat*********/

IfThenElse_Stat 	: IF Expression THEN '{' Statements '}' Else_Expression
			;	

Else_Expression 	:
			| ELSE '{' Statements '}'
			;
	

/***************************While_Stat**************/

While_Stat 		: WHILE '(' Expression ')' '{' Statements '}'
			;

%%

void insertInListaVars(VarTipo var, int first){
	ListaVars *aux = (ListaVars*)malloc(sizeof(ListaVars));
	aux->id = var.id;
	aux->value = var.value;
	aux->type = var.type;
	if(first == 0){aux->next = NULL;}
	else {aux->next = nodo;}
	nodo = aux;
	
}

void saveVars(int type){
	//printListaVars();

	ListaVars *aux = nodo;
	while(aux) {
		if(!searchVar(aux->id)){
			// insere nome, tipo e address na hashtable
			insertVar(aux->id, type, addressG);
			switch(type) {
				case 0://INTEGER
					if (aux->type == -1) {//VAZIO
						printf("pushi 0\n");
					}
					else {
						printf("pushi %d\n",atoi(aux->value));
					}
				break;
				case 1://BOOLEAN
					if (aux->type==-1 || strcmp(aux->value,"TRUE")==0) {
						printf("pushi 1\n");
					}
					else if (strcmp(aux->value, "FALSE")==0) {
						printf("pushi 0\n");
					}
				break;
				case 2://STRING
					if (aux->type == -1) {
						printf("pushs \"\"\n");
					}
					else {
						printf("pushs %s\n",aux->value);
					}
				break;
				// nao estamos a fazer arrays para ja
			}
			addressG++;
		}
		aux=aux->next;
	}
	nodo = NULL;

}

/*char *stringToUpper(char* string){
	int i;
	char* new;
	for (i=0; i<strlen(string); i++)
		new[i]=toupper(string[i]);
	return new;
}*/

void printListaVars(){
	ListaVars *aux = nodo;
	while(aux){
		printf("NODO: id=%s\tvalue=%s\ttype=%d\n",aux->id,aux->value,aux->type);
		aux = aux->next;
	}
	printf("ACABOU\n");
}

int yyerror(char *s){
	fprintf(stderr, "ERRO: %s \n", s);
	return 0;
}

int main() {
	yyparse();
	return 0;
}	
