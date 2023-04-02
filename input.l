%{
#include <stdio.h>
int count = 1;
int numcount = 1;
%}

BINARY [01]
op-not not
op-or or
op-and and
op-xor xor
op-mul \*
op-div \/
op-sum \+
op-menos \-
par-a \(
par-c \)
space [ \t]+
%%
{BINARY}+  {printf("num%d: %s\n", numcount,yytext); numcount++;};
{op-not}  printf("opt-not: %s\n", yytext);
{op-or}   printf("opt-or: %s\n", yytext);
{op-and}  printf("opt-and: %s\n", yytext);
{op-xor}  printf("opt-xor: %s\n", yytext);
{op-sum}  printf("opt-sum: %s\n", yytext);
{op-mul}  printf("opt-mul: %s\n", yytext);
{op-div}  printf("opt-div: %s\n", yytext);
{op-menos}  printf("opt-menos: %s\n", yytext);
{par-a}   printf("par-a: %s\n", yytext);
{par-c}   printf("par-c: %s\n", yytext);
{space}   ;
[01]*[2-9a-zA-Z][0-9a-zA-Z]*|[01]*[0-9]*[2-9a-zA-Z][0-9a-zA-Z]* {printf("ERROR Léxico\n");};
\n {count++;printf("---Line %d---\n", count); numcount = 1;}
. printf("ERROR Léxico\n");
%%

#define MAX_LINE_LENGTH 1024


int yywrap(){}
int main(int argc, char *argv[]) {
    if(argc == 2){
        FILE *fp;
        char line[MAX_LINE_LENGTH];

        // open the file for reading
        fp = fopen(argv[1], "r");

        // check if file exists and can be opened
        if (fp == NULL) {
            printf("Unable to open file\n");
            return 1;
        }

        yyin = fp;
        printf("Componentes Léxicos:\n");
        yylex();
        // close the file
        fclose(fp);
    } else {
        printf("Only pass one parameter");
    }
    return 0;
}
