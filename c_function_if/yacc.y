%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int copy(const char *arg1, const char *arg2, const char *arg3,const char *arg4,const char *arg5,const char *arg6);
const char *getptr(int index);
extern char *yytext;
%}

%token LEFT_PARENTHESIS RIGHT_PARENTHESIS LEFT_BRACE RIGHT_BRACE SEMICOLON COMMA
%token ADD SUB MUL DIV EQUAL GREATER LESS
%token IF RETURN INT REAL  WHILE 
%token NUMBER_INT NUMBER_DOUBLE NUMBER_HEX
%token IDENTIFIER VOID

%%

 /*PROGRAM -> FUNCTION*/
 PROGRAM
 	: FUNCTION
 	{
        printf("PROGRAM -> FUNCTION%d <=> %s\n", $1,getptr($1));
 	}

/*FUNCTION -> TYPENAME IDENTIFIER ( ARGUMENT_LIST ) BLOCK*/
FUNCTION
	: TYPENAME IDENTIFIER LEFT_PARENTHESIS ARGUMENT_LIST RIGHT_PARENTHESIS BLOCK
	{
  	  $$ = copy(getptr($1),(char *)$2,"(",getptr($4),")",getptr($6));
          printf("\n FUNCTION%d -> TYPENAME%d IDENTIFIER %s ( ARGUMENT_LIST%d ) BLOCK%d <=> %s\n",$$,$1,(char *)$2,$4,$6,getptr($$));
	}
ARGUMENT_LIST
        : ARGUMENT_LIST COMMA ARGUMENT
        {
          $$ = copy(getptr($1),",",getptr($3),NULL,NULL,NULL);
          printf("\n ARGUMENT_LIST%d -> ARGUMENT_LIST%d COMMA ARGUMENT%d <=> %s\n",$$,$1,$3,getptr($$));
        }
        | ARGUMENT
        {
          $$ = copy(getptr($1),NULL, NULL, NULL, NULL, NULL);
          printf("\n ARGUMENT_LIST%d -> ARGUMENT%d <=> %s\n", $$,$1,getptr($1));
        }
ARGUMENT
	: TYPENAME IDENTIFIER
	{
	  $$ = copy(getptr($1),(char *)$2,NULL,NULL,NULL,NULL);
          printf("\n ARGUMENT%d -> TYPENAME%d IDENTIFIER %s <=> %s\n",$$,$1,(char *)$2,getptr($$));
	}
        | VOID
        {
          $$ = copy("void", NULL, NULL, NULL, NULL, NULL);
          printf("\n ARGUMENT%d -> VOID <=> %s\n",$$,getptr($$));
        }
IF_STATEMENT
	: IF LEFT_PARENTHESIS EXPRESSION RIGHT_PARENTHESIS BLOCK
	{
          $$ = copy("if","(",getptr($3),")",getptr($5),NULL);
          printf("\n IF_STATEMENT%d -> IF ( EXPRESSION%d ) BLOCK%d <=> %s\n",$$,$3,$5,getptr($$));
	}
BLOCK
	: STATEMENT
	{
	  $$ = copy(getptr($1),NULL,NULL,NULL,NULL,NULL);
          printf("\n BLOCK%d -> STATEMENT%d <=> %s\n",$$,$1,getptr($$));
	}
	| LEFT_BRACE STATEMENT_LIST RIGHT_BRACE
	{
	  $$ = copy("{",getptr($2),"}",NULL,NULL,NULL);
          printf("\n BLOCK%d -> {STATEMENT_LIST%d} <=> %s\n",$$,$2,getptr($$));
	}
STATEMENT_LIST
	: STATEMENT
	{
	  $$ = copy(getptr($1),NULL,NULL,NULL,NULL,NULL);
          printf("\n STATEMENT_LIST%d -> STATEMENT%d <=> %s\n",$$,$1,getptr($$));
	}
	| STATEMENT_LIST STATEMENT
	{
	  $$ = copy(getptr($1),getptr($2),NULL,NULL,NULL,NULL);
          printf("\n STATEMENT_LIST%d -> STATEMENT_LIST%d STATEMENT%d <=> %s\n",$$,$1,$2,getptr($$));
	}
	| IF_STATEMENT
	{
	  $$ = copy(getptr($1),NULL,NULL,NULL,NULL,NULL);
          printf("\n STATEMENT_LIST%d -> IF_STATEMENT%d <=> %s\n",$$,$1,getptr($$));
	}
        | STATEMENT_LIST IF_STATEMENT
        {
          $$ = copy(getptr($1),getptr($2),NULL,NULL,NULL,NULL);
          printf("\n STATEMENT_LIST%d -> STATEMENT_LIST%d IF_STATEMENT%d <=> %s\n",$$,$1,$2,getptr($$));
        }
STATEMENT
	: EXPRESSION SEMICOLON
	{
	  $$ = copy(getptr($1),";",NULL,NULL,NULL,NULL);
          printf("\n STATEMENT%d -> EXPRESSION%d SEMICOLON <=> %s\n",$$,$1,getptr($$));
	}
	| TYPENAME VARIABLE_LIST SEMICOLON
	{
	  $$ = copy(getptr($1),getptr($2),";",NULL,NULL,NULL);
          printf("\n STATEMENT%d -> TYPENAME%d VARIABLE_LIST%d SEMICOLON <=> %s\n",$$,$1,$2,getptr($$));
	}
TYPENAME
	: INT
	{
	  $$ = copy("int ",NULL,NULL,NULL,NULL,NULL);
          printf("\n TYPENAME%d -> INT <=> %s\n", $$,getptr($$));
	}
	| REAL
	{
	  $$ = copy("real ",NULL,NULL,NULL,NULL,NULL);
          printf("\n TYPENAME%d -> REAL <= %s\n", $$,getptr($$));
	}
VARIABLE_LIST
	: IDENTIFIER
	{
	  $$ = copy((char *)$1,NULL,NULL,NULL,NULL,NULL);
          printf("\n VARIABLE_LIST%d -> IDENTIFIER %s <=> %s\n",$$,$1,getptr($$));
	}
	| VARIABLE_LIST COMMA IDENTIFIER
	{
	  $$ = copy(getptr($1),",",(char *)$3,NULL,NULL,NULL);
          printf("\n VARIABLE_LIST%d -> VARIABLE_LIST%d COMMA IDENTIFIER %s <=> %s\n",$$,$1,$3,getptr($$));
	}
EXPRESSION
	: TERM
	{
	  $$ = copy(getptr($1),NULL,NULL,NULL,NULL,NULL);
          printf("\n EXPRESSION%d -> TERM%d <=> %s\n",$$,$1,getptr($$));
	}
	| LEFT_PARENTHESIS EXPRESSION RIGHT_PARENTHESIS
	{
	  $$ = copy("(",getptr($2),")",NULL,NULL,NULL);
          printf("\n EXPRESSION%d -> ( EXPRESSION%d ) <=> %s\n",$$,$2,getptr($$));
	}
	| EXPRESSION OPERATOR TERM
	{
	  $$ = copy(getptr($1),getptr($2),getptr($3),NULL,NULL,NULL);
          printf("\n EXPRESSION%d -> EXPRESSION%d OPERATOR%d TERM%d <=> %s\n",$$,$1,$2,$3,getptr($$));
	}
OPERATOR
	: ADD
	{
	  $$ = copy("+",NULL,NULL,NULL,NULL,NULL);
          printf("\n OPERATOR -> ADD\n");
	}
	| SUB
	{
	  $$ = copy("-",NULL,NULL,NULL,NULL,NULL);
          printf("\n OPERATOR -> SUB\n");
	}
	| MUL
	{
	  $$ = copy("*",NULL,NULL,NULL,NULL,NULL);
          printf("\n OPERATOR -> MUL\n");
	}
	| DIV
	{
	  $$ = copy("/",NULL,NULL,NULL,NULL,NULL);
          printf("\n OPERATOR -> DIV\n");
	}
	| EQUAL
	{
	  $$ = copy("=",NULL,NULL,NULL,NULL,NULL);
          printf("\n OPERATOR -> EQUAL\n");
	}
	| GREATER
	{
	  $$ = copy(">",NULL,NULL,NULL,NULL,NULL);
          printf("\n OPERATOR -> GREATER\n");
	}
	| LESS
	{
	  $$ = copy("<",NULL,NULL,NULL,NULL,NULL);
          printf("\n OPERATOR -> LESS\n");
	}
TERM
	: NUMBER_INT
	{
	  $$ = copy((char *)$1,NULL,NULL,NULL,NULL,NULL);
          printf("\n TERM -> %s\n",(char *)$1);
	}
	| NUMBER_DOUBLE
	{
	  $$ = copy((char *)$1,NULL,NULL,NULL,NULL,NULL);
          printf("\n TERM -> %s\n",(char *)$1);
	}
	| NUMBER_HEX
	{
	  $$ = copy((char *)$1,NULL,NULL,NULL,NULL,NULL);
          printf("\n TERM -> %s\n",(char *)$1);
	}
	| IDENTIFIER
	{
	  $$ = copy((char *)$1,NULL,NULL,NULL,NULL,NULL);
          printf("\n TERM -> %s\n",(char *)$1);
	}
%%
static char Buffer[10000];
static char *Address[1000];
static char *Pointer = Buffer;
static int counter = 0;

int copy(const char *arg1,const char *arg2,const char *arg3,const  char *arg4, const char *arg5, const char *arg6)
{
	Address[counter++] = Pointer;
	sprintf(Pointer,"%s",arg1);
	Pointer += strlen(arg1);
	if(arg2 != NULL)
	{
		sprintf(Pointer,"%s",arg2);
		Pointer += strlen(arg2);
	}
	if(arg3 != NULL)
	{
		sprintf(Pointer,"%s",arg3);
		Pointer += strlen(arg3);
	}
        if(arg4 != NULL)
	{
	  sprintf(Pointer,"%s",arg4);
          Pointer += strlen(arg4);
        }
        if(arg5 != NULL)
	{
	    sprintf(Pointer,"%s",arg5);
            Pointer += strlen(arg5);
	}
        if(arg6 != NULL)
	{
	    sprintf(Pointer,"%s",arg6);
            Pointer += strlen(arg6);
        }
	*Pointer++ = '\0';

	return counter;
}

const char *getptr(int index)
{
	return Address[index - 1];
}

int yyerror(char const *str)
{
  //	extern char *yytext;
	fprintf(stderr,"parser error near %s\n",yytext);
	return 0;
}

int main(void)
{
	extern int yyparse(void);
	extern FILE *yyin;
	yyin = stdin;
	yyparse();
	return 0;
}
