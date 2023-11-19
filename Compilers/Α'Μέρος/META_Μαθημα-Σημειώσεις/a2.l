%option noyywrap

%{ 
    #include <stdio.h>
%}

binary [01]+

%%

{binary} {ECHO; printf("\n");}
.        {}

%%

    int main()
    {
        yylex();
    }
