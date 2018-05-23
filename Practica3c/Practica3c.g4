grammar Practica3c;

//Imports del parser
@header{
import java.util.ArrayList;
import java.io.FileWriter;
}

//Variables y metodos
@members{
    String metodo = "", llamada = "",
    ArrayList<String> funciones = new ArrayList<String>();
    ArrayList<int> npath = new ArrayList<int>();
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

}: m p  
    |;

m: '(' ')' '{' c '}';

c: s c 
    |;

s: '{' c '}'
    | e ';'
    | WHILE '(' c ')' s
    | IF '(' c ')' s r
    | FOR '(' e ';' e ';' e ')' s
    | SWITCH '(' e ')' '{' b '}'
    | DO s WHILE '(' e ')'
    | '(' e ')' c;

b: CASE ':' c b
    | CASE ':' c
    | DEFAULT ':' c;

r: ELSE s
    |;

e: f e1
    | e1;

e1: '?' e ':' e
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
