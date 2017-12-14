all:
	flex calculator.l
	gcc lex.yy.c -lfl
clean:
	rm -rf *.out
