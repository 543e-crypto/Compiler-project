/* CS440 Proj 2 Fall 2024
      Name: Shevyn Buhary
      G#: G01284443  

      Language: Java

      Note:  
  */


import java.io.*; 

 /* lex comments: cannot start with the leftmost location of a line */
 /* addtional imports/ declarations here */

%% 

%class lexer
%unicode
%line

%eofval{
	return 0; //returns zero for EOF
%eofval}

%{ 

static String lexical_err_msg = "Lexical Error: Line %d\n";

/* Self-defined tokens */
static final int DEF=1;  
static final int FED=2;  
static final int IF=3;  
static final int FI=4;
static final int WHILE=5;
static final int ELIHW=6;
static final int PRINT=7;  
static final int INPUT=8;  
static final int TRUE=9;  
static final int FALSE=10;
static final int RETURN=11;  
static final int STRING=12;
static final int COMMENT=13;
static final int INT=14;
static final int ID=15;
static final int PUNCT=16;  
static final int OPEN_PAREN=17;
static final int CLOSING_PAREN=18;
static final int COLON=19;
static final int COMMA=20;
static final int ASSIGN=21;
static final int ADD=22;
static final int SUBTRACT=23;
static final int DIVIDE=24;
static final int MULTIPLY=25;
static final int EQ=26;
static final int GT=27;
static final int LT=28;
static final int GTE=29;
static final int LTE=30;
static final int NOT_EQ=31;


/* additional definitions here */
static boolean def_flag = false;
//this fi
public int getLineNumber() {
	return yyline + 1;
}
%} 

%type int
 
 /* lex comments: cannot start with the leftmost location of a line */
 /* add your regular definitions here */

letter           = [a-zA-Z] // upper and lower-case characters
digit            = [0-9] // digits
ws               = [ \t\n] // whitespace
identifiers      = ({letter}({letter}|{digit}|_)*) //ids excluding keywords specified
integers         = -?(0|[1-9]{digit}*) // matches both positive and negative integers
strings          = \"([^\n\"\\]|\\.)*\" // matches any string in mython
comment          = (\!)([^\n]|\\.)* // matches any comment in mython that starts with !
%% 
def   				    { return(DEF); }      /* keyword def */
fed				        { return(FED); }      /* keyword fed */
if				        { return(IF); }       /* keyword if */
fi				        { return(FI); }       /* keyword fi */
while				      { return(WHILE); }    /* keyword while */
elihw				      { return(ELIHW); }	   /* keyword elihw */
print				      { return(PRINT); }    /* keyword print */
input				      { return(INPUT); }    /* keyword input */
true				      { return(TRUE); }     /* keyword true */
false				      { return(FALSE); }    /* keyword false */
return				    { return(RETURN); }   /* keyword return */
\(			          { return(OPEN_PAREN); } /* opening paren */
\)						    { return(CLOSING_PAREN); } /* closing paren */
\:		    			  { return(COLON); } /* colon */
\,						    { return(COMMA); } /* comma */
=						      { return(ASSIGN); } /* assignment operator */
\+						    { return(ADD); } /* addition operator */
\-						    { return(SUBTRACT); } /* subtract operator */
\*						    { return(MULTIPLY); } /* multiplication operator */
\/						    { return(DIVIDE); } /* division operator */
\>						    { return(GT); } /* greater than operator */
\<						    { return(LT); } /* less than operator*/
\=\=					    { return(EQ); } /* equals operator */
\<\=					    { return(LTE); } /* lesser/equal */
\>\=					    { return(GTE); } /* greater/equal */
\<\>	        		{ return(NOT_EQ); } /* not equal */
{identifiers}     { return(ID); } /* id */
{integers}        { return(INT); } /* integers */
{strings}         { return(STRING); } /* strings */
{comment}         { /*return(COMMENT);*/ } /* comments */
{ws}              { } /* do nothing when we hit a whitespace */
.  						    { System.err.printf("Lexical Error: Line %d", yyline+1); System.exit(1); } /* default: need to change/remove */

	/* copy from input to output */
	/* compiled with --legacydot so that . matches [^\n] instead of
		[^\n\r\u000B\u000C\u0085\u2028\u2029] */

