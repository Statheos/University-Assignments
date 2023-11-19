%option noyywrap

%{ 
    #include <stdio.h>
%}

binary [01]+

%%

{binary} {ECHO; printf("\n");}
.        {}

%%

int main(int argc,char **argv)
{
    int i;
    if(argc == 2)
        yyin=fopen(argv[1],"r");
    else
        yyin=stdin;
    yylex();
}
