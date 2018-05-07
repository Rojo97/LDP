#include <stdio.h>
#include <stdlib.h>
#include "lex.yy.c"

int preanalisis;
void S ();
void Tipo ();
void TipoSimple ();
void AuxLong ();
void TipoComp ();
void A ();
void ArgsDef ();
void ArgDef ();
void Exp ();
void Asig ();
void AsigValor ();
void ArgsLla ();
void Valor ();
void String ();
void String2 ();
void Op ();
void AuxOP ();
void Op2 ();
void Flujo ();
void If ();
void Else ();
void While ();
void For ();
void Switch ();
void Return ();
void Return2 ();
void C ();
void C2 ();
void Comp ();
void Bolean ();
void Ids ();
void Cases ();
void Interior ();


File *file;
int NPath = 0;

int main(int argc, char **argv) {
    if (argc == 2) {
        yyin = fopen(argv[1], "r");
    }
    else {
        printf("Es necesario pasar un fichero .c como argumento.");
    }

    preanalisis = yylex();
    S(NPath);

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

void S(int NPath) {
    switch (preanalisis) {
      case INT:
          Tipo();
          break;
      case VOID:
          Tipo();
          break;
      case STRUCT:
          Tipo();
          break;
      case BOLEAN:
          Tipo();
          break;
      case BYTE:
          Tipo();
          break;
      case FLOAT:
          Tipo();
          break;
      case CHAR:
          Tipo();
          break;
      case DOUBLE:
          Tipo();
          break;
      case LONG:
          Tipo();
          break;
      case SHORT:
          Tipo();
          break;
      case CONST:
          Tipo();
          break;
      case VOLATILE:
          Tipo();
          break;
      case SIGNED:
          Tipo();
          break;
      default: printf("ERROR Esperaba encuentro %c\n", preanalisis);
    }


}

void Tipo (){
    
}
void TipoSimple (){

}
void AuxLong (){

}
void TipoComp ();
void A ();
void ArgsDef ();
void ArgDef ();
void Exp ();
void Asig ();
void AsigValor ();
void ArgsLla ();
void Valor ();
void String ();
void String2 ();
void Op ();
void AuxOP ();
void Op2 ();
void Flujo ();
void If ();
void Else ();
void While ();
void For ();
void Switch ();
void Return ();
void Return2 ();
void C ();
void C2 ();
void Comp ();
void Bolean ();
void Ids ();
void Cases ();
void Interior ();
