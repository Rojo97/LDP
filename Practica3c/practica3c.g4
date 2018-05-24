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

p1: m
    | d
    | dp;

m: '(' ')' '{' c '}' p1
    |;

d: '(' ')' ';' p1
    |;

dp: ';' p1
    |;

c: s c 
    |;

s: '{' c '}'
    | e ';'
    | WHILE '(' c ')' s
    | IF '(' c ')' s r
    | FOR '(' e ';' e ';' e ')' s
    | SWITCH '(' e ')' '{' b '}'
    | DO '{' c '}' WHILE '(' e ')';

b: CASE c b
    | CASE c
    | DEFAULT c;

r: ELSE s
    |;

e: f e1
    | e1;

e1: '?' e e
    |;

f: OPERANDO f1
    | u;

f1: f
    |;

u: '(' e ')' e;

WHILE: 'while';
IF: 'if';
FOR: 'for';
SWITCH: 'switch';
DO: 'do';
CASE: 'case';
DEFAULT: 'default';
ELSE: 'else';
OPERANDO:  '||'
        | '&&';
BlockComment:   '/*' .*? '*/' -> skip;
LineComment:   '//' ~[\r\n]* -> skip;
WS	: [ \t\r\n]+ -> skip;
STRING1: '"' .*? '"' -> skip;
STRING2: ['] .*? ['] -> skip;
ID:	[a-zA-Z][a-zA-Z0-9_]+ {llamada = getText(); System.out.println(llamada);} -> skip;
ErrorCharacter : . -> channel(HIDDEN) ;
