%option noyywrap
%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
extern int yylval;
%}

PT "."
SIGN [+-]?

%%
[ \t]+  	{}

"if"		{
                 yylval = copy_lex();
                 return IF;
                }
"return"	{
                 yylval = copy_lex();
                 return RETURN;                
                }
"void"   	{
                 yylval = copy_lex();
                 return VOID;                
                }
"int"		{
                 yylval = copy_lex();
                 return INT;
                }
"double"	{
                 yylval = copy_lex();
                 return REAL;
                }
"while"		{
                 yylval = copy_lex();
                 return WHILE;
                }

[_a-zA-Z][_a-zA-Z0-9]*				{
                                                    yylval = copy_lex();
                                                    return IDENTIFIER;
                                                }
0|([1-9][0-9]*)					{
                                                    yylval = copy_lex();
                                                    return NUMBER_INT;
                                                }
[1-9]*[0-9]{PT}[0-9]+				{
                                                    yylval = copy_lex();
                                                    return NUMBER_DOUBLE;
                                                }
("0x"[1-9A-F][0-9A-F]*)|("0x"[1-9a-f][0-9a-f]*)	{
                                                    yylval = copy_lex();
                                                    return NUMBER_HEX;
                                                }
"+"	{
                 yylval = copy_lex();
                return ADD;
        }
"-"	{
                 yylval = copy_lex();
                return SUB;
        }
"*"	{
                 yylval = copy_lex();
                return MUL;
        }
"/" 	{
                 yylval = copy_lex();
                return DIV;
        }
"="	{
                 yylval = copy_lex();
                return EQUAL;
        }
">"	{
                 yylval = copy_lex();
                return GREATER;
        }
"<"	{
                 yylval = copy_lex();
                return LESS;
        }
"("	{
                 yylval = copy_lex();
                return LEFT_PARENTHESIS;
        }
")"	{
                 yylval = copy_lex();
                return RIGHT_PARENTHESIS;
        }
"{"	{
                 yylval = copy_lex();
                return LEFT_BRACE;
        }
"}"	{
                 yylval = copy_lex();
                return RIGHT_BRACE;
        }
";"	{
                 yylval = copy_lex();
                return SEMICOLON;
        }
","	{
                 yylval = copy_lex();
                return COMMA;
        }
%%

/*
  word passing function
*/
int copy_lex()
{
//    printf("<%s>",yytext);
      static char Buffer[10000];
      static char *Pointer=Buffer;
      int p = (int)Pointer;
      strcpy(Pointer,yytext);
      Pointer += strlen(yytext)+1;
//    printf("<%s>",yytext);
      return p;
}