#ifndef _HASH
#define _HASH

#define HASH_SIZE 50

typedef struct varData {
	char* id;
	int type;
	int address;
	struct varData *next;
} *VarData, **VarHashTable;

VarHashTable initHash();

#endif
