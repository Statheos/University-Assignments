all:
	bison -d ergasia.y
	flex ergasia.l
	gcc -o ergasia ergasia.tab.c lex.yy.c
	./ergasia <input.txt> output.txt

clean:
	rm ergasia.tab.c ergasia.tab.h lex.yy.c ergasia
