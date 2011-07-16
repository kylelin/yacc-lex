%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int copy(const char *arg1,const char *arg2,const char *arg3);
const char *getptr(int index);

%}

%token LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACE RIGHT_BRACE SEMICOLON COMMA IF
OPERATOR TYPENAME INTEGER REAL HEXADECIMAL IDENTIFIER
%%

/*IF_STATEMTNT*/
IF_STATEMENT
     : IF LEFT_PARENTHESIS EXPRESSION RIGHT_PARENTHESIS BLOCK
     {
       printf("\n IF_STATEMTNT -> IF (EXPRESSION%d) BLOCK%d <=> if(%s)%s\n", $3,$5, getptr($3), getptr($5));
     }
/*BLOCK*/
BLOCK
     : STATEMENT
     {
       $$ = copy(getptr($1), NULL, NULL);
       printf("\n BLOCK%d -> STATEMENT%d <=> %s\n", $$, $1, getptr($$));
     }
     | LEFT_BRACE STATEMENT_LIST RIGHT_BRACE
     {
       $$ = copy("{", getptr($2), "}");
       printf("\n BLOCK%d -> {STATEMENT_LIST%d} <=> %s\n", $$, $2, getptr($$));
} 

/*STATEMENT_LIST TO STATEMENT|STATEMENT_LIST */
STATEMENT_LIST
     : STATEMENT
     {
       $$ = copy(getptr($1), NULL, NULL);
       printf("\n STATEMENT_LIST%d -> STATEMENT%d <=> %s\n", $$, $1, getptr($$));
     }
     | STATEMENT_LIST STATEMENT
     {
       $$ = copy(getptr($1), getptr($2), NULL);
       printf("\n STATEMENT_LIST%d -> STATEMENT_LIST%d STATEMENT%d <=> %s\n", $$, $1, $2, getptr($$)); 
     }

/*STATEMENT TO EXPRESSION ; | TYPENAME VARIABLE_LIST ; */
STATEMENT
     : EXPRESSION SEMICOLON
     {
       $$ = copy(getptr($1), ";", NULL);
       printf("\n STATEMENT%d -> EXPRESSION%d <=> %s\n", $$, $1, getptr($$));
     }
     | TYPENAME VARIABLE_LIST SEMICOLON
     {
       $$ = copy((char *)$1, getptr($2), ";");
       printf("\n STATEMENT%d -> TYPENAME VARIABLE_LIST%d; <=> %s\n", $$,  $2, getptr($$));
     }

/*VARIABLE_LIST TO IDENTIFIER | VARIABLE_LIST, IDENTIFIER*/
VARIABLE_LIST
     : IDENTIFIER 
     {
       $$ = copy((char *)$1, NULL, NULL);
       printf("\n VARIABLE_LIST%d -> IDENTIFIER <=> %s\n", $$, getptr($$));
     } 
     | VARIABLE_LIST COMMA IDENTIFIER
     {
       $$ = copy(getptr($1), ",", (char *)$3);
       printf("\n VARIABLE_LIST%d -> VARIABLE_LIST%d,IDENTIFIER <=> %s\n", $$, $1, getptr($$));
     }

/*EXPRESSION TO TERM | (EXPRESSION) | EXPRESSION OPeRATOR*/
EXPRESSION
     : TERM
     {
       $$ = copy(getptr($1), NULL, NULL);
       printf("\n EXPRESSION%d -> TERM%d <=> %s\n", $$, $1, getptr($$));
     }    
     | LEFT_PARENTHESIS EXPRESSION RIGHT_PARENTHESIS
     {
       $$ = copy("(",getptr($2), ")");
       printf("\n EXPRESSION%d -> (EXPRESSION%d) <=> %s\n", $$, $2, getptr($$));
     }    
     | EXPRESSION OPERATOR TERM
     {
       $$ = copy(getptr($1), (char *)$2, getptr($3));
       printf("\n EXPRESSION%d -> EXPRESSION%d %s TERM%d <=> %s\n", $$, $1, $2, $3, getptr($$));
     }  

/*NORM TO INTEGER | REAL | HEXADECIMAL | IEDENTIFIER*/
TERM
     : INTEGER
     {
       $$ = copy((char *)$1, NULL, NULL);
       printf("\n TERM%d -> %s\n", $$, getptr($$));
     } 
     | REAL 
     {
       $$ = copy((char *)$1, NULL, NULL);
       printf("\n TERM%d -> %s\n", $$, getptr($$));
     }
     | HEXADECIMAL
     {
       $$ = copy((char *)$1, NULL, NULL);
       printf("\n TERM%d -> %s\n", $$, getptr($$));
     }
     | IDENTIFIER
     {
       $$ = copy((char *)$1, NULL, NULL);
       printf("\n TERM%d -> %s\n", $$, getptr($$));
     }

%%
static char Buffer[10000];

static char *Address[1000];

static char *Pointer=Buffer;

static int counter = 0;


int copy(const char *arg1,const char *arg2,const char *arg3){

  Address[counter++] = Pointer;
  sprintf(Pointer, "%s" ,arg1);
  Pointer += strlen(arg1);

  if(arg2 != NULL){
    sprintf(Pointer, "%s", arg2);
    Pointer += strlen(arg2);
  }
  if(arg3 != NULL){
    sprintf(Pointer, "%s", arg3);
    Pointer += strlen(arg3) + 1;
  }
  
  *Pointer++ = '\0';
  return counter;
}

const char *getptr(int index){
  return Address[index-1];
} 

int yyerror(char const *str){
  extern char *yytext;
  fprintf(stderr,"parser error near %s\n",yytext);
  return 0;
}

int main(void){
 
  extern int yyparse(void);
  extern FILE *yyin;
  yyin = stdin;

  yyparse();
  return 0;
} 
