	#include <string.h>
	int abc = 0;
	char str[10]="";
	char methodName[20]="";
	char className[20]="";
	int cnt = 0;
	int Caller;
%x ClassName MethodSign MethodName Examples Input Output String Tuple Spaces OTuple OString OSpaces
%%
Class:\n BEGIN(ClassName);
Method\ signature:\n BEGIN(MethodSign);
Method:\n BEGIN(MethodName);
Examples\n BEGIN(Examples);
. ;
\n ;

<ClassName>.* printf("class %s:\n",yytext);strcpy(className,yytext);
<ClassName>\n BEGIN(INITIAL);
<MethodSign>.* printf("\t%s\n\t\tprint \n\n\ndef equate(arg1, arg2):\n\tif arg1 == arg2:\n\t\tprint \"Test Passed.\"\n\telse:\n\t\tprint \"Test Failed.\\nGot:\",arg1,\"\\nNeed:\",arg2\n\ntemp = %s()\n",yytext,className);
<MethodSign>\n BEGIN(INITIAL);

<MethodName>.* strcpy(methodName,yytext);
<MethodName>\n BEGIN(INITIAL);

<Examples>[0-9]\)\n\n printf("equate( temp.%s(",methodName);BEGIN(Spaces);
<Examples>\n ;
<Examples>. ;

<Spaces>\t ;
<Spaces>[    ] ;
<Spaces>[\n] ;
<Spaces>. yyless(0);BEGIN(Input);

<Input>\{ printf("(");cnt++;BEGIN(Tuple);
<Input>\n printf(", ");
<Input>\nReturns: printf("),");BEGIN(OSpaces);

<Tuple>\" printf("\"");BEGIN(String);
<Tuple>\{ printf("(");cnt++;
<Tuple>\} printf(")");cnt--;if(cnt == 0)BEGIN(Input);
<Tuple>\n ;

<String>\" printf("\"");BEGIN(Tuple);

<Output>\{ printf("(");BEGIN(OTuple);
<Output>\n printf(")\n");BEGIN(Examples);

<OSpaces>\t ;
<OSpaces>[    ] ;
<OSpaces>[ ] ;
<OSpaces>[\n] ;
<OSpaces>. yyless(0);BEGIN(Output);

<OTuple>\" printf("\"");BEGIN(OString);
<OTuple>\} printf(")");BEGIN(Output);
<OTuple>\n ;

<OString>\" printf("\"");BEGIN(OTuple);

%%
int main()
{
	yylex();
	return 0;
}
