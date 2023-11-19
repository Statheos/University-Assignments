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
  FILE *myfile=fopen("input.txt", "r");
  if (!myfile)
    {
        printf("I can't open input.txt");
        return -1;
    }
  yyin=myfile;
  yylex();
}
