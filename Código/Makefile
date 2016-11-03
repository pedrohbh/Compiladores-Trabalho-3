all: bison flex gcc
	@echo "Feito."

bison: Parser.y
	bison Parser.y

flex: Scanner.l
	flex Scanner.l

gcc: Scanner.c Parser.c
	gcc -Wall -o trab2 Scanner.c Parser.c -ly

clean:
	@rm -f *.o Scanner.c Parser.h Parser.c trab2
