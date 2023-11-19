/* Same as ex3, but with more verbose output */
/* flex -o ex4.c ex4.l */
/* gcc -o ex4 ex4.c -lfl */
%{
	#include "header.h"
	void yyerror(char *s);
	int linenum = 1;
%}

digit		[0-9]
int_const	{digit}+

%%

{int_const}	{ printf("\tRead: %d (2x=%d)\n", atoi(yytext), atoi(yytext)*2);
		  return INTEGER_LITERAL; }
"+"		{ printf("\tLine=%d, Read: %s\n", linenum, yytext);
		  return PLUS; }
"*"		{ printf("\tLine=%d, Read: %s\n", linenum, yytext);
		  return MULT; }
[ \t]*		{}
[\n]		{ linenum++; }
.		{ yyerror("Error: Unrecognized text"); exit(1); }

%%

void yyerror (char *s) {
   fprintf (stderr, "%s\n", s);
 }
