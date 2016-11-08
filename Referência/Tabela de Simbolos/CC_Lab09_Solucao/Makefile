
all: bison flex gcc
	@echo "Done."

bison: parser.y
	bison parser.y

flex: scanner.l
	flex scanner.l

tables: tables.c
	gcc -Wall -c tables.c

gcc: scanner.c parser.c tables
	gcc -Wall -o checker scanner.c parser.c tables.o

clean:
	@rm -f *.o *.output scanner.c parser.h parser.c checker
