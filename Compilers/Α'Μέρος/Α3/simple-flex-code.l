/* Onoma arxeiou: simple-flex-code.l
   Perigrafh:     lektikoS analythS me xrhsh tou ergaleiou Flex
   Syggrafeas:    Foitites apo to Ergasthrio Metaglwttistwn , 
                  Tmhma Mhxanikwn Plhroforikhs kai Ypologistwn, UNIWA
   Sxolia:   To paron programma ylopoiei (me th xrhsh Flex) enan aplo lektiko analyth
	      pou anagnwrizei kena (space kai tab) kai akeraious gia th glwssa Mini-CLIPS
	      enw diaxeirizetai tous eidikous xarakthres neas grammhs '\n' (new line) kai
	      'EOF' (end of file).
   Odhgies ekteleshs:   Dinete "./Makefile" xwris ta eisagwgika ston trexonta katalogo. 
   Enallaktika:
			flex -o simple-flex-code.c simple-flex-code.l
                     gcc -o simple-flex-code simple-flex-code.c
                     ./simple-flex-code input.txt output.txt
		     rm simple-flex-code simple-flex-code.c
*/

/* H anagnwsh periorizetai se ena mono arxeio kai termatizei sto prwto EOF */
%option noyywrap


/* Kwdikas C gia orismo twn apaitoumenwn header files kai twn metablhtwn.
   Otidhpote anamesa sta %{ kai %} metaferetai autousio sto arxeio C pou
   tha dhmiourghsei to Flex. */

%{

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

/* Header file pou periexei lista me ola ta tokens */
#include "token.h"

/* Orismos metrhth trexousas grammhs */
int line = 1;

%}


/* Onomata kai antistoixoi orismoi (ypo morfh kanonikhs ekfrashs).
   Meta apo auto, mporei na ginei xrhsh twn onomatwn (aristera) anti twn,
   synhthws idiaiterws makrskelwn kai dysnohtwn, kanonikwn ekfrasewn */

DELIMITER       [\t]+
INTCONST        0|(\+|-)?([1-9]{1}[0-9]*)+
VARIABLE	(\?)([0-9]|[a-z]|[A-Z])+
RESERVED1       ((deffacts)|(defrule))+
RESERVED2       ((test)|(printout))+
RESERVED3	=|\+|-|\*|\/
ARGUMENT	([a-z]|[A-Z])([0-9]|[a-z]|[A-Z]|-|_)+
COMMENTS	(;)(.)*$
SEPARATOR	[\n]$|\(|\)|\s
UNKNOWN		(.)+

/* Gia kathe pattern (aristera) pou tairiazei ekteleitai o antistoixos
   kwdikas mesa sta agkistra. H entolh return epitrepei thn epistrofh
   mias arithmhtikhs timhs mesw ths synarthshs yylex() */

/*
   STON KANONA COMMENTS YPARXEI TO { }, ENW THA EPREPE 
   NA YPARXEI { RETURN COMMENTS; } AYTO "{ }" SIMAINEI NA MHN
   GYRISOUN TIPOTA, KOINWS NA AGNOITHUN. ANTISTOIXA GINETAI KAI ME 
   TO [ ] (KENO).
   TELOS,FTIAXSAME KAI ENAN NEO KANONA ME ONOMA "UNKNOWN" OPOU DEXETE OLA TA ORISMATA
   POU DEN ANTISTOIXOUN SE KAPOION APO TOUS YPOLOIPOUS KANONES. DILADI OLA TA 
   LANTHASMENA ORISMATA.
*/

%%

{DELIMITER}     { return DELIMITER; }
{RESERVED1}	{ return RESERVED1; }
{RESERVED2}	{ return RESERVED2; }
{RESERVED3}	{ return RESERVED3; }
{INTCONST}      { return INTCONST; }
{VARIABLE}	{ return VARIABLE; }
{ARGUMENT}	{ return ARGUMENT; }
{COMMENTS}	{ }
[ ]		{ }
{SEPARATOR}	{ return SEPARATOR; }
{UNKNOWN}	{ return UNKNOWN; }
\n              { line++; printf("\t#end-of-line#\n"); }
<<EOF>>		{ printf("#END-OF-FILE#\n"); exit(0); }

%%

/* Pinakas me ola ta tokens se antistoixia me tous orismous sto token.h */
char *tname[10] = {"DELIMITER","INTCONST" ,"VARIABLE","ARGUMENT","RESERVED1","RESERVED2","RESERVED3","COMMENTS", "SEPARATOR", "UNKNOWN" };


/* H synarthsh main: O kwdikas autos tha topotheththei autousios sto
   programma C pou tha dhmiourghsei to Flex kai tha apotelesei to arxiko
   shmeio ekteleshs ths efarmoghs tou lektikou analyth. */

int main(int argc, char **argv){
        int token,count=0;

       /* Ginetai o elegxos twn orismatwn ths grammhs entolwn. Ean ta
           orismata einai 3, to programma diabazei apo to arxeio tou 2ou
           orismatos kai grafei sto arxeio tou 3ou. Ean ta orismata einai
           2 diabazei apo to arxeio tou 2ou kai grafei sthn othonh.
           Ypenthymizetai oti to 1o orisma (argv[0]) sth C einai to onoma
           tou idiou tou ektelesimou arxeiou. */

   if(argc == 3){
      if(!(yyin = fopen(argv[1], "r"))) {
                fprintf(stderr, "Cannot read file: %s\n", argv[1]);
                return 1;
                }
      if(!(yyout = fopen(argv[2], "w"))) {
                fprintf(stderr, "Cannot create file: %s\n", argv[2]);
                return 1;
                }
        }
       else if(argc == 2){
                if(!(yyin = fopen(argv[1], "r"))) {
                        fprintf(stderr, "Cannot read file: %s\n", argv[1]);
                        return 1;
                }
        }

        /* H synarthsh yylex diabazei xarakthres apo thn eisodo kai prospathei
           na angnwrisei tokens. Ta tokens pou anagnwrizei einai auta pou exoun
           oristei sto paron arxeio, anamesa sta %% kai %%. An o kwdikas pou
           antistoixei se kapoio pattern periexei thn entolh 'return TIMH', h
           yylex() epistrefei thn timh auth h opoia kai apothhkeyetai sth
           metablhth token. */

  while( (token=yylex()) >= 0){
                /* Gia kathe token pou anagnwristhke, ektypwnetai h grammh pou auto
                   brethhke kathws kai to onoma tou mazi me thn timh tou. */
		/*
		  AN KAPOIO ORISMA DEN ANHKEI SE ENAN APO TOUS KANONES POU ORIZEI H GLWSSA
		  MINI-CLIPS, TOTE TO DEXETE O KANONAS UNKNOWN. O KANONAS UNKNOWN DILADI DEXETE
		  OLA TA LANTHASMENA ORISMATA. TO PARAKATW IF ELEGXEI AN TO ORISMA PIGAINEI STON 
		  KANONA UNKNOWN KAI AN PIGENEI TOTE EPISTREFEI THN fprintf POU PERIEXEI:
		  1) THN GRAMMI TOU ORISMATOS, 2) UKNOWN TOKEN 3)TO ORISMA. AN TO ORISMA DEN ANHKEI
		  STON KANONA UNKNOWN, TOTE EMFANIZETAIH fprintf TOU ELSE. OI KANONES RESERVED1, RESERVED2, RESERVED3 MPIKAN PANO APO TOYS KANONES 
		  INTCONST,VARIABLE,ARGUMENT WSTE NA EXOYN AFKSIMENI PROTEROTHTA.
   		*/	
	if (tname[token-1] == "UNKNOWN")
	  fprintf(yyout, "Line=%d, token=UNKNOWN TOKEN, value=\"%s\"\n", line, yytext);
	else
  	  fprintf(yyout, "Line=%d, token=%s, value=\"%s\"\n", line, tname[token-1], yytext);
        }
       return 0;
}
