%{
#include "finales.h"
%}

let   [a-zA-Z]
dig   [0-9]
digs  {dig}+
frac  [.]{digs}
expo  [eE][+-]?{digs}
id    {let}({let}|{dig})*
num   {digs}{frac}?{expo}?

%%
[ \t\n]+              |
"//"[^\n]*            |
"/*"[^"*/"]*"*/"      ;
return	         	  return RETURN;
if	          	      return IF;
else                  return ELSE;
switch	      	 	  return SWITCH;
case	        	  return CASE;
break	        	  return BREAK;
default	       		  return DEFAULT;
for 	        	  return FOR;
do	          	      return DO;
while	        	  return WHILE;
[+][+]		     	  return INCREMENT;
[-][-]		     	  return DECREMENT;
[+]		              |
[-]		              |
\^		              |
[/]                   |
[%]                   |
[*]	           	      return OPERATOR;
[<]		              return LESS;
[>]                   return GREATER;
[<][=]		     	  return LESSEQ;
[>][=]		     	  return GREATEREQ;
[=][=]		     	  return EQUAL;
[!][=]		     	  return NOTEQUAL;
[&]		              return ANDBIT;
[|]                   return ORBIT;
[&][&]		     	  return AND;
[|][|]		     	  return OR;
[:]		              |
[=]		              |
[,]		              |
[.]		              |
[;]		              |
[(]		              |
[{]		              |
[[]		              |
[]]                   |
[}]                   | 
[)]                   return yytext[0];
null		          return NULLW;
true		          return TRUEW;
false		          return FALSEW;
boolean		   	      return BOOLEAN;
byte		          return BYTE;
int		              return INT;
float		          return FLOAT;
char		          return CHAR;
double		          return DOUBLE;
long		       	  return LONG;
short		       	  return SHORT;
signed		     	  return SIGNED;
unsigned	      	  return UNSIGNED;
void		       	  return VOID;
const                 return CONST;
volatile              return VOLATILE;
{id}		       	  return ID;
{num}	 	     	  return NUMBER;
       