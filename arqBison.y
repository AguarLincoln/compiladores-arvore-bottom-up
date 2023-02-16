%{
#include <stdio.h>
#include <stdlib.h>


extern int yylex(); 
void yyerror(char *s);

struct ast {
    char* nodetype;
    struct ast *l;
    struct ast *r;
};

struct numval {
   
    char * number;
};

struct ast * newast(char* nodetype, struct ast *l, struct ast *r)
{
    struct ast *a = malloc(sizeof(struct ast));

    if(!a) {
        yyerror("out of space");
        exit(0);
    }

    a->nodetype = nodetype;
    a->l =  l;
    a->r =  r;
    return (struct ast *) a;
}

struct ast * newnum(char* d)
{
    struct numval *a = malloc(sizeof(struct numval));

    if(!a) {
        yyerror("out of space");
        exit(0);
    }
    a->number = d;
    return (struct ast *) a;
}


int imprime_pre_ordem(struct ast* arvore){
    int a=1,b=1, i;
	if(arvore != NULL){
		printf("(");
		printf(" %s\n",arvore->nodetype);
		a=imprime_pre_ordem(arvore->l);
		b=imprime_pre_ordem(arvore->r);
		if(b==0 && a==0)
            printf("  (folha)\n");
		//else if(b==0 && a!=0);
		//else if(b!=0 && a==0);
		printf(")\n\n");
	}else 
        return 0;//
}

 
%}


%union{struct ast *cval;}
%union{char *sval;}
%token<sval> NOME
%token LINHA

%left ADI SUB
%left MUL DIV
%token LPAR RPAR

%type<cval> expr termo fator
%start inicio


%%
inicio : expr LINHA {printf("\n\n");imprime_pre_ordem($1);}       
;

expr: expr ADI termo  {$$ = newast("+", $1, $3);}
     |expr SUB termo {$$ = newast("-", $1, $3);}
     |termo          {$$ = $1;}
;
termo:termo MUL fator  {$$ = newast("*", $1, $3);}
      |termo DIV fator  {$$ = newast("/", $1, $3);}
      |fator            {$$ = $1;}  
;
fator :LPAR expr RPAR  {$$  = $2;}
       |NOME        {$$ = newnum($1);} 
;
%%

void yyerror(char *s){
  printf("Erro Sintatico%s\n", s);
}
void main(){
    yyparse(); 
}
