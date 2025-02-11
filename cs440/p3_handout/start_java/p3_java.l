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

static String lex_err_msg = "Lexical Error: line %d\n";

private p3_java yyparser;
public lexer (java.io.Reader r, p3_java yyparser) {
    this (r); 
    this.yyparser = yyparser; 
} 

public int getLine() { return yyline; }
 /* additional definitions here */
static String yylval;
%} 

%type int
 
 /* lex comments: cannot start with the leftmost location of a line */
 /* add your regular definitions here */
letter           = [a-zA-Z] // upper and lower-case characters
digit            = [0-9] // digits
ws               = [ \t\n] // whitespace
identifiers      = ({letter}({letter}|{digit}|_)*) //ids excluding keywords specified
integers         = (0|[1-9]{digit}*) // matches both positive and negative integers
strings          = \"([^\n\"\\]|\\.)*\" // matches any string in mython
comment          = (\!)([^\n]|\\.)* // matches any comment in mython that starts with !
%%
 /* keywords */
def   				    { return(p3_java.DEF); }      /* keyword def */
fed				    	{ return(p3_java.FED); }      /* keyword fed */
if				    	{ return(p3_java.IF); }       /* keyword if */
fi				    	{ return(p3_java.FI); }       /* keyword fi */
else			        { return(p3_java.ELSE); }
while				    { return(p3_java.WHILE); }    /* keyword while */
elihw				    { return(p3_java.ELIHW); }	  /* keyword elihw */
print				    { return(p3_java.PRINT); }    /* keyword print */
input				    { return(p3_java.INPUT); }    /* keyword input */
true				    { yyparser.yylval = new p3_javaVal(yytext()); return(p3_java.TRUE_TOKEN); }     /* keyword true */
false				    { yyparser.yylval = new p3_javaVal(yytext()); return(p3_java.FALSE_TOKEN); }    /* keyword false */
return				    { return(p3_java.RETURN); }   /* keyword return */

 /* operators */
\=				    { return (int) yycharat(0); } /* assignment operator */
\+				    { return (int) yycharat(0); } /* addition operator */
\-		            { return (int) yycharat(0); } /* subtract operator */
\*				    { return (int) yycharat(0); } /* multiplication operator */
\/				    { return (int) yycharat(0); } /* division operator */
\>				    { return (int) yycharat(0); } /* greater than operator */
\<				    { return (int) yycharat(0); } /* less than operator*/
(==)				{ return(p3_java.EQ); } /* equals operator */
(<=)				{ return(p3_java.LTE); } /* lesser/equal */
(>=)				{ return(p3_java.GTE); } /* greater/equal */
(<>)	            { return(p3_java.NOT_EQ); } /* not equal */

 /* punctuations */
\(			        { return (int) yycharat(0); } /* opening paren */
\)				    { return (int) yycharat(0); } /* closing paren */
\:		    	    { return (int) yycharat(0); } /* colon */
\,				    { return (int) yycharat(0); } /* comma */

 /* other tokens */
{identifiers}           { yyparser.yylval = new p3_javaVal(yytext()); return(p3_java.ID); } /* id */
{integers}              { yyparser.yylval = new p3_javaVal(Integer.parseInt(yytext())); return(p3_java.NUMBER); } /* integers */
{strings}               { yyparser.yylval = new p3_javaVal(yytext()); return(p3_java.STRING); } /* strings */
{comment}               { } /* do nothing for comment sighting */

 /* white spaces and other */
 {ws}                   { } /* do nothing when we hit a whitespace */
 .						{ System.err.printf(lex_err_msg, yyline+1); System.exit(1); }

 
	/* copy from input to output */
	/* compiled with --legacydot so that . matches [^\n] instead of
		[^\n\r\u000B\u000C\u0085\u2028\u2029] */