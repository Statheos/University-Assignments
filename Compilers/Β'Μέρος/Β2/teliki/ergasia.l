/* Onoma arxeiou:	ergasia.l
   Perigrafh:	Eisodos ergaleiou Flex gia angnorisi orismatwn gia thn ergasia B2
   Syggrafeas:	Pikridas Menelaos 141291 - Kwnstantinos Stathakopoulos 161041
*/

%option noyywrap
%x error

/*
________________________________________________________

Kwdikas C gia orismo twn apaitoumenwn header files kai twn metablhtwn.
Otidhpote anamesa sta %{ kai %} metaferetai autousio sto arxeio C pou tha dhmiourghsei to Flex. 
__________________________________________________________
*/

%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Header file pou periexei lista me ola ta tokens.
   Prosoxh: Paragetai apo to ergaleio Bison */

#include "ergasia.tab.h"

/*
_____________________________________________

Orismos metrhth trexousas grammhs 
_________________________________________________
*/

int line=1;

void yyerror (const char *msg);
void prn(char *s);

%}

/*
_______________________________________________________

Onomata kai antistoixoi orismoi (ypo morfh kanonikhs ekfrashs).
Meta apo auto, mporei na ginei xrhsh twn onomatwn (aristera) anti twn,
synhthws idiaiterws makrsokelwn kai dysnohtwn, kanonikwn ekfrasewn 
____________________________________________________________
*/

DELIMITER	[ \t]+
PLUS		\+
MINUS		-
MUL		\*
DIV		\/
EQUAL		=
PARENTHESI1		\(
PARENTHESI2	\)
PRINT		"->"
DEFFACTS	"deffacts"
DEFRULE 	"defrule"
PRINTOUT	"printout t"
END		"\n"
INTCONST        0|(\+|-)?([1-9]{1}[0-9]*)+
VARIABLE	(\?)([0-9]|[a-z]|[A-Z])+
ARGUMENTS	([a-z]|[A-Z])([0-9]|[a-z]|[A-Z]|-|_)+
COMMENTS	(;)(.)+
NEWLINE		[\n]


/*
___________________________________________________________
 
Gia kathe pattern (aristera) pou tairiazei ekteleitai o antistoixos kwdikas mesa sta agkistra. 
_____________________________________________________________
*/

%%

{DELIMITER}     { }
{PLUS}		{ prn("+"); return PLUS; }
{MINUS} 	{ prn("-"); return MINUS; }
{MUL} 		{ prn("*"); return MUL; }
{DIV}		{ prn("/"); return DIV; }
{EQUAL}		{ prn("="); return EQUAL; }
{PARENTHESI1} 	{ prn("("); return PARENTHESI1; }
{PARENTHESI2} 	{ prn(")"); return PARENTHESI2; }
{PRINT}		{ prn("->"); return PRINT; }
{DEFFACTS}	{ prn("DEFFACTS"); return DEFFACTS; }
{DEFRULE}	{ prn("DEFRULE"); return DEFRULE; }
{PRINTOUT}	{ prn("PRINTOUT T"); return PRINTOUT; }
{INTCONST}      { prn("INTCONST"); return INTCONST; }
{VARIABLE}	{ prn("VARIABLE"); return VARIABLE; }
{ARGUMENTS}	{ prn("ARGUMENTS"); return ARGUMENTS; }
{COMMENTS}	{ prn("COMMENTS"); }
{END}		{ return END; }
.                 {yyerror ("Unrecognized token error!"); BEGIN(error); return TOKEN_ERROR;}
<error>.          {}
<error>\n         {BEGIN(0);}

%%

/*
H synarthsh typwnei sthn eksodo ena mhnyma lathous sthn periptwsh pou anagnwristei lanthasmeno token opws px. akeraios pou teleiwnei me gramma.
*/

void yyerror (const char *msg)
{
    fprintf(yyout, "\tFlex -> ERROR, line %d at lexeme \'%s\' : %s\n",line, yytext, msg);
}

/*
H synarthsh typwnei sthn othonh to keimeno tou anagnwristikou pou tairiakse me kapoion kanona. Xrhsimopoieitai kathara gia logous katanohshs kai debugging. 
*/

void prn(char *s)
{
	printf("\tFlex -> Matched token: %s\n", yytext);
}
