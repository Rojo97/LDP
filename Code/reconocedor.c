#include "lex.yy.c"
#include <stdlib.h>

File *file;
int preanalisis;
int NPath = 0;
int if, else, while, for, switch;



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
    }

    }
}
void Flujo() {
    switch(preanalisis) {
        case 'IF':
            parea('IF');
            if = 0;
            else = 0;
            If();
            Else();
        case 'WHILE':
            parea('WHILE');
            while = 0;
            While();
        case 'DO':
            parea('DO');
            parea('{')
            A();
            parea('}')
            while = 0;
            While();
        case 'FOR':
            parea('FOR');
            for = 0;
            For();
        case 'SWITCH':
            parea('SWITCH');
            switch = 0;
            Switch();
        case 'RETURN':
            parea('RETURN');
            NPath++;
        case 'BREAK':
            parea('BREAK');
            NPath++;
       
    }
}

void If() {
    if(preanalisis == '('){
        parea('(');
        C();
        parea(')');
        Interior();
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
            if++;
        case 'OR':
            parea('OR');
            if++;
        case 'ANDBIT';
            parea('ANDBIT');
            if++;
        case 'ORBIT':
            parea('ORBIT');
           if++;     
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
    }
}
void While() {
    if(preanalisis == '('){
        parea('(');
        C();
        parea(')');
        Interior();
    }
}

void For(){
    if(preanalisis == '('){
        parea('(');
        C();
        parea(')');
        Interior();
    }
}
void Switch() {
    parea('(');
    parea(')');
    parea('{');
    Cases();
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

