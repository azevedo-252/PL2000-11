#ifndef _HASH
#define _HASH

#define HASH_SIZE 30

typedef struct varData {
	char* id;
	int type;
	int address;
	struct varData *next;
} *VarData, **VarHashTable;

VarHashTable initHash();
int hash(char* s);
VarData searchVar(char* id);
int insertVar(char* id, int type, int address);
void printHash();

#endif
