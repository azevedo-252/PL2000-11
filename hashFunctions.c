#include "hashFunctions.h"
#include <stdlib.h>


VarHashTable varHashTable;

VarHashTable initHash(){
	int i;
	VarHashTable v;
	v = (VarHashTable)malloc(sizeof(VarData)*HASH_SIZE);
	for (i = 0; i < HASH_SIZE; i++)
		v[i]=NULL;
	return v;
}
