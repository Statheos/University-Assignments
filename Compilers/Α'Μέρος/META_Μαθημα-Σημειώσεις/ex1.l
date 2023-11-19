/* Prints line number and text */
/* flex -o ex1.c ex1.l */
/* gcc -o ex1 ex1.c */
%option noyywrap
%{
	#include <stdio.h>
	int lineno = 1;
%}
line	.*\n
%%
{line}	{ printf("%d %s", lineno++, yytext); }
%%
void main()
{ yylex(); }
