/* 
Onoma arxeiou:	ergasia.y
Perigrafh: 	Bison arxeio gia syntaktiko elegxo ths ergasias B2 
Syggrafeas: 	Pikridas Menelaos 141291 - Kwnstantinos Stathakopoulos 161041
 
*/

%{

/*
______________________________________________________________
Orismoi kai dhlwseis glwssas C.
Otidhpote exei na kanei me orismo h arxikopoihsh  metablhtwn, arxeia header kai dhlwseis #define mpainei se auto to shmeio 
_______________________________________________________________
*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int line;
int flag=0;
int sosleks = 0; // METRITIS SWSTWN LEKSEWN
int lathosleks = 0; // METRITIS LANTHASMENWN LEKSEWN
int sosekf = 0; // METRITIS SWSTWN EKFRASEWN
int lathosekf = 0; // METRITIS LANTHASMENWN EKFRASEWN
extern char * yytext;
extern FILE *yyin, *yyout;  // GIA DIAVASMA TWN ARXEIWN INPUT-OUTPOUT
#define YYSTYPE int
%}

/*
____________________________________________ 
Orismos twn anagnwrisimwn lektikwn monadwn. 
___________________________________________
*/

%token PARENTHESI1 PARENTHESI2 INTCONST VARIABLE PLUS BIND MINUS MUL DIV PRINT TEST ARGUMENTS EQUAL DEFFACTS DEFRULE PRINTOUT COMMENTS NEWLINE END TOKEN_ERROR

/*
_________________________________________
Orismos tou symbolou enarkshs ths grammatikhs 
_____________________________________________
*/

%start program

%%

program:
	program gegonota END { printf("%d\n", $2); }
	| program eqexpr END { printf("%d\n", $2); }
	| program testexpr END { printf("%d\n", $2);  }
	| program deffactexpr END { printf("%d\n", $2);  }
	| program defrulexpr END { printf("%d\n", $2);  }
	| program printexpr END { printf("%d\n", $2);  }
	| program comments END { printf("%d\n", $2);  }
	| program prn END { printf("%d\n", $2);  }
	|
        ;

/*
ALLAGH TOY BISON WSTE NA ANAGNWRIZEI OLA TA ORISMATA POU DINEI O XRHSTHS APO TO ARXEIO
INPUT KAI NA TA DIAVAZEI WS TO TELOS MIAS GRAMMIS. ANTI GIA NEWLINE, EXOUME END.  
*/

deffactexpr:
	PARENTHESI1 DEFFACTS orismata defexpr PARENTHESI2 { sosekf++;}
	;

defrulexpr:
	PARENTHESI1 DEFRULE orismata gegonota PARENTHESI2 { sosekf++;  }
	;

printexpr:
	PARENTHESI1 PRINTOUT gegonota PARENTHESI2 {  sosekf++; printf("\n%s\n",yytext); }
	;

testexpr:
	PARENTHESI1 TEST eqexpr PARENTHESI2 { sosekf++; }
	;
/*
KWDIKAS WSTE NA ANAGNWRIZONTAI OI KANONES (DEFRULES),TA GEGONOTA (DEFFACTS), THN PRINTOUT KAI THN TEST
*/

gegonota:
	PARENTHESI1 stoixeio PARENTHESI2 { $$ = $2;  }
	| gegonota gegonota {}
	;

stoixeio:
	expr { $$ = $1; }
	| orismata { $$ = $1; sosleks++; }
	| stoixeio stoixeio { $$ = 0; }
	| ekxwrisi1 { $$ = $1; sosekf++; }
	| ekxwrisi2 { $$ = $1; sosekf++; }
	;
/*
O PARAPANW KWDIKAS EINAI GIA ANAGNWRISH ENOS H PARAPANW GEGONOTWN.
ANAGNWRIZONTAI STOIXEIA TA OPOIA MPOREI NA EINAI MATHIMATIKES PRAXSEIS, ONOMATA KAI EKXWRISEIS
*/

defexpr:
	PARENTHESI1 defexpr PARENTHESI2 { $$ = $2;  }
	| orismata { $$ = $1; sosleks++; }
	| INTCONST { $$ = $1; sosleks++; }
	| defexpr defexpr {}
	;
/*
KWDIKAS GEGONOTWN (DEFFACTS). DEXETAI MONO ENA H PARAPANW ORISMATA.
*/

expr:
	INTCONST         { $$ = atoi(yytext); }
	| VARIABLE	 { $$ = $1; sosleks++;  }
        | PLUS expr praxseis1 { $$ = $2 + $3; }
	| MINUS expr praxseis1 { $$ = $2 - $3;}
	| MUL expr praxseis2 { $$ = $2 * $3;}
	| DIV expr praxseis2 { if( ( $3 == 0 ) || ($2 == 0) ) { printf("divide by zero\n"); lathosekf++; sosekf--; } else $$ = $2 / $3;}
        ;
/* 
KWDIKAS POU ANAGNWRIZEI MATHIMATIKES PRAXSEIS.
SE PERIPTWSH DIAIRESHS ME TO "0" EMFANIZETAI MINIMA LATHOUS
KAI AYXSANETE O METRITIS TWN LANTHASMENWN EKFRASEWN. 
*/

praxseis1:
	expr	 { $$ = $1; }
	| praxseis1 praxseis1 { $$ = $1 + $2;}
	;
/* 
KWDIKAS POU EPITREPEI THN EISAGWGH POLLWN ARITHMWN ME ENA SYMBOLO "+" H "-".
*/

praxseis2:
	expr	 { $$ = $1; }
	| praxseis2 praxseis2 { $$ = $1 * $2;}
	;
/*
KWDIKAS POU EPITREPEI THN EISAGWGH POLLWN ARITHMWN ME ENA SYMBOLO "*" H "/".
*/

expr2:
	PARENTHESI1 expr PARENTHESI2 { $$ = $2; }
	| expr { $$ = $1; }
	;

eqexpr:
	PARENTHESI1 EQUAL expr2 expr2 PARENTHESI2 { if($3 == $4) $$=1; else $$ = 0;}
	;
/* 
KWDIKAS POU SYGKRINEI AN DYO H PERISSOTERES METAVLITES H ARITHMOI H METAVLITES ME ARITHMOUS EINAI ISA METAKSU TOYS.
*/

ekxwrisi1:
	BIND VARIABLE INTCONST { $2 = $3; $$ = $2; }
	;

ekxwrisi2:
	BIND VARIABLE PARENTHESI1 expr PARENTHESI2 { $2 = $4; $$ = $2; }
	;
/* 
KWDIKAS EKXWRISHS TIMIS SE METAVLITI
*/

orismata:
	ARGUMENTS { $$ = $1; }
	;
/* 
KWDIKAS ANAGNWRISIS ORISMATWN
*/

comments:
	COMMENTS { $$ = $1; }
	;
prn:
	PRINT { $$ = $1; }
	;
/* 
KWDIKAS ANAGNWRISIS SXOLIWN
*/

%%
/*
Epiprosthetos kwdikas-xrhsth se glwssa C pou tha symperilhfthei ston kwdika tou syntaktikoy analyth 
*/

FILE *yyin;
FILE *yyout;

int main(int argc,char **argv)
{
 int i;
 int ret = yyparse();
/*


	if(argc == 3){// an dwsei input+output tote ta anigei kai ta 2
		if(!(yyin = fopen(argv[1], "r"))) {//elegxos arxeiou
			fprintf(stderr, "Cannot read file: %s\n", argv[1]);//sfalma arxeiou
			return 1;
		}
		if(!(yyout = fopen(argv[2], "w"))) { //elegxos arxeiou
			fprintf(stderr, "Cannot create file: %s\n", argv[2]);//sfalma arxeiou
			return 1;
		}
	}
	else if(argc == 2){
		if(!(yyin = fopen(argv[1], "r"))) {
			fprintf(stderr, "Cannot read file: %s\n", argv[1]);
			return 1;
		}
	}
*/

/*
KWDIKAS POU EPITREPEI THN ANAGNWSI ORISMATWN APO ARXEIO
KAI THN EGGRAFH TWN APOTELESMATWN SE ARXEIO
H THN EMFANISI TOYS STO TERMATIKO
*/

 printf("\t\tPLITHOS SWSTWN LEKSEWN: %d\n",sosleks);
 printf("\t\tPLITHOS SWSTWN EKFRASEWN: %d\n",sosekf);
 printf("\n");
 printf("\t\tPLITHOS LANTHASMENWN LEKSEWN: %d\n",lathosleks);
 printf("\t\tPLITHOS LANTHASMENWN EKFRASEWN: %d\n",lathosekf);
/*
KWDIKAS EKTYPWSEIS SWSTWN KAI LANTHASMENWN EKFRASEWN KAI LEKSEWN
*/
 if (flag==0 && ret==0)
	printf("\t\tBison -> PARSING SUCCEEDED.\n");
 else
	printf("\t\tBison -> PARSING FAILED.\n");

return 0;
}
