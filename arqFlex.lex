%{
 #include "arqBison.tab.h"
%}
intDigito    [0-9]+
nome         [0-9a-zA-Z]+
mul          "*"
adi          "+"
sub          "-"
div          "/"
esp          [ \t]
Lpar         "("
Rpar         ")"
%%

{esp}          {;}
\n             {return LINHA;}
{Lpar}         {return LPAR;}
{Rpar}         {return RPAR;} 
{mul}          {return MUL;}
{div}          {return DIV;}
{adi}          {return ADI;}
{sub}          {return SUB;}
{nome}         {yylval.sval=strdup(yytext);return NOME;}

%%
