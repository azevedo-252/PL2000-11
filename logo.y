%{
	#include <stdio.h>

	//typedef struct {
	//	int cInt;
	//	char* cString;
	//}ConstTipo;

	int address = 0;

	typedef struct {
		char* id;
		char* atrib;
		int address;
		int type;
	}VarTipo;

%}

%union{
	int intvalue;
	char* stringvalue;
	//ConstTipo constTipo;
	VarTipo varTipo;
}


%token PROGRAM DECLARATIONS STATEMENTS ARROW INTEGER BOOLEAN ARRAY SIZE <stringvalue>TRUE <stringvalue>FALSE FORWARD BACKWARD RRIGHT RLEFT
%token PEN UP DOWN GOTO WHERE OR AND POW EQUAL DIF MINOREQUAL MAJOREQUAL IN <stringvalue>SUCC <stringvalue>PRED SAY ASK IF THEN ELSE WHILE
%token <stringvalue>IDENTIFIER <stringvalue>NUMBER <stringvalue>STRING

%left MINOR MAJOR MINOREQUAL MAJOREQUAL EQUAL AND POW DIF OR
%left <stringvalue>'+' '-'
%left '*' '/'


// TODO verficiar depois o que é e nao é preciso
%type <stringvalue>Constant Value_Var Inic_Var Factor Term Single_Expression Expression SuccPred
%type <varTipo>Var 
%type <intvalue>Type <intvalue>SuccOrPred <intvalue>Add_Op <intvalue>Mul_Op


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



Variable_Declaration 	: Vars ARROW Type ';' {}
			;

Vars 			: Var {/*aqui fazemos push(i ou s tirado do atrib do $1) e depois inserimos o nome e endereco na hashtable*/}
			| Vars ',' Var {/*penso que seja o mesmo (tirado de $3)*/}
			;

Var 			: IDENTIFIER Value_Var {/*preencher o $$ (VarTipo) com o id ($1) e o atributo ($2), se $2 for vazio por atributo a ""*/}
			;
	
Value_Var 		: {$$ = "";}
			| '=' Inic_Var
			;

Type : INTEGER
	| BOOLEAN	
	| ARRAY SIZE NUMBER
	;
	
Inic_Var : Constant
	| Array_Definition
	;
	
Constant : NUMBER
	| STRING
	| 'TRUE'
	| 'FALSE'
	;
	


Array_Definition : '[' Array_Initialization ']'
	;
	
Array_Initialization : Elem
	| Array_Initialization ',' Elem
	;
	
Elem : NUMBER
	;
	


Statements : Statement ';'
	| Statements Statement ';'
	;
	
Statement : Turtle_Commands
	| Assignment
	| Conditional_Statement
	| Iterative_Statement
	;
	


Turtle_Commands : Step
	| Rotate
	| Mode
	| Dialogue
	| Location
	;

Step : 'FORWARD' Expression
	| 'BACKWARD' Expression
	;

Rotate : 'RRIGHT'
	| 'RLEFT'
	;
	
Mode : 'PEN' 'UP'
	| 'PEN' 'DOWN'
	;
	
Dialogue : Say_Statement
	| Ask_Statement
	;
	
Location : 'GOTO' NUMBER ',' NUMBER
	| 'WHERE' '?'
	;
	


Assignment : Variable '=' Expression
	;
	
Variable : IDENTIFIER Array_Acess
	;
	
Array_Acess :
	| '[' Single_Expression ']'
	;
	


Expression : Single_Expression
	| Expression Rel_Op Single_Expression    //VER ISTO! ESTAVA REL_OPER, MAS ACHO QUE E REL_OP
	;
	


Single_Expression : Term
	| Single_Expression Add_Op Term
	;



Term : Factor
	| Term Mul_Op Factor
	;



Factor : Constant
	| Variable
	| SuccOrPred
	| '(' Expression ')'
	;
	


ADD_OP  : '+'
	| '-'
	| '||'
	;
	
Mul_Op : '*'
	| '/'
	| '&&'
	| '**'
	;
	 
Rel_Op : '=='
	| '=!' 
	| '>' 
	| '<'
	| '=>'
	| '=<'
	| 'in'
	;
	


SuccOrPred : SuccPred IDENTIFIER
	;
	
SuccPred : 'SUCC'
	| 'PRED'
	;



Say_Statement : 'SAY' '(' Expression ')'
	;
	
Ask_Statement : 'ASK' '(' STRING ',' Variable ')'
	;
	


Conditional_Statement : IfThenElse_Stat
	;
	
Iterative_Statement : While_Stat
	;
	


IfThenElse_Stat : 'IF' Expression 'THEN' '{' Statements '}' Else_Expression
	;

Else_Expression :
	| 'ELSE' '{' Statements '}'
	;
	


While_Stat : 'WHILE' '(' Expression ')' '{' Statements '}'	
