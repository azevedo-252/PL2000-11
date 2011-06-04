#include "hashFunctions.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>


VarHashTable varHashTable;

VarHashTable initHash(){
	int i;
	VarHashTable v;
	v = (VarHashTable)malloc(sizeof(VarData)*HASH_SIZE);
	for (i = 0; i < HASH_SIZE; i++)
		v[i]=NULL;
	return v;
}

int hash(char* s) {
	int h = 0, i, n=strlen(s);
	for (i = 0; i < n; i++) {
		h = 31*h + s[i];
	}
	return h%HASH_SIZE;
}

VarData searchVar(char* id){
	int h = hash(id);
	VarData varData = varHashTable[h];
	while (varData && strcmp(varData->id, id)!=0){
		varData = varData->next;
	}
	return varData;
}

int insertVar(char* id, int type, int address) {
	int h = hash(id);
	VarData new, var;
	new = (VarData)malloc(sizeof(struct varData));
	var = varHashTable[h];
	varHashTable[h]=new;
	new->id=id;
	new->type=type;
	new->address=address;
	new->next=var;
	return 1;
}

void printHash(){
        int i;
        VarData var;
        for(i=0;i<HASH_SIZE;i++){
                if(varHashTable[i]==NULL)
                        printf("()\n");
                else{
                        var=varHashTable[i];
                        printf("(");
                        for(;var!=NULL;var=var->next)
                                printf("(%s.%d.%d)\t ",var->id,var->type,var->address);
                        printf(")\n");
                }
        }
}

