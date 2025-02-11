 /* CS440 Proj 1 Fall 2024
      Name: Shevyn Buhary
      G#: G01284443  

      Language: Java

      Note:  
  */

import java.io.*; 

 /* addtional imports/ declarations here */
import java.util.HashMap;

%% 

%class p1_java 
%unicode
%line // to keep track of the line number
%{

static int keywordCount = 0, punctCount = 0, opCount = 0, commentCount = 0, numCount = 0, strCount = 0, idCount = 0;
static boolean def_flag = false; // for catching any special ids immediately following a keyword.
public static void main(String [] args) throws IOException 
{ 
  //read from standard input
  p1_java lexer = new p1_java(new InputStreamReader(System.in));
     
  //scan
  lexer.yylex();

  //print upon reaching the end of input   
  System.err.printf(formattedErrorString, keywordCount, punctCount, opCount, commentCount, numCount, strCount, idCount);
  
  if (id_msg.equals("Special IDs: "))
    System.out.print(id_msg + no_id_msg);
  else 

    System.out.print(id_msg + "\n");

} 

//formatting strings
static String token_err_msg = "Lexical Error: Line %d\n";
static String report_msg = "Token Summary:\n";
static String count_msg1 = "   Keywords: %d\n   Punctuations: %d\n";
static String count_msg2 = "   Operators: %d\n   Comments: %d\n";
static String count_msg3 = "   Numbers: %d\n   Strings: %d\n";
static String count_id_msg = "   IDs: %d\n";
static String id_msg = "Special IDs: ";
static String no_id_msg = "None.\n";

/* additional definitions here */
static String formattedErrorString = report_msg + count_msg1 + count_msg2 + count_msg3 + count_id_msg;

%} 

%type Object    //this line changes the return type of yylex into Object 
 /* lex comments: cannot start with the leftmost location of a line */
 /* add your regular definitions here */

letter           = [a-zA-Z] // upper and lower-case characters
digit            = [0-9] // digits
ws               = [ \t\n] // whitespace
keywords         = (def|fed|if|fi|else|while|elihw|print|input|true|false|return) // keywords
id               = ({letter}({letter}|{digit}|_)*) //ids excluding keywords specified
punctuation      = (\(|\)|:|,) // regex to match any punctuation token
longer_operators = (==|<=|>=|<>) // to match relational operators 
operators        = [=|/|\*|\+|\-|<|>] // to match assignment operators as well as < and >
integers         = -?(0|[1-9]{digit}*) // matches both positive and negative integers
strings          = \"([^\n\"\\]|\\.)*\" // matches any string in mython
comment          = (\!)([^\n]|\\.)* // matches any comment in mython that starts with !

%%

{keywords}                           { keywordCount++; if (yytext().contains("def")) { def_flag = true; } else { def_flag = false; } } // if keyword found
{punctuation}                        { punctCount++; def_flag = false; } // punctuation found
{operators}|{longer_operators}       { opCount++; def_flag = false;} // if any of the operators are found              
{id}                                 { idCount++; if (def_flag && !(id_msg.contains(yytext().trim()))) { id_msg += yytext().trim() + " "; def_flag = false; } } // if ids are found, including special ids
{integers}                           { numCount++; def_flag = false; } // if any integers both positive and negative are found
{strings}                            { strCount++; def_flag = false; } // inc string amount if string found
{comment}                            { commentCount++; def_flag = false; } // inc comment if comment found
{ws}                                 { } // do nothing when we hit a new line
.                    		     { System.err.printf(token_err_msg, yyline+1); System.exit(1); } // when an error is identified, execute this rule


	/* copy from input to output */
	/* compiled with --legacydot so that . matches [^\n] instead of
		[^\n\r\u000B\u000C\u0085\u2028\u2029] */
 
