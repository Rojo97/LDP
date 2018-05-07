#include "lex.yy.c"
#include <stdlib.h>

File *file;
int preanalisis;
int NPath = 1;
int if, else, while, for, switch, flujo;



int main(int argc, char **argv) {
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    }
    else {
        printf("Es necesario pasar un fichero .c como argumento.");
    }

    preanalisis = yylex();
    S();
    printf("El valor de NPATH es: %d", NPath);

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
    if (preanalisis == '{') {
         parea('{');
         A();
         parea('}');
    }    
    else {
        exit(0);
    }
  
}
void A() {
    if (preanalisis != null) {
        Flujo();
        NPath = NPath * flujo;
        A();
    }

}
void Flujo() {
    flujo = 0;
    switch(preanalisis) {
        case 'IF':
            parea('IF');
            if = 0;
            else = 0;
            If();
            Else();
            flujo = flujo + if + else;
        case 'WHILE':
            parea('WHILE');
            while = 0;
            While();
            flujo = flujo + while;
        case 'DO':
            parea('DO');
            parea('{')
            A();
            parea('}')
            while = 0;
            While();
            flujo = flujo + while;
        case 'FOR':
            parea('FOR');
            for = 0;
            For();
            flujo = flujo + for;
        case 'SWITCH':
            parea('SWITCH');
            switch = 0;
            Switch();
            flujo = flujo + switch;
        case 'RETURN':
            parea('RETURN');
            flujo++;
        case 'BREAK':
            parea('BREAK');
            flujo++;  
    }
}

void If() {
    if(preanalisis == '('){
        parea('(');
        C();
        parea(')');
        Interior();
        if++;
    }      
}
 void C() {
     Comp();
     C();
 }
 void Comp() {
      switch (preanalisis) {
        case 'AND':
            parea('AND');
            flujo++;
        case 'OR':
            parea('OR');
            flujo++;
        case 'ANDBIT':
            parea('ANDBIT');
            flujo++;
        case 'ORBIT':
            parea('ORBIT');
            flujo++;     
      }       
 }

int Interior() {
    if (preanalisis == '{') {
         parea('{');
         A();
         parea('}');
    } 
}
void Else() {
    if (preanalisis == 'ELSE') {
        parea('ELSE')
        Interior();
        if--;
    }
}
void While() {
    if(preanalisis == '('){
        parea('(');
        C();
        parea(')');
        Interior();
        while++;
    }
}

void For(){
    if(preanalisis == '('){
        parea('(');
        C();
        parea(')');
        Interior();
        for += 3; 
    }
}
void Switch() {
    parea('(');
    parea(')');
    parea('{');
    Cases();
    switch++;
}

void Cases() {
    if(preanalisis == 'CASE'){
            parea('CASE');
            A();
            Cases();
    }
    else if(preanalisis == 'DEFAULT'){
        parea('DEFAULT');
        A();
        Cases();
    }
}

