#include "lex.yy.c"
#include <stdlib.h>

File *file;
int preanalisis;

void parea(int token) {
    if (preanalisis == token) {
        preanalisis = yylex();
    }
    else {
		printf ("ERROR Esperaba %c, encuentro %c\n", token, preanalisis);
		exit (1) ;
	}
}
int S() {
    if (preanalisis == '{') {
         parea('{');
         int NP = A();
         parea('}');
         return NP;
    }    
    else {
        preanalisis = yylex();
		if(preanalisis == 0){
			printf("Fin del programa.\n");
			exit(0);
		}
        return S();
    }
  
}
int A() {
    int NP1 = 1;
    int NP2 = 1;
    switch(preanalisis){
        case DO:
            NP1 = Flujo();
            NP2 = A();
            return (NP1 * NP2);
        case IF:
            NP1 = Flujo();
            NP2 = A();
            return (NP1 * NP2);
        case FOR:
            NP1 = Flujo();
            NP2 = A();
            return (NP1 * NP2);
        case WHILE:
            NP1 = Flujo();
            NP2 = A();
            return (NP1 * NP2);
        case SWITCH:
            NP1 = Flujo();
            NP2 = A();
            return (NP1 * NP2);
        case '}':
            return 1;
        case CASE:
            return 1;
        case DEFAULT:
            return 1;
        default :
            return 0;
    }
}
int Flujo() {
    int NP1 = 0;
    int NP2 = 0;
    switch(preanalisis) {
        case IF:
            NP1 = If();
            NP2 = Else();
            return (NP1 + NP2);
        case WHILE:
            return (While());
        case DO:
            parea(DO);
            parea('{');
            NP1 = A();
            parea('}');
            parea(WHILE);
            parea('(');
            NP2 = C();
            parea(')');
            return (NP1 + NP2 + 1);
        case FOR:
            return (For());
        case SWITCH:
            return(Switch());
        default :
            return 1;
    }
}

int If() {
    int NP1 = 0;
     int NP2 = 0;
    if(preanalisis == IF){
        parea(IF);
        parea('(');
        NP1 = C();
        parea(')');
        NP2 = Interior();
        return ( NP1 + NP2 + 1);
    } else {
        return 1;
    }
}
int Else() {
    int NP1 = 0;
    if (preanalisis == ELSE) {
        parea(ELSE);
        NP1 = Interior();
        return (NP1 -1);
    } else{
        return 0;
    }
}
 
 int While() {
     int NP1 = 0;
     int NP2 = 0;
    if(preanalisis == WHILE){
        parea(WHILE);
        parea('(');
        NP1 = C();
        parea(')');
        NP2 = Interior();
        return (NP1 + NP2 + 1);
    } else{
        return 1;
    }
}

int For(){
    int NP1 = 0;
    int NP2 = 0;
    if(preanalisis == FOR){
        parea(FOR);
        parea('(');
        NP1 = C();
        parea(')');
        NP2 = Interior();
        return ( NP1 + NP2 +3 );
    } else {
        return 1;
    }
}

int Switch() {
    int NP1 = 0;
    if(preanalisis == SWITCH){
        parea(SWITCH);
        parea('(');
        parea(')');
        parea('{');
        NP1 = Cases();
        parea('}');
        return ( NP1 + 1 );
    } else{
        return 1;
    }
}

int C() {
    int NP1 = 0;
    int NP2 = 0;
   switch (preanalisis) {
        case '(':
            parea('(');
            NP1 = C();
            parea(')');
            NP2 = C();
            return ( NP1 + NP2);
        case AND:
            NP1 = Comp();
            NP2 = C();
            return ( NP1 + NP2);
        case ANDBIT:
            NP1 = Comp();
            NP2 = C();
            return ( NP1 + NP2);
        case OR:
            NP1 = Comp();
            NP2 = C();
            return ( NP1 + NP2);
        case ORBIT:
            NP1 = Comp();
            NP2 = C();
            return ( NP1 + NP2);
        case ')':
            return 0;
        default :
            return 0;
 }
}

 int Comp() {
      switch (preanalisis) {
        case AND:
            parea(AND);
            return 1;
        case OR:
            parea(OR);
            return 1;
        case ANDBIT:
            parea(ANDBIT);
            return 1;
        case ORBIT:
            parea(ORBIT);
            return 1;
        default :
            return 0;
      }   
 }

 int Cases() {
     int NP1 = 0;
     int NP2 = 0;
    if(preanalisis == CASE){
        parea(CASE);
        NP1 = A();
        NP2 = Cases();
        return ( NP1 + NP2 );
    }
    else if(preanalisis == DEFAULT){
        parea(DEFAULT);
        NP1 = A();
        NP2 = Cases();
        return ( NP1 + NP2 );
    } else if (preanalisis == '}'){
        return 0;
    } else {
        return 0;
    }
}
int Interior() {
    int NP1 = 0;
    switch (preanalisis) {
        case('{') :
            parea('{');
            NP1 = A();
            parea('}');
            return ( NP1);
        case(DO):
            return 1;
        case(IF):
            return 1;
        case(FOR):
            return 1;
        case(WHILE):
            return 1;
        case(SWITCH):
            return 1;
        case('}'):
            return 1;
        case(CASE):
            return 1;
        case(DEFAULT):
            return 1;
        case(ELSE):
            return 1;
        default :
            return 1;
    } 
}

int main(int argc, char **argv) {
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    }
    else {
        printf("Es necesario pasar un fichero .c como argumento.");
    }

    preanalisis = yylex();
    int NPath = S();
    printf ( "NPATH = %d", NPath);
    return 0;

}



