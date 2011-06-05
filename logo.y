%{
	#include <stdlib.h>
	#include <stdio.h>
	#include <ctype.h>
	#include <string.h>
	#include "structures.h"
	#include "hashFunctions.h"

	int addressG = 0;
	extern int height, width, xpos, ypos, raio;
	extern Direccao direccao;
	extern int mode; // PEN UP

	extern char* yytext;
	extern int yylineno;	

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
%type <stringvalue>SuccPred
%type <intvalue>Type SuccOrPred Add_Op Mul_Op Rel_Op Factor Term Single_Expression Array_Acess Expression
%type <varTipo>Var Variable
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
	
Body 			: DECLARATIONS 	{
							height = 100;
							width = 100;
							xpos = 50;
							ypos = 50;
							raio = 5;
							mode = 0;
							direccao = up;
							init();
							}Declarations

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

Vars 			: Var 	{insertInListaVars($1, 1);
				}
			| Vars ',' Var 	{insertInListaVars($3, 0);
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


/*
Array_Definition 	: '[' Array_Initialization ']'
			;
	
Array_Initialization 	: Elem
			| Array_Initialization ',' Elem
			;
	
Elem 			: NUMBER
			;
*/	


/***************************Statements**************/

Statements 		: Statement ';' 
			| Statements Statement ';'{/*printf(">>>>>>>>>>>>>>>>>Fim de uma Statement\n");*/}
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

Step 			: FORWARD Expression 			{
								VarData aux;
								switch(direccao){
									case(up):
										aux = searchVar("xpos");
										printf("PUSHG %d\n", aux->address);
										printf("SUB\n");
										printf("STOREG %d\n", aux->address);
										break;
									case(down):
										aux = searchVar("xpos");
										printf("PUSHG %d\n", aux->address);
										printf("ADD\n");
										printf("STOREG %d\n", aux->address);
										break;
									case(right):
										aux = searchVar("ypos");
										printf("PUSHG %d\n", aux->address);
										printf("ADD\n");
										printf("STOREG %d\n", aux->address);
										break;
									case(left):
										aux = searchVar("ypos");
										printf("PUSHG %d\n", aux->address);
										printf("SUB\n");
										printf("STOREG %d\n", aux->address);
										break;
									default:
										break;
								}
								drawTurtle();
								}
			| BACKWARD Expression			{
								VarData aux;
                                                                switch(direccao){
                                                                        case(up):
                                                                                aux = searchVar("xpos");
                                                                                printf("PUSHG %d\n", aux->address);
                                                                                printf("ADD\n");
                                                                                printf("STOREG %d\n", aux->address);
										drawLine(xpos+$2,ypos);
                                                                                break;
                                                                        case(down):
                                                                                aux = searchVar("xpos");
                                                                                printf("PUSHG %d\n", aux->address);
                                                                                printf("SUB\n");
                                                                                printf("STOREG %d\n", aux->address);
										drawLine(xpos-$2,ypos);
                                                                                break;
                                                                        case(right):
                                                                                aux = searchVar("ypos");
                                                                                printf("PUSHG %d\n", aux->address);
                                                                                printf("SUB\n");
                                                                                printf("STOREG %d\n", aux->address);
										drawLine(xpos,ypos-$2);
                                                                                break;
                                                                        case(left):
                                                                                aux = searchVar("ypos");
                                                                                printf("PUSHG %d\n", aux->address);
                                                                                printf("ADD\n");
                                                                                printf("STOREG %d\n", aux->address);
										drawLine(xpos,ypos+$2);
                                                                                break;
                                                                        default:
                                                                                break;
								}
								drawTurtle();
								}
			;

Rotate 			: RRIGHT				{
								switch(direccao){
									case(up):
										direccao = right;
										break;
									case(right):
										direccao = down;
										break;
									case(down):
										direccao = left;
										break;
									default:
										direccao = up;
										break;
								}
								}
			| RLEFT					{
								switch(direccao){
									case(up):
										direccao = left;
										break;
									case(left):
										direccao = down;
										break;
									case(down):
										direccao = right;
										break;
									default:
										direccao = up;
										break;
								}
								}
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


Assignment 		: Variable '=' Expression 	{
								VarData var =  searchVar($1.id);
								if (var) printf("STOREG %d\n",var->address);
								else yyerror("Variable undeclared!\n");
							}
			;
	
Variable 		: IDENTIFIER Array_Acess {$$.id = $1;}
			;
	
Array_Acess 		:
			| '[' Single_Expression ']'		{ $$ = $2; }
			;
	

/***************************Expression**************/

Expression 		: Single_Expression			{ $$ = $1; }
			| Expression Rel_Op Single_Expression	{
								switch($2){
									case(1):
										printf("PUSHI %d\n", ($1 == $3));
										$$ = ($1 == $3);
										break;
									case(2):
										printf("PUSHI %d\n", ($1 != $3));
										$$ = ($1 != $3);
										break;
									case(3):
										printf("PUSHI %d\n", $1);
										printf("PUSHI %d\n", $3);
										printf("SUP\n");
										$$ = ($1 > $3);
										break;
									case(4):
										printf("PUSHI %d\n", $1);
										printf("PUSHI %d\n", $3);
										printf("INF\n");
										$$ = ($1 < $3);
										break;
									case(5):
										printf("PUSHI %d\n", $1);
										printf("PUSHI %d\n", $3);
										printf("SUPEQ\n");
										$$ = ($1 >= $3);
										break;
									case(6):
										printf("PUSHI %d\n", $1);
										printf("PUSHI %d\n", $3);
										printf("INFEQ\n");
										$$ = ($1 <= $3);
										break;
									default:				//TODO ver o que faz o in, que acho que e para arrays...
										yyerror("Unknown operation\n");
										break;
									
								}
								}
			;
	

/***************************Single Expression**************/

Single_Expression 	: Term					{ $$ = $1; }
			| Single_Expression Add_Op Term		{
								//printf("PUSHI %d\n", $1);
								//printf("PUSHI %d\n", $3);
								switch($2){
									case(1):
										printf("add\n");
										break;
									case(2):
										printf("sub\n");
										break;
									case(3):
										printf("pop 2\n");
										if($1 > 0 || $3 > 0) printf("PUSHI 1\n");
										else printf("PUSHI 0\n");
										break;
									default:
										yyerror("Unknown operation\n");
										break;
								}
								}
			;


/***************************Term**************/

Term 			: Factor				{ $$ = $1; }
			| Term Mul_Op Factor			{
								//printf("PUSHI %d\n", $1);
								//printf("PUSHI %d\n", $3); 
								switch($2){
									case(1):
										printf("mul\n");
										break;
									case(2):
										if($3 == 0){
											yyerror("Divide by 0\n");
											exit(0);
										}
										printf("div \n");
										break;
									case(3):
										printf("pop 2\n");
										if($1 > 0 && $3 > 0) printf("PUSHI 1\n");    //Maior que 0 ou diferente de 0???
										else printf("PUSHI 0\n");
									case(4):
										printf("pop 1\n");  //Para retirar o $3
										while($3 > 1){
											printf("PUSHI %d\n", $1);
											printf("mul\n");
											$3--;
										}
									default:
										yyerror("Unknown operation\n");
										break;
									}
								}
			;	


/***************************Factor**************/

Factor 			: Constant				{pushValues($1.type,0,$1.value); 
								/*TabelaHash *const = procuraLista($1);    ->   PROCURAR A VARIAVEL NA TABELA DE HASH*/
								  //printf("PUSHI %d\n", $1.value);
								  //$$ = atoi($1.value);       //atoi(const.value);



								  /*$$->consttipo.value = $1.value;
								  $$->consttipo.type = $1.type;*/
								}
			| Variable				{ /*TabelaHash *var = procuraLista($1);*/

								  VarData var = searchVar ($1.id);
								  if(var)printf("PUSHG %d\n", var->address);
								  else yyerror("Variable undeclared!\n");
								}
			| SuccOrPred		{ $$ = $1; }
			| '(' Expression ')'	{ $$ = $2; }
			;
	

/***************************Operators**************/

Add_Op  		: '+'			{ $$ = 1; }
			| '-'			{ $$ = 2; }
			| OR			{ $$ = 3; }
			;
	
Mul_Op 			: '*'			{ $$ = 1; }
			| '/'			{ $$ = 2; }
			| AND			{ $$ = 3; }
			| POW			{ $$ = 4; }
			;
	 
Rel_Op 			: EQUAL			{ $$ = 1; }
			| DIF 			{ $$ = 2; }
			| MAJOR 		{ $$ = 3; }
			| MINOR			{ $$ = 4; }
			| MAJOREQUAL		{ $$ = 5; }
			| MINOREQUAL		{ $$ = 6; }
			/*| IN			{ $$ = $1; }*/       //PENSO QUE SEJA SO PARA ARRAYS
			;
	

/***************************SuccOrPred**************/

SuccOrPred 		: SuccPred IDENTIFIER		{ VarData var = searchVar($2);
							  if (var) {
							  	printf("store %d\n", var->address);
								  printf("PUSHI %d\n", atoi($1));
								  printf("add\n");
							  }
							  else yyerror("Variable undeclared!\n");
							}
			;
	
SuccPred 		: SUCC				{ $$ = "1"; }
			| PRED				{ $$ = "-1"; }
			;


/***************************IO Statements***********/
	
Say_Statement 		: SAY '(' Expression ')'		{ printf("writei\n"); }
			;
	
Ask_Statement 		: ASK '(' STR ',' Variable ')'		{ 
							          printf("pushs %s\n",$3); 	// guardar na stack a STR a perguntar
								  printf("writes\n"); 		// escrever a STR a perguntar
							 	  printf("read\n"); 		/* lê uma string do teclado (concluída por um "\n") 
										       		   e arquiva esta string (sem o "\n") na heap e coloca
                                                                                       		   (empilha) o endereço na pilha..
									            		*/
								  printf("atoi\n"); 		// variaveis só podem ser integer ou boolean 	
								  if(!searchVar($5.id)) yyerror("Variable undeclared!\n");
								  else {
								  	VarData var = searchVar($5.id);
								  	printf("storeg %d\n",var->address);
								  }
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
	if(first == 1){aux->next = NULL;}
	else {aux->next = nodo;}
	nodo = aux;
	
}

void saveVars(int type){
//	printListaVars();

	ListaVars *aux = nodo;
	while(aux) {
		if(!searchVar(aux->id)){//printf("AQUI\t%s\thash:%d\n",aux->id,hash(aux->id));
			// insere nome, tipo e address na hashtable
			insertVar(aux->id, type, addressG);
			pushValues(type,aux->type, aux->value);
			printf("STOREG %d\n",addressG);
			addressG++;
		}
		aux=aux->next;
	}
	nodo = NULL;

}

void pushValues(int varType, int nullType, char* value){
	switch(varType) {
		case 0://INTEGER
			if (nullType == -1) {//VAZIO
				printf("PUSHI 0\n");
			}
			else {
				printf("PUSHI %d\n",atoi(value));
			}
		break;
		case 1://BOOLEAN
			if (nullType==-1 || strcmp(value,"TRUE")==0) {
				printf("PUSHI 1\n");

			}
			else if (strcmp(value, "FALSE")==0) {
				printf("PUSHI 0\n");
			}
		break;
		case 2://STRING
			if (nullType == -1) {
				printf("pushs \"\"\n");
			}
			else {
				printf("pushs %s\n",value);
			}
		break;
		// nao estamos a fazer arrays para ja
	}
}

/*char *stringToUpper(char* string){
	int i;
	char* new;
	for (i=0; i<strlen(string); i++)
		new[i]=toupper(string[i]);
	return new;
}*/

void drawTurtle(){
	VarData aux, aux2, aux3;
	aux = searchVar("raio");
	printf("PUSHG %d\n", aux->address);
	aux2 = searchVar("ypos");
        printf("PUSHG %d\n", aux2->address);
	aux3 = searchVar("xpos");
        printf("PUSHG %d\n", aux3->address);
	printf("DRAWCIRCLE\n");
	printf("REFRESH\n");
}

void drawLine(int newx, int newy){
	if(mode == 1){ // PEN DOWN
		VarData aux1, aux2;
		printf("PUSHI %d\n", newy);
		printf("PUSHI %d\n", newx);
		aux1 = searchVar("ypos");
        	printf("PUSHG %d\n", aux1->address);
		aux2 = searchVar("xpos");
        	printf("PUSHG %d\n", aux2->address);
		printf("DRAWLINE\n");
		printf("REFRESH\n");	
	}
}

void init() {
	varHashTable = initHash();
	VarTipo var;
	
	var.id = "height";
	var.value = (char*)malloc(sizeof(10));
	sprintf(var.value, "%d", height);
	insertInListaVars(var, 1);
	
	var.id = "width";
	var.value = (char*)malloc(sizeof(10));
	sprintf(var.value, "%d", width);
	insertInListaVars(var, 0);
	
	var.id = "xpos";
	var.value = (char*)malloc(sizeof(10));
	sprintf(var.value, "%d", xpos);
	insertInListaVars(var, 0);

	var.id = "ypos";
	var.value = (char*)malloc(sizeof(10));
	sprintf(var.value, "%d", ypos);
	insertInListaVars(var, 0);

	var.id = "raio";
	var.value = (char*)malloc(sizeof(10));
	sprintf(var.value, "%d", raio);
	insertInListaVars(var, 0);
	
	saveVars(0);
	printf("START\n");
	initWindow();
	drawTurtle();
}

void initWindow(){
	printf("pushi %d\n",800);
        printf("pushi %d\n",600);
        printf("opendrawingarea\n");
}

void printListaVars(){
	ListaVars *aux = nodo;
	while(aux){
		printf("NODO: id=%s\tvalue=%s\ttype=%d\n",aux->id,aux->value,aux->type);
		aux = aux->next;
	}
	printf("ACABOU\n");
}

int yyerror(char *s){
       fprintf(stderr,"ERRO: %s na linha:%d antes de:%s\n",s,yylineno,yytext);
       return 0;
}

int main() {
	yyparse();
	return 0;
}	
