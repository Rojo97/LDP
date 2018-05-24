grammar practica3c;

//Imports del parser
@header{
import java.util.ArrayList;
import java.io.FileWriter;
}

//Variables y metodos
@members{
    String metodo = "", llamada = "", ultimoID="";
    ArrayList<String> funciones = new ArrayList<String>();
    ArrayList<Integer> npath = new ArrayList<Integer>();
    ArrayList<String> llamadas = new ArrayList<String>();
    ArrayList<ArrayList<String>> esquemaLLamadas = new ArrayList<ArrayList<String>>();
}

p @after{
    FileWriter salida = null;
    try {
        salida = new FileWriter("llamadas.txt");
        //Almacenar datos
        salida.close();
    } catch (Exception ex) {
    }

}: p1 |;

p1:  m
    | d
    | dp;

m: ids '(' args ')' '{' c '}' p1 
    |;

d: ids '(' args ')' ';' p1
    |;

dp: ids ';' p1
    |;

c: s c 
    |;

s: ids '{' c '}'
    | l';'
    | WHILE '(' e ')' s
    | IF '(' e ')' s r
    | FOR '(' e ';' e ';' e ')' s
    | SWITCH '(' e ')' '{' b '}'
    | DO s WHILE '(' e ')';

l: ids '(' args ')' l
    | ids 
    |;

b: CASE c b
    | CASE c
    | DEFAULT c;

r: ELSE s
    |;

e: l f e1
    | l
    |;

e1: '?' e e
    |e;

f: OPERANDO f1
    | u;

f1: l f
    |;

u: '(' e ')' e;

ids: ID ids
    |;

args: ID args
    | '(' ')' args
    | '(' args ')'
    |;

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
INCLUDE: 'include' -> skip;
BlockComment2: '/*' .*? '*/' -> skip;
LineComment:   '//' ~[\r\n]* -> skip;
WS	: [ \t\r\n]+ -> skip;
STRING1: '"' .*? '"' -> skip;
STRING2: ['] .*? ['] -> skip;
ID:	[a-zA-Z][a-zA-Z0-9_]+;
ErrorCharacter : . -> channel(HIDDEN) ;
