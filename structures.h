#ifndef _STRUCTS
#define _STRUCTS

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

ListaVars *nodo;

void insereEmListaVars(VarTipo var, int first);
char *stringToupper(char* string);

#endif
