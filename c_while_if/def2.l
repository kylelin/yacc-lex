%option noyywrap
%{
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
extern int yylval;
%}

%%
[ \t]+                              {}
"int"                               {
                                        yylval = copy_lex();
                                        //printf("#INT ");
                                        return TYPENAME;
                                    }
"double"                            {
                                        yylval = copy_lex();
                                        //printf("#DOUBLE ");
                                        return TYPENAME;
                                    }
"if"                                {
                                        yylval = copy_lex();
                                        //printf("#IF ");
                                        return IF;
                                    }
"while"                             {
                                        yylval = copy_lex();
                                        //printf("#WHILE ");
                                        return WHILE;
                                    }
[a-zA-X_][a-zA-Z0-9]*               {
                                        yylval = copy_lex();
                                        //printf("#IDENTIFIER ");
                                        return IDENTIFIER;
                                    }
[0-9]+"."[0-9]+([eE][-+]?[0-9]+)    {
                                        yylval = copy_lex();
                                        //printf("#REAL ");
                                        return REAL;
                                    }
0|[+-]?([1-9][0-9]*)                {
                                        yylval = copy_lex();
                                        //printf("#INTEGER ");
                                        return INTEGER;
                                    }
0x[0-9a-fA-F]+                      {
                                        yylval = copy_lex();
                                        //printf("#HEXADECIMAL ");
                                        return HEXADECIMAL;
                                    }
"="                                 {
                                        yylval = copy_lex();
                                        //printf("#OPERATOR ");
                                        return OPERATOR;
                                    }
"+"                                 {
                                        yylval = copy_lex();
                                        //printf("#OPERATOR ");
                                        return OPERATOR;
                                    }
"-"                                 {
                                        yylval = copy_lex();
                                        //printf("#OPERATOR ");
                                        return OPERATOR;
                                    }
"*"                                 {
                                        yylval = copy_lex();
                                        //printf("#OPERATOR ");
                                        return OPERATOR;
                                    }
"/"                                 {
                                        yylval = copy_lex();
                                        //printf("#OPERATOR ");
                                        return OPERATOR;
                                    }
"<"                                 {
                                        yylval = copy_lex();
                                        //printf("#OPERATOR ");
                                        return OPERATOR;
                                    }
">"                                 {
                                        yylval = copy_lex();
                                        //printf("#OPERATOR ");
                                        return OPERATOR;
                                    }
")"                                 {
                                        yylval = copy_lex();
                                        //printf("#RIGHT_PARENTHESIS ");
                                        return RIGHT_PARENTHESIS;
                                    }
"("                                 {
                                        yylval = copy_lex();
                                        //printf("#LEFT_PARENTHESIS ");
                                        return LEFT_PARENTHESIS;
                                    }
"}"                                 {
                                        yylval = copy_lex();
                                        //printf("#RIGHT_BRACE ");
                                        return RIGHT_BRACE;
                                    }
"{"                                 {
                                        yylval = copy_lex();
                                        //printf("#LEFT_BRACE ");
                                        return LEFT_BRACE;
                                    }
";"                                 {
                                        yylval = copy_lex();
                                        //printf("#SEMICOLON ");
                                        return SEMICOLON;
                                    }
","                                 {
                                        yylval = copy_lex();
                                        //printf("#COMMA ");
                                        return COMMA;
                                    }
%%

int copy_lex()
{
	static char Buffer[10000];
	static char *Pointer = Buffer;
	int p = (int)Pointer;
	strcpy(Pointer, yytext);
	Pointer += strlen(yytext) + 1;
	return p;
}