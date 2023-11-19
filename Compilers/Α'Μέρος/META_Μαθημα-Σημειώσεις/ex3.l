/* Repeats integers, +, * /*
/* flex -o ex3.c ex3.l */
/* gcc -o ex3 ex3.c -lfl */

%{
	#include "header.h"
	void yyerror(char *s);
	int linenum = 1;
%}

digit		[0-9]
int_const	{digit}+

%%

{int_const}	{ printf("%d\n", atoi(yytext)); return INTEGER_LITERAL; }
"+"		{ printf("%s\n", yytext); return PLUS; }
"*"		{ printf("%s\n", yytext); return MULT; }
[ \t]*		{}
[\n]		{ linenum++; }
.		{ yyerror("Error Message!"); exit(1); }

%%

void yyerror (char *s) {
   fprintf (stderr, "%s\n", s);
}

/* edw leipei h main alla me ton diakopth -lfl
ftiaxnei mono tou mia main*/

//den mporoume na to kanoum stin ergasia mas omws.
