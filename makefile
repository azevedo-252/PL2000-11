logoliss: y.tab.o lex.yy.o
	cc -o logoliss y.tab.o lex.yy.o -lfl

y.tab.o: y.tab.c
	cc -c y.tab.c

lex.yy.o: lex.yy.c y.tab.h
	cc -c lec.yy.c

y.tab.c y.tab.h: logo.y
	yacc -d logo.y

lex.yy.c: logo.l
	flex logo.l
