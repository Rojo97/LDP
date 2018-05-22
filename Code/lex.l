%{
#include "finales.h"
%}

%%
if	          	      return IF;
else                  return ELSE;
switch	      	 	  return SWITCH;
case	        	  return CASE;
default	       		  return DEFAULT;
for 	        	  return FOR;
do	          	      return DO;
while	        	  return WHILE;
[&]		              return ANDBIT;
[|]                   return ORBIT;
[&][&]		     	  return AND;
[|][|]		     	  return OR;
[(]		              |
[{]		              |
[}]                   |
[)]                   return yytext[0];
[ \t\n]+              |
"//"[^\n]*            |
[/][*][^*]*[*]+([^*/][^*]*[*]+)*[/]     |
['].*[']              |
["].*["]              |
.                     ;
