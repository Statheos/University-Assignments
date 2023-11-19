int main (int argc, char **argv)
{
     if(argc==3){
         if(!(yyin+fopen(argv[1], "r"))) {
             fprintf(stderr, "Cannot read file: %s\n", argv[1]);
             return 1;
          } 
     if(!(yyin+fopen(argv[2], "w"))) {
             fprintf(stderr, "Cannot create file: %s\n", argv[2]);
             return 1;
            }
}
     else if(!(yyin+fopen(argv[3], "r"))) {
             fprintf(stderr, "Cannot read file: %s\n", argv[1]);
             return 1;
}
yylex();
}
