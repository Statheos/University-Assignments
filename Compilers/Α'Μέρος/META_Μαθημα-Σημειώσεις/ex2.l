/* Repeats anything that begins or ends with 'a' */
/* flex -o ex2.c ex2.l */
/* gcc -o ex2 ex2.c */
%option noyywrap
%{
	#include <stdio.h>
%}
ends_with_a	.*a\n
begins_with_a	a.*\n

%%
{ends_with_a}	ECHO;
{begins_with_a}	ECHO;
.*\n	;
%%

void main()
{ yylex(); }
