grammar practica3c;

//Imports del parser
@parser::header{
import java.util.ArrayList;
import java.io.FileWriter;
}

//Variables y metodos
@parser::members{
    String ultimoID="";

    ArrayList<String> funciones = new ArrayList<String>();
    ArrayList<Integer> npaths = new ArrayList<Integer>();
    ArrayList<String> llamadas = new ArrayList<String>();
    ArrayList<ArrayList<String>> esquemaLlamadas = new ArrayList<ArrayList<String>>();
}

p @after{
    FileWriter salida = null;
    try {
        salida = new FileWriter("llamadas.txt");
        for(int i=0;i<funciones.size();i++){
		    salida.write(funciones.get(i) + " Npath = "+ npaths.get(i) + "\n");
		    System.out.println(funciones.get(i) + " Npath = "+ npaths.get(i));
		for(int j=0;j<esquemaLlamadas.get(i).size();j++){
			if(funciones.contains(esquemaLlamadas.get(i).get(j))){
				salida.write("\t" + esquemaLlamadas.get(i).get(j) + "\n");
				System.out.println("\t"+esquemaLlamadas.get(i).get(j));
			}
		}
        }
        salida.close();
    } catch (Exception ex) {
        System.out.println("Error en la escritura de fichero");
    } 
}: programa |;

programa:  metodo
    | definicion;

metodo: ids {funciones.add(ultimoID);} '(' args ')' '{' contenido {npaths.add($contenido.npath);} '}' {esquemaLlamadas.add(llamadas); llamadas = new ArrayList<String>();}  programa 
    |;

definicion: ids '(' args ')' ';' programa
    |ids ';' programa
    |;

contenido returns [int npath]: sentencia contenido {$npath = $sentencia.npath * $contenido.npath;}
    | {$npath = 1;} ;  

sentencia returns [int npath]:'{' contenido '}' {$npath = $contenido.npath;}
    | llamadaMetodo ';' {$npath = 1;}
    | ids ';' {$npath = 1;}
    | retur ';' {$npath = 1;}
    | expresion ';' {if ($expresion.npath == 0) $npath = 1; else $npath = $expresion.npath;}
    | WHILE '(' expresion ')' sentencia {$npath = $expresion.npath + $sentencia.npath + 1;}
    | IF '(' expresion ')' sentencia els {$npath = $expresion.npath + $sentencia.npath + $els.npath;}
    | FOR '(' expresion {$npath = $expresion.npath;} ';' expresion {$npath = $npath + $expresion.npath;} ';' expresion {$npath = $npath + $expresion.npath;} ')' sentencia {$npath = $npath + $sentencia.npath +1;}
    | SWITCH '(' expresion ')' '{' casos {$npath = $expresion.npath + $casos.npath;} '}'
    | DO sentencia WHILE '(' expresion ')' {$npath = $sentencia.npath + $expresion.npath + 1;};

retur: 'return' expresion;

llamadaMetodo: ids {llamadas.add(ultimoID);} '(' args ')'
   |ids;

casos returns [int npath]: CASE expresion':' contenido casos {$npath = $contenido.npath + $casos.npath;}
    | DEFAULT expresion ':' contenido {$npath = $contenido.npath;}
    | CASE expresion ':' contenido {$npath = $contenido.npath;};

els returns [int npath]: ELSE sentencia {$npath = $sentencia.npath;}
    | {$npath = 1;};

expresion returns [int npath]: llamadaMetodo operando eaux {$npath = $operando.npath + $eaux.npath;}
    | llamadaMetodo {$npath = 0;}
    | {$npath = 0;};

eaux returns [int npath]: '?' expresion {$npath = $expresion.npath;} expresion {$npath = $npath + $expresion.npath + 2;}
    |{$npath = 0;};

operando returns [int npath]: OPERANDO operandoAux {$npath = $operandoAux.npath + 1;}
    | expPar {$npath = $expPar.npath;};

operandoAux returns [int npath]: expresion operando {$npath = $expresion.npath + $operando.npath;}
    |{$npath = 0;};

expPar returns [int npath]: '(' expresion {$npath = $expresion.npath;} ')' expresion {$npath = $npath + $expresion.npath;}
    | '{' expresion {$npath = $expresion.npath;} '}' expresion {$npath = $npath + $expresion.npath;};

ids: ID {ultimoID = $ID.text;} ids
    |;

args: ID args
    |expresion;

WHILE: 'while';
IF: 'if';
FOR: 'for';
SWITCH: 'switch';
DO: 'do';
CASE: 'case';
DEFAULT: 'default';
ELSE: 'else';
OPERANDO:  '&&'
        | '||';
BlockComment2: '/*' .*? '*/' -> skip;
LineComment:   '//' ~[\r\n]* -> skip;
WS	: [ \t\r\n]+ -> skip;
STRING1: '"' .*? '"' -> skip;
STRING2: ['] .*? ['] -> skip;
ID:	[a-zA-Z][a-zA-Z0-9_]*;
ErrorCharacter : . -> channel(HIDDEN) ;