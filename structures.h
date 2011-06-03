typedef struct VarTipos {
	char* id;
	char* value;
	int type;
	int address;
} VarTipo;

typedef struct ConstTipos {
	char* value;
	int type;
} ConstTipo;

typedef struct ListasVars {
	int id;
	char* value;
	int type;
	int address;
	struct ListasVars *next;
} ListaVars;
ListaVars *lVars;
