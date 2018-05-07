#include "Lexx.yy.c"
#include <stdlib.h>

File *file;
int preanalisis;
int NPath = 0;

int main(int argc, char **argv) {
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    }
    else {
        printf("Es necesario pasar un fichero .c como argumento.");
    }

    preanalisis = yylex();
    S();

}

void parea(int token) {
    if (preanalisis == token) {
        preanalisis = yylex();
    }
    else {
		printf ("ERROR Esperaba %c, encuentro %c\n", token, preanalisis);
		exit (1) ;
	}
}

void S() {
    switch(preanalisis) {
        case 'INT':
            parea(INT);
            break;
        case 'BOOLEAN':
            parea(BOOLEAN);
            break;
        case 'BYTE':
            parea(BOOLEAN);
            break;
        case 'FLOAT':
            parea(FLOAT);
            break;
        case 'CHAR':
            parea(CHAR);
            break;
        case 'DOUBLE':
            parea(DOUBLE);
            break;
        case 'LONG':
            parea(LONG);
            break;
        case 'SHORT':
            parea(SHORT);
            break;
        case 'VOID':
            parea(VOID);
            break;
        case 'SIGNED':
            parea(SIGNED);
            break;
        case 'UNSIGNED':
            parea(UNSIGNED);
            break;

    }
}

