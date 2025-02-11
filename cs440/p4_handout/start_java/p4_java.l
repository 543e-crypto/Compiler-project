import java.io.*; 

 /* lex comments: cannot start with the leftmost location of a line */
 /* addtional imports/ declarations here */

%% 

%class lexer
%unicode 
%byaccj
%line

%eofval{
	return 0; //returns zero for EOF
%eofval}

%{ 

static String token_err_msg = "Line %d: lexical error\n";

private p4_java yyparser;
public lexer (java.io.Reader r, p4_java yyparser) {
    this (r); 
    this.yyparser = yyparser; 
} 

public int getLine() { return yyline; }
 /* additional definitions here */

%} 

%type int
 
 /* lex comments: cannot start with the leftmost location of a line */
 /* add your regular definitions here */

 /* regular definitions */
space = [ \t]
number = 0|[1-9][0-9]*
id = [a-zA-Z_][a-zA-Z_0-9]*
string = \"(\\\"|[^\"\n])*\"
comment = \![^\n]*

%%
 /* keywords */
def 	{ return(p4_java.DEF); }
fed 	{ return(p4_java.ENDDEF); }
if 	{ return(p4_java.IF); }
fi 	{ return(p4_java.ENDIF); }
else 	{ return(p4_java.ELSE); }
while 	{ return(p4_java.WHILE); }
elihw { return(p4_java.ENDWHILE); }
print 	{ return(p4_java.PRINT); }
input 	{ return(p4_java.INPUT); }
true 	{ return(p4_java.TRUE); }
false 	{ return(p4_java.FALSE); }
return 	{ return(p4_java.RETURN); }

 /* operators */
\+ 	{ return(p4_java.ADD); }
-	{ return(p4_java.MINUS); }
\* 	{ return(p4_java.MUL); }
\/ 	{ return(p4_java.DIV); }
== 	{ return(p4_java.EQ); }
\< 	{ return(p4_java.LT); }
\<= 	{ return(p4_java.LE); }
\> 	{ return(p4_java.GT); }
\>= 	{ return(p4_java.GE); }
= 	{ return(p4_java.ASSIGN); }
\<\> 	{ return(p4_java.NE); }

 /* punctuations */
\( 	{ return(p4_java.LP); }
\) 	{ return(p4_java.RP); }
: 	{ return(p4_java.COLON); }
, 	{ return(p4_java.COMMA); }

{id}	{ yyparser.yylval = new p4_javaVal(yytext()); return(p4_java.ID); }

{number} { yyparser.yylval = new p4_javaVal(Integer.parseInt(yytext())); return(p4_java.NUMBER); } 
{string} { yyparser.yylval = new p4_javaVal(yytext()); return(p4_java.STRING); }
{comment} { //return(p4_java.COMMENT); 
		;
	}
{space}|\n 	{ ; }
.	{ System.out.format(token_err_msg, yyline+1);
    System.exit(-1);
	}
	/* compiled with --legacydot so that . matches [^\n] instead of
		[^\n\r\u000B\u000C\u0085\u2028\u2029] */
 
