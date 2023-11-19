/* Onoma arxeiou:       simple-bison-code.y
   Perigrafh:           Ypodeigma gia anaptyksh syntaktikou analyth me xrhsh tou ergaleiou Bison
   Syggrafeas:          Ergasthrio Metaglwttistwn, Tmhma Mhxanikwn Plhroforikhs kai Ypologistwn,
                        Panepisthmio Dytikhs Attikhs
   Sxolia:              To paron programma ylopoiei (me th xrhsh Bison) enan aplo syntaktiko analyth
			pou anagnwrizei thn prosthesh akeraiwn arithmwn kai metablhtwn. Leitourgei
			autonoma, dhladh xwris Flex. Xrhsimopoiwntas thn synarthsh yylex anagnwrizei
			kena (space & tab), akeraious kai metablhtes gia th glwssa Mini-CLIPS
			enw diaxeirizetai tous eidikous xarakthres neas grammhs '\n' (new line) kai
			'EOF' (end of file).
   Odhgies ekteleshs:   Dinete "make" xwris ta eisagwgika ston trexonta katalogo. Enallaktika:
			bison -o simple-bison-code.c simple-bison-code.y
                        gcc -o simple-bison-code simple-bison-code.c
                        ./simple-bison-code
*/

%{
/* Orismoi kai dhlwseis glwssas C. Otidhpote exei na kanei me orismo h arxikopoihsh
   metablhtwn & synarthsewn, arxeia header kai dhlwseis #define mpainei se auto to shmeio */
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #define YYDEBUG 1
    int yylex(void);
    void yyerror(char *);
%}

/* Orismos twn anagnwrisimwn lektikwn monadwn. */
%token PARENTHESI1 PARENTHESI2 INTCONST VARIABLE PLUS NEWLINE MUL DIV MINUS EQUAL COMMENTS TEST DEFFACTS DEFRULE READ BIND PRINTOUT ARGUMENTS

%%

/* Orismos twn grammatikwn kanonwn. Kathe fora pou antistoixizetai enas grammatikos
   kanonas me ta dedomena eisodou, ekteleitai o kwdikas C pou brisketai anamesa sta
   agkistra. H anamenomenh syntaksh einai:
				onoma : kanonas { kwdikas C } */
program:
        program expr NEWLINE { printf("%d\n", $2); }
        |
        ;
expr:
        INTCONST { $$ = $1; }
        | PARENTHESI1 VARIABLE PARENTHESI2  { $$ = $2; }

        | PARENTHESI1 PLUS INTCONST INTCONST PARENTHESI2  { $$ = $3 + $4; }
        | PARENTHESI1 PLUS VARIABLE INTCONST PARENTHESI2  { $$ = $3 + $4; }
        | PARENTHESI1 PLUS INTCONST VARIABLE PARENTHESI2  { $$ = $3 + $4; }
        | PARENTHESI1 PLUS VARIABLE VARIABLE PARENTHESI2  { $$ = $3 + $4; }
	| PARENTHESI1 PLUS INTCONST INTCONST INTCONST PARENTHESI2 { $$ = $3 + $4 + $5; }
        | PARENTHESI1 PLUS INTCONST INTCONST VARIABLE PARENTHESI2 { $$ = $3 + $4 + $5; }
        | PARENTHESI1 PLUS INTCONST VARIABLE INTCONST PARENTHESI2 { $$ = $3 + $4 + $5; }
        | PARENTHESI1 PLUS INTCONST VARIABLE VARIABLE PARENTHESI2 { $$ = $3 + $4 + $5; }
        | PARENTHESI1 PLUS VARIABLE INTCONST INTCONST PARENTHESI2 { $$ = $3 + $4 + $5; }
        | PARENTHESI1 PLUS VARIABLE INTCONST VARIABLE PARENTHESI2 { $$ = $3 + $4 + $5; }
        | PARENTHESI1 PLUS VARIABLE VARIABLE INTCONST PARENTHESI2 { $$ = $3 + $4 + $5; }
        | PARENTHESI1 PLUS VARIABLE VARIABLE VARIABLE PARENTHESI2 { $$ = $3 + $4 + $5; }

        | PARENTHESI1 MINUS INTCONST INTCONST PARENTHESI2 { $$ = $3 - $4; }
        | PARENTHESI1 MINUS VARIABLE INTCONST PARENTHESI2 { $$ = $3 - $4; }
        | PARENTHESI1 MINUS INTCONST VARIABLE PARENTHESI2 { $$ = $3 - $4; }
        | PARENTHESI1 MINUS VARIABLE VARIABLE PARENTHESI2 { $$ = $3 - $4; }
	| PARENTHESI1 MINUS INTCONST INTCONST INTCONST PARENTHESI2 { $$ = $3 - $4 - $5; }
        | PARENTHESI1 MINUS INTCONST INTCONST VARIABLE PARENTHESI2 { $$ = $3 - $4 - $5; }
        | PARENTHESI1 MINUS INTCONST VARIABLE INTCONST PARENTHESI2 { $$ = $3 - $4 - $5; }
        | PARENTHESI1 MINUS INTCONST VARIABLE VARIABLE PARENTHESI2 { $$ = $3 - $4 - $5; }
        | PARENTHESI1 MINUS VARIABLE INTCONST INTCONST PARENTHESI2 { $$ = $3 - $4 - $5; }
        | PARENTHESI1 MINUS VARIABLE INTCONST VARIABLE PARENTHESI2 { $$ = $3 - $4 - $5; }
        | PARENTHESI1 MINUS VARIABLE VARIABLE INTCONST PARENTHESI2 { $$ = $3 - $4 - $5; }
        | PARENTHESI1 MINUS VARIABLE VARIABLE VARIABLE PARENTHESI2 { $$ = $3 - $4 - $5; }

        | PARENTHESI1 MUL INTCONST INTCONST PARENTHESI2 { $$ = $3 * $4; }
        | PARENTHESI1 MUL VARIABLE INTCONST PARENTHESI2 { $$ = $3 * $4; }
        | PARENTHESI1 MUL INTCONST VARIABLE PARENTHESI2 { $$ = $3 * $4; }
        | PARENTHESI1 MUL VARIABLE VARIABLE PARENTHESI2 { $$ = $3 * $4; }
	| PARENTHESI1 MUL INTCONST INTCONST INTCONST PARENTHESI2 { $$ = $3 * $4 * $5; }
        | PARENTHESI1 MUL INTCONST INTCONST VARIABLE PARENTHESI2 { $$ = $3 * $4 * $5; }
        | PARENTHESI1 MUL INTCONST VARIABLE INTCONST PARENTHESI2 { $$ = $3 * $4 * $5; }
        | PARENTHESI1 MUL INTCONST VARIABLE VARIABLE PARENTHESI2 { $$ = $3 * $4 * $5; }
        | PARENTHESI1 MUL VARIABLE INTCONST INTCONST PARENTHESI2 { $$ = $3 * $4 * $5; }
        | PARENTHESI1 MUL VARIABLE INTCONST VARIABLE PARENTHESI2 { $$ = $3 * $4 * $5; }
        | PARENTHESI1 MUL VARIABLE VARIABLE INTCONST PARENTHESI2 { $$ = $3 * $4 * $5; }
        | PARENTHESI1 MUL VARIABLE VARIABLE VARIABLE PARENTHESI2 { $$ = $3 * $4 * $5; }

        | PARENTHESI1 DIV INTCONST INTCONST PARENTHESI2 { $$ = $3 / $4; }
        | PARENTHESI1 DIV VARIABLE INTCONST PARENTHESI2 { $$ = $3 / $4; }
        | PARENTHESI1 DIV INTCONST VARIABLE PARENTHESI2 { $$ = $3 / $4; }
        | PARENTHESI1 DIV VARIABLE VARIABLE PARENTHESI2 { $$ = $3 / $4; }
	| PARENTHESI1 DIV INTCONST INTCONST INTCONST PARENTHESI2 { $$ = $3 / $4 / $5; }
        | PARENTHESI1 DIV INTCONST INTCONST VARIABLE PARENTHESI2 { $$ = $3 / $4 / $5; }
        | PARENTHESI1 DIV INTCONST VARIABLE INTCONST PARENTHESI2 { $$ = $3 / $4 / $5; }
        | PARENTHESI1 DIV INTCONST VARIABLE VARIABLE PARENTHESI2 { $$ = $3 / $4 / $5; }
        | PARENTHESI1 DIV VARIABLE INTCONST INTCONST PARENTHESI2 { $$ = $3 / $4 / $5; }
        | PARENTHESI1 DIV VARIABLE INTCONST VARIABLE PARENTHESI2 { $$ = $3 / $4 / $5; }
        | PARENTHESI1 DIV VARIABLE VARIABLE INTCONST PARENTHESI2 { $$ = $3 / $4 / $5; }
        | PARENTHESI1 DIV VARIABLE VARIABLE VARIABLE PARENTHESI2 { $$ = $3 / $4 / $5; }

        | PARENTHESI1 EQUAL INTCONST INTCONST PARENTHESI2 { $$ = $3 == $4; }
        | PARENTHESI1 EQUAL VARIABLE INTCONST PARENTHESI2 { $$ = $3 == $4; }
        | PARENTHESI1 EQUAL INTCONST VARIABLE PARENTHESI2 { $$ = $3 == $4; }
        | PARENTHESI1 EQUAL VARIABLE VARIABLE PARENTHESI2 { $$ = $3 == $4; }
	| PARENTHESI1 EQUAL INTCONST INTCONST INTCONST PARENTHESI2 { $$ = $3 == $4 == $5; }
        | PARENTHESI1 EQUAL INTCONST INTCONST VARIABLE PARENTHESI2 { $$ = $3 == $4 == $5; }
        | PARENTHESI1 EQUAL INTCONST VARIABLE INTCONST PARENTHESI2 { $$ = $3 == $4 == $5; }
        | PARENTHESI1 EQUAL INTCONST VARIABLE VARIABLE PARENTHESI2 { $$ = $3 == $4 == $5; }
        | PARENTHESI1 EQUAL VARIABLE INTCONST INTCONST PARENTHESI2 { $$ = $3 == $4 == $5; }
        | PARENTHESI1 EQUAL VARIABLE INTCONST VARIABLE PARENTHESI2 { $$ = $3 == $4 == $5; }
        | PARENTHESI1 EQUAL VARIABLE VARIABLE INTCONST PARENTHESI2 { $$ = $3 == $4 == $5; }
        | PARENTHESI1 EQUAL VARIABLE VARIABLE VARIABLE PARENTHESI2 { $$ = $3 == $4 == $5; }

        | PARENTHESI1 EQUAL PARENTHESI1 PLUS INTCONST INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 + $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS INTCONST INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL INTCONST INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV INTCONST INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 / $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 PLUS VARIABLE INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 + $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS VARIABLE INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL VARIABLE INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV VARIABLE INTCONST PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 / $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 PLUS INTCONST INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 + $6 == $7; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS INTCONST INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL INTCONST INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV INTCONST INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 / $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 PLUS VARIABLE INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 + $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS VARIABLE INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL VARIABLE INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV VARIABLE INTCONST PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 / $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 PLUS INTCONST VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 + $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS INTCONST VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL INTCONST VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV INTCONST VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 / $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 PLUS VARIABLE VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 + $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS VARIABLE VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL VARIABLE VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV VARIABLE VARIABLE PARENTHESI2 INTCONST PARENTHESI2 { $$ == $5 / $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 PLUS INTCONST VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 + $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS INTCONST VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL INTCONST VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV INTCONST VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 / $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 PLUS VARIABLE VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 + $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MINUS VARIABLE VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 - $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 MUL VARIABLE VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 * $6 == $8; }
        | PARENTHESI1 EQUAL PARENTHESI1 DIV VARIABLE VARIABLE PARENTHESI2 VARIABLE PARENTHESI2 { $$ == $5 / $6 == $8; }

        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 PLUS INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; } 
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MINUS INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 - $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MUL INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 * $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 DIV INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 / $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 PLUS INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 MINUS INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 - $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 MUL INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 * $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 DIV INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 / $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 PLUS INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MINUS INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 - $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MUL INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 * $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 DIV INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 / $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 PLUS INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 MINUS INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 - $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 MUL INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 * $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 DIV INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 / $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 PLUS VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MINUS VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 - $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MUL VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 * $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 DIV VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 / $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 PLUS VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 MINUS VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 - $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 MUL VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 * $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 DIV VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 / $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 PLUS VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MINUS VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 - $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 MUL VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 * $7; }
        | PARENTHESI1 EQUAL INTCONST PARENTHESI1 DIV VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 / $7; }
        | PARENTHESI1 EQUAL VARIABLE PARENTHESI1 PLUS VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 == $6 + $7; }

	| PARENTHESI1 TEST VARIABLE INTCONST PARENTHESI2 { $$ = $3 == $4; }
	| PARENTHESI1 TEST VARIABLE VARIABLE PARENTHESI2 { $$ = $3 == $4; }

        | PARENTHESI1 TEST PARENTHESI1 EQUAL INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $2 == $4; }
        | PARENTHESI1 TEST PARENTHESI1 EQUAL VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $5 == $6; }
        | PARENTHESI1 TEST PARENTHESI1 EQUAL INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $5 == $6; }
        | PARENTHESI1 TEST PARENTHESI1 EQUAL VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $5 == $6; }

        | PARENTHESI1 ARGUMENTS PARENTHESI2 { $$ = $2; }

	| PARENTHESI1 DEFFACTS ARGUMENTS PARENTHESI2 { $$ = $2; }
	| PARENTHESI1 DEFFACTS ARGUMENTS PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI2 { $$ = $2, $3, $4; }
	| PARENTHESI1 DEFFACTS ARGUMENTS PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI2 { $$ = $2, $3, $4, $8; }
	//| PARENTHESI1 DEFFACTS ARGUMENTS PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI1 ARGUMENTS PARENTHESI2  PARENTHESI2 { $$ = $2, $3, $4, $8; }
	
	| PARENTHESI1 DEFRULE ARGUMENTS PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI2 { $$ = $2, $3, $4; }
	| PARENTHESI1 DEFRULE ARGUMENTS PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI2 { $$ = $2, $3, $4, $8; }
	//| PARENTHESI1 DEFRULE ARGUMENTS PARENTHESI1 ARGUMENTS PARENTHESI2 PARENTHESI1 ARGUMENTS PARENTHESI2  PARENTHESI2 { $$ = $2; }

	| PARENTHESI1 BIND VARIABLE INTCONST PARENTHESI2 { $$ = $3 = $4; }
	| PARENTHESI1 BIND VARIABLE VARIABLE PARENTHESI2 { $$ = $3 = $4; }
/*
	OI KANONES AYTOI DEN LEITOURGOUN SWSTA EPEIDI O LEKTIKOS ANALYTHS PROSPATHEI NA VREI TOKEN "()" TO OPOIO DEN YPARXEI.

	| PARENTHESI1 BIND VARIABLE PARENTHESI1 READ INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 PLUS INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 + $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MINUS INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 - $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MUL INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 * $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 DIV INTCONST INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 / $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 PLUS INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 + $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MINUS INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 - $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MUL INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 * $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 DIV INTCONST VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 / $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 PLUS VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 + $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MINUS VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 - $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MUL VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 * $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 DIV VARIABLE INTCONST PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 / $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 PLUS VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 + $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MINUS VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 - $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 MUL VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 * $7; }
	| PARENTHESI1 BIND VARIABLE PARENTHESI1 DIV VARIABLE VARIABLE PARENTHESI2 PARENTHESI2 { $$ = $3 = $6 / $7; }
*/
	| PARENTHESI1 READ INTCONST PARENTHESI2 { $$ = $3; }

	| PARENTHESI1 PRINTOUT ARGUMENTS PARENTHESI2 { $$ = $3; }

	| COMMENTS { $$ = $1; }
	|
        ;
     
%%

/* H synarthsh yylex ylopoiei enan autonomo lektiko analyth. Edw anagnwrizontai
   oi lektikes monades ths glwssas Mini-CLIPS */
int yylex() {
	char buf[100];
	char num = 0;
	int minus = 1;
	int zero = 0;
	int com=0;
	int number=0;
    	char c;
	// Diabase enan xarakthra apo thn eisodo
        c = getchar();
    //ANOIGMA PARENTHESIS    
        if ( c == '(')
            return PARENTHESI1;
        // Ean o xarakthras einai keno h tab, agnohse ton kai diabase ton epomeno
        while (c == ' ' || c == '\t') { yylval = 0; c = getchar(); }

	//AN VRETHEI O XARAKTHRAS ? TOTE EXOYME METAVLITI
        if (c == '?')
        {
		sprintf(buf, "?");
		c = getchar();
		while((c >= 'A' && c <= 'Z') ||
		      (c >= 'a' && c <= 'z') ||
		      (c >= '0' && c <= '9'))
		{
			sprintf(buf, "%s%c", buf, c);
			c = getchar();
		}
		ungetc(c, stdin);
		yylval = 0;
		return VARIABLE;
        }
    

	// AN DOTHEI ; PROKEITAI GIA SXOLIA
	if (c == ';')
	{
        com =1;
		sprintf(buf, ";");
		c = getchar();
		while((c >= 'A' && c <= 'Z') ||    //ANAGNORIZEI EKTOS APO XARAKTIRES KAI ARITMOUS TO SPACE KAI ALLA SYMBOLA THS GLWSSAS.
		      (c >= 'a' && c <= 'z') ||
		      (c >= '0' && c <= '9') ||
		      (c == '_' || c == '-') || 
		      (c == ';' || c == ' ') ||
		      (c == '?' || c == '*') ||      
		      (c == '+' || c == '='))	
		{
			sprintf(buf, "%s%c", buf, c);
			c = getchar();
		}
		ungetc(c, stdin);
		yylval = 0;
		if (com == 1)
		{
           		printf("This is a comment\n");
			ungetc(c, stdin);
           		yylval = 0;
			c = getchar();
		}
	}


	// AN DOTHEI DESMEVMENI LESKSI
	if ( (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') )
	{
		sprintf(buf, "%c",c);
		c = getchar();
		while((c >= 'A' && c <= 'Z') ||
		      (c >= 'a' && c <= 'z'))
		{
			sprintf(buf, "%s%c", buf, c);
			c = getchar();
		}

		printf("\nO BUFFER TWRA EXEI MESA: %s\n",buf);

		if (( strcmp(buf,"test") == 0 ) || ( strcmp(buf,"TEST") == 0 ))
			{			
				ungetc(c, stdin);
				yylval = 0;	
				return TEST;	
			}
		else  if (( strcmp(buf,"read") == 0 ) || ( strcmp(buf,"READ") == 0 ))
			{			
				ungetc(c, stdin);
				yylval = 0;
				return READ;

				c = getchar();
				while (c >= '0' && c <= '9')
       			 	{
				if (zero > 0) {zero = 0; yyerror("integer starting with zero"); exit(1);}
				if (c == '0') zero++;
                			yylval = (yylval * 10) + (c - '0');
					num = 1;
					c = getchar();
        			}
				 if (num)
				{
					ungetc(c, stdin);
					return INTCONST;
				}
			}
		else  if (( strcmp(buf,"printout") == 0 ) || ( strcmp(buf,"PRINTOUT") == 0 ))
			{			
				ungetc(c, stdin);
				yylval = 0;	
				return PRINTOUT;
				c=getchar();
				if ( (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') )
				{
					sprintf(buf, "%c", c);
					c = getchar();
					while((c >= 'A' && c <= 'Z') ||
		      			     (c >= 'a' && c <= 'z') || 
		      			     (c >= '0' && c <= '9') || 
		       			      c==' ')   //TO SPACE EINAI GIA NA MPOROUME NA EXOYME PERISSOTERES "LEKSEIS".
					{
						sprintf(buf, "%s%c", buf, c);
						c = getchar();
					}
					ungetc(c, stdin);
					yylval = 0;
					return ARGUMENTS;
					printf("TO ORISMA POU DWSATE EINAI: %s\n",buf);
				}
			}
	}

	// AN DOTHEI ORISMA
	if ( (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') )
	{
		sprintf(buf, "%c", c);
		c = getchar();
		while((c >= 'A' && c <= 'Z') ||
		      (c >= 'a' && c <= 'z') || 
		      (c >= '0' && c <= '9') || 
		       c==' ')   //TO SPACE EINAI GIA NA MPOROUME NA EXOYME PERISSOTERES "LEKSEIS".
		{
			sprintf(buf, "%s%c", buf, c);
			c = getchar();
		}
		ungetc(c, stdin);
		yylval = 0;
		return ARGUMENTS;
	}


        // Gia kathe xarakthra pou einai arithmos ginetai h topothethsh tou sthn yylval
        while (c >= '0' && c <= '9')
        {
		if (zero > 0) {zero = 0; yyerror("integer starting with zero"); exit(1);}
		if (c == '0') zero++;
                yylval = (yylval * 10) + (c - '0');
		num = 1;
		c = getchar();
        }

        if (num)
	{
		ungetc(c, stdin);
		return INTCONST;
	}

	// Ean o xarakthras einai to symbolo + h to - prokeitai gia proshmo h praksh?
        if (c == '+' || c == '-')
	{
		if (c == '-') minus = -1;
		c = getchar();
		if (c >= '0' && c <= '9')
		{
			// Einai proshmo. Diabase ton arithmo
			while (c >= '0' && c <= '9')
			{
				if (zero > 0) {zero = 0; yyerror("integer starting with zero"); exit(1);}
				if (c == '0') zero++;
				yylval = (yylval * 10) + (c - '0');
				num = 1;
				c = getchar();
			}
			if (num)
			{
				ungetc(c, stdin);
				yylval = yylval * minus; minus = 1;
				return INTCONST;
			}
		}
		else
		{
			// Einai praksh
			ungetc(c, stdin);
			if (minus == 1) return PLUS;
			if (minus == -1) return MINUS;
		}
	}


	// Ean prokeitai gia ton eidiko xarakthra neas grammhs
        if (c == '\n') { yylval = 0; return NEWLINE;}

	// Ean prokeitai gia ton eidiko xarakthra telous arxeiou
	if (c == EOF) { exit(0); }
	
	// EAN PROKEITAI GIA TH PRAXI TOU POLLAPLASIASMOU
        if (c == '*') return MUL;

	// EAN PROKEITAI GIA TH PRAXI THS DIAIRESHS
	if (c == '/') return DIV;
	// EAN PROKEITE GIA SYGKRISI
	if ( c == '=') return EQUAL;

	//KLESIMO PARENTHESIS
	if ( c == ')') return PARENTHESI2;

	// Gia otidhpote allo kalese thn yyerror me mhnyma lathous
	yyerror("invalid character");
}


/* H synarthsh yyerror xrhsimopoieitai gia thn anafora sfalmatwn. Sygkekrimena kaleitai
   apo thn yyparse otan yparksei kapoio syntaktiko lathos. Sthn parakatw periptwsh h
   synarthsh epi ths ousias typwnei mhnyma lathous sthn othonh. */
void yyerror(char *s) {
        fprintf(stderr, "Error: %s\n", s);
}


/* H synarthsh main pou apotelei kai to shmeio ekkinhshs tou programmatos.
   Sthn sygkekrimenh periptwsh apla kalei thn synarthsh yyparse tou Bison
   gia na ksekinhsei h syntaktikh analysh. */
int main(void) 
{
//FILE *fp;
/*
if (argc == 2)
 if ( !(fp = fopen(argv[1], "r")))
	{
		yyerror("Error opening file for reading");
	}
*/
yydebug = 1;
yyparse();
return 0;
}
