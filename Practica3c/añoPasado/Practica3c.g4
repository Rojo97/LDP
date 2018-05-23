grammar Practica3c;
//@header { /* COMENTARIO DE CABECERA */ }
//@members { /* COMENTARIO MEMBERS */ }

//@lexer::header { /* SOLO PARA LEXER. HEADER */ }
//@parser::members { /* SOLO PARA PARSER, MEMBERS */ }
@parser::header{
import java.util.ArrayList;
import java.io.FileWriter;
}

@parser::members { // add members to generated RowsParser
    String id1 = "",id2 = "", id3 = "";
    ArrayList<String> arrayMetodos = new ArrayList<String>();
    ArrayList<String> arrayLlamadas = new ArrayList<String>();
    ArrayList<ArrayList<String>> llamadas = new ArrayList<ArrayList<String>>();

}


prog @after {

	FileWriter fichero = null;
	try {

	fichero = new FileWriter("funciones.txt");

	for(int i=0;i<arrayMetodos.size();i++){
		fichero.write(arrayMetodos.get(i) + "\n");
		System.out.println(arrayMetodos.get(i));
		for(int j=0;j<llamadas.get(i).size();j++){
			if(arrayMetodos.contains(llamadas.get(i).get(j))){
				fichero.write("\t" + llamadas.get(i).get(j) + "\n");
				System.out.println("\t"+llamadas.get(i).get(j));
			}
		}
		
	}
	fichero.close();

	} catch (Exception ex) {
	}
}: idspc CLASS ID '{' clase '}';

idspc: ID idspc | ';' idspc |;

clase: ID {id1 = id2;id2 = $ID.text;} ID {id1 = id2;id2 = $ID.text;} ids resto |;

resto: '(' params ')' def | ';' clase;

def: '{' codigo '}' {

	arrayMetodos.add(id2);
	llamadas.add(arrayLlamadas);
	arrayLlamadas = new ArrayList<String>();
    } clase | ';' clase;

ids: ID {id1 = id2;id2 = $ID.text;} ids|;

codigo: ID {id3 = $ID.text;} codigo | ';' codigo | '(' {arrayLlamadas.add(id3);} codigo ')' codigo | '{' codigo '}' codigo |;

params: ID params |;



CLASS:	'class';
ID:	[a-zA-Z][a-zA-Z0-9_]+;
COMMENT
    :   '/*' .*? '*/' -> channel(HIDDEN)
    ;

LINE_COMMENT
    :   '//' ~[\r\n]* -> channel(HIDDEN)
    ;

WS	: [ \t\r\n]+ -> skip;
ErrorCharacter : . -> channel(HIDDEN) ;


