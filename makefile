logoliss: y.tab.o lex.yy.o hashFunctions.o structures.h
	cc -o logoliss y.tab.o lex.yy.o hashFunctions.o -lfl

y.tab.o: y.tab.c
	cc -c y.tab.c

lex.yy.o: lex.yy.c
	cc -c lex.yy.c


lex.yy.c: logo.l y.tab.h structures.h
	flex logo.l

y.tab.c y.tab.h: logo.y
	yacc -d -v logo.y

hashFunctions.o: hashFunctions.h hashFunctions.c
	cc -c hashFunctions.c
