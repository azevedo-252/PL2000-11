%{
	#include <stdio.h>

	typedef struct {
		int cInt;
		char* cString;
	}ConstTipo;

	typedef struct {
		char* id;
		char* atrib;
	}VarTipo;

%}

%union{
	int intvalue;
	char* stringvalue;
	ConstTipo constTipo;
	VarTipo varTipo;
}


%token PROGRAM DECLARATIONS STATEMENTS ARROW INTEGER BOOLEAN ARRAY SIZE <stringvalue>TRUE <stringvalue>FALSE FORWARD BACKWARD RRIGHT RLEFT
%token PEN UP DOWN GOTO WHERE OR AND POW EQUAL DIF MINOREQUAL MAJOREQUAL IN <stringvalue>SUCC <stringvalue>PRED SAY ASK IF THEN ELSE WHILE
%token <stringvalue>identifier <intvalue>number <stringvalue>string

%left '<' '>' MINOREQUAL MAJOREQUAL EQUAL AND POW DIF OR
%left <vals>'+' '-'
%left '*' '/'


// TODO verficiar depois o que é e nao é preciso
%type <constTipo>Constant <constTipo>Value_Var <constTipo>Inic_Var <constTipo>Factor <constTipo>Term <constTipo>Single_Expression <cosntTipo>Expression
%type <stringvalue>SuccPred
%type <varTipo>Var 
%type <intvalue>Type <intvalue>SuccOrPred <intvalue>Add_Op <intvalue>Mul_Op


%start Liss

%%



Liss : PROGRAM identifier '{' Body '}'
	;
	
Body : DECLARATIONS Declarations STATEMENTS Statements
	;



Declarations : Declaration
	| Declarations Declaration
	;
	
Declaration : Variable_Declaration
	;



Variable_Declaration : Vars ARROW Type ';'
	;

Vars : Var
	| Vars ',' Var
	;

Var : identifier Value_Var
	;
	
Value_Var :
	| '=' Inic_Var
	;

Type : INTEGER
	| BOOLEAN	
	| ARRAY SIZE number
	;
	
Inic_Var : Constant
	| Array_Definition
	;
	
Constant : number
	| string
	| 'TRUE'
	| 'FALSE'
	;
	


Array_Definition : '[' Array_Initialization ']'
	;
	
Array_Initialization : Elem
	| Array_Initialization ',' Elem
	;
	
Elem : number
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
	
Location : 'GOTO' number ',' number
	| 'WHERE' '?'
	;
	


Assignment : Variable '=' Expression
	;
	
Variable : identifier Array_Acess
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
	


SuccOrPred : SuccPred identifier
	;
	
SuccPred : 'SUCC'
	| 'PRED'
	;



Say_Statement : 'SAY' '(' Expression ')'
	;
	
Ask_Statement : 'ASK' '(' string ',' Variable ')'
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
