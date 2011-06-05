#ifndef _STRUCTS
#define _STRUCTS

typedef enum Direccoes{
	up,
	down,
	right,
	left
} Direccao;

typedef struct VarTipos {
	char* id;
	char* value;
	int type;
} VarTipo;

typedef struct ConstTipos {
	char* value;
	int type;
} ConstTipo;

typedef struct NodoVar {
	char* id;
	char* value;
	int type;
	struct NodoVar *next;
} ListaVars;

//typedef struct Expressions {
//	ConstTipo consttipo;
//	VarTipo vartipo;
//	struct Expressions *next;
//} Expression;


int height, width, xpos, ypos, raio, mode;
Direccao direccao;
ListaVars *nodo;


void insertInListaVars(VarTipo var, int first);
void saveVars(int type);
//char *stringToupper(char* string);
void printListaVars();
void drawTurtle();
void drawLine(int newx, int newy);
void pushValues(int varType, int nullType, char* value);

#endif
