%{
import java.io.*;
import java.util.*;

%}
 
%token DEF FED IF FI ELSE WHILE ELIHW PRINT INPUT RETURN EQ LTE GTE NOT_EQ STRING ID TRUE_TOKEN FALSE_TOKEN NUMBER

%%

program		: function_list end_list 
	 		;
function_list : function_list function
	      	  | {/*empty*/}
	          ;
function : DEF 
		   ID { 
				func_flag = true;
			    if (global_map.get($2.sval) != null) {
					//two functions can't have the same name
					System.err.printf(dupdef_err_msg, scanner.getLine()+1, $2.sval); 
					System.exit(1);
				} 
				else {
					global_map.put($2.sval, "FUNC");
					array_of_global_ids.add($2.sval); // array of global ids
				} 
			  } 
		   '('
		   parameters
		   ')' 
		   ':' 
		   statements 
		   FED {
					func_flag = false;
					if (!local_map.isEmpty()){
						System.out.printf(func_report, $2.sval);
						array_of_local_ids.forEach(key -> System.out.printf(id_report, key, local_map.get(key)));
						System.out.println();
						local_map.clear();
						array_of_local_ids.clear();
					} 
		       }
		 ;
parameters : parameters ',' ID {local_map.put($3.sval, "INT"); array_of_local_ids.add($3.sval);}
	       | ID {local_map.put($1.sval, "INT"); array_of_local_ids.add($1.sval);}
		   | {/*empty*/}
	       ;
statements : statements statement
	   	   | statement
	       ;
statement : assignment_stmt  
	      | print_stmt
	      | input_stmt
	      | condition_stmt
          | while_stmt
          | call_stmt
	      | return_stmt
	      ;
assignment_stmt : ID '=' expression {
										if (func_flag) {
											if ($3.sval instanceof String) {
												local_map.put($1.sval, "STRING");
											}
											else if (((Boolean)$3.obj) instanceof Boolean) {
												local_map.put($1.sval, "BOOL");
											}
											else {
												local_map.put($1.sval, "INT");
											}
											//add $1.sval to the array of local_ids iof it is ithe first time it si being added
											if (!array_of_local_ids.contains($1.sval)) array_of_local_ids.add($1.sval);
										} else if (global_map.get($1.sval) == "FUNC") { // if you find an id that has the same name as a function
											System.err.printf(dupdef_err_msg, scanner.getLine()+1, $1.sval); 
											System.exit(1);
										} else {
											if ($3.sval instanceof String) {
												global_map.put($1.sval, "STRING");
											}
											else if (((Boolean)$3.obj) instanceof Boolean) {
												global_map.put($1.sval, "BOOL");
											}
											else {
												global_map.put($1.sval, "INT");
											}
											//add $1.sval to the array of local_ids iof it is ithe first time it si being added
											if (!array_of_global_ids.contains($1.sval)) array_of_global_ids.add($1.sval);
										}
									}
		        ;
return_stmt : RETURN exp 

expression : rel_exp {
						if (((Boolean)$1.obj) instanceof Boolean)
							$$ = new p3_javaVal(new Boolean("false"));
					 }
	       | exp {
					if ($1.sval instanceof String)
						$$ = new p3_javaVal($1.sval);
					else if (((Boolean)$1.obj) instanceof Boolean)
						$$ = new p3_javaVal(new Boolean("false"));
					else $$ = new p3_javaVal($1.ival);
		         } 
	       ;
rel_exp : exp EQ exp {
						if (($1.sval instanceof String) && ($3.sval instanceof String)) 
							$$ = new p3_javaVal($1.sval == $3.sval); 
						else if ((((Boolean)$1.obj) instanceof Boolean) && (((Boolean)$3.obj) instanceof Boolean)) 
							$$ = new p3_javaVal(((Boolean)$1.obj) == ((Boolean)$3.obj)); 
						else $$ = new p3_javaVal($1.ival == $3.ival);
					 }/*boolean types*/
		| exp NOT_EQ exp {
							if (($1.sval instanceof String) && ($3.sval instanceof String)) 
								$$ = new p3_javaVal($1.sval != $3.sval); 
							else if ((((Boolean)$1.obj) instanceof Boolean) && (((Boolean)$3.obj) instanceof Boolean)) 
								$$ = new p3_javaVal(((Boolean)$1.obj) != ((Boolean)$3.obj)); 
							else $$ = new p3_javaVal($1.ival != $3.ival);
		                 }  /*boolean types*/
		| exp '<' exp {$$ = new p3_javaVal($1.ival < $3.ival);} /*boolean types*/
		| exp LTE exp {$$ = new p3_javaVal($1.ival <= $3.ival);} /*boolean types*/
		| exp '>' exp {$$ = new p3_javaVal($1.ival > $3.ival);} /*boolean types*/
		| exp GTE exp {$$ = new p3_javaVal($1.ival >= $3.ival);} /*boolean types*/
		| '(' rel_exp ')' {$$ = new p3_javaVal((Boolean)$2.obj);} /*boolean types*/
		;
exp : exp '+' term {if ($1.sval != null && $3.sval != null) $$ = new p3_javaVal($1.sval + $3.sval); else $$ = new p3_javaVal($1.ival + $3.ival);} 
    | exp '-' term {$$ = new p3_javaVal($1.ival - $3.ival);}
    | term {
				if ($1.sval instanceof String)
					$$ = new p3_javaVal($1.sval);
				else if (((Boolean)$1.obj) instanceof Boolean)
					$$ = new p3_javaVal(new Boolean("false"));
				else $$ = new p3_javaVal($1.ival);
	       }
    ;
term : term '*' factor {$$ = new p3_javaVal($1.ival * $3.ival);}
     | term '/' factor {if ($3.ival != 0) $$ = new p3_javaVal($1.ival / $3.ival);}
     | factor {
					if ($1.sval instanceof String) {
						$$ = new p3_javaVal($1.sval);
					}
					else if (((Boolean)$1.obj) instanceof Boolean) {
						$$ = new p3_javaVal(new Boolean("false"));
					}
					else $$ = new p3_javaVal($1.ival);

	          }
     ;
factor : '(' exp ')' {
							if ($2.sval instanceof String) 
								$$ = new p3_javaVal($2.sval);
							else if (((Boolean)$2.obj) instanceof Boolean)
								$$ = new p3_javaVal(new Boolean("true"));
							else $$ = new p3_javaVal($2.ival);
					 }
	   | NUMBER {$$ = new p3_javaVal($1.ival);}
	   | STRING {$$ = new p3_javaVal($1.sval);}
	   | ID {
			   if (func_flag && local_map.get($1.sval) == null) {
				   System.err.printf(undef_err_msg, scanner.getLine()+1, $1.sval); 
				   System.exit(1);
			   } 
			   else if (!func_flag && global_map.get($1.sval) == null) {
				   System.err.printf(undef_err_msg, scanner.getLine()+1, $1.sval); 
				   System.exit(1);
			   }
			   if (func_flag && local_map.get($1.sval) == "INT") $$ = new p3_javaVal($1.ival);
			   else if (func_flag && local_map.get($1.sval) == "BOOL") $$ = new p3_javaVal(new Boolean("false"));
			   else if (func_flag && local_map.get($1.sval) == "STRING") $$ = new p3_javaVal("");
			   else if (!func_flag && global_map.get($1.sval) == "INT") $$ = new p3_javaVal($1.ival);
			   else if (!func_flag && global_map.get($1.sval) == "BOOL") $$ = new p3_javaVal(new Boolean("false"));
			   else if (!func_flag && global_map.get($1.sval) == "STRING") $$ = new p3_javaVal("");
		    }
	   | TRUE_TOKEN {$$ = new p3_javaVal(new Boolean($1.sval));}
	   | FALSE_TOKEN {$$ = new p3_javaVal(new Boolean($1.sval));} 
	   | '-' factor {$$ = new p3_javaVal(-$2.ival);} 
	   | call_stmt {$$ = new p3_javaVal($1.ival);}
	   ;
print_stmt : PRINT '(' expression ')'
	   	   ;
input_stmt : ID '=' INPUT '(' ')' { 
										$$ = new p3_javaVal(1);
										if (func_flag) {
											local_map.put($1.sval, "INT");
											//add $1.sval to the array of local_ids iof it is ithe first time it si being added
											if (!array_of_local_ids.contains($1.sval)) array_of_local_ids.add($1.sval);
										} else if (global_map.get($1.sval) == "FUNC") { 
											System.err.printf(dupdef_err_msg, scanner.getLine()+1, $1.sval); 
											System.exit(1);
										} else {
											global_map.put($1.sval, "INT");
											//add $1.sval to the array of local_ids iof it is ithe first time it si being added
											if (!array_of_global_ids.contains($1.sval)) array_of_global_ids.add($1.sval);
										} 
								  }
	   	   ;
call_stmt : ID '(' ')' {
							if (!func_flag && global_map.get($1.sval) == null) {
								System.err.printf(undef_err_msg, scanner.getLine()+1, $1.sval); 
								System.exit(1);
							}
					   }
		  | ID '(' exp_list ')' {
									if (!func_flag && global_map.get($1.sval) == null) {
										System.err.printf(undef_err_msg, scanner.getLine()+1, $1.sval); 
										System.exit(1);
									}
								}
	      ;
condition_stmt : if_head statements FI
	           | if_head statements ELSE ':' statements FI
	           ;
if_head : IF expression ':'
	 	;
while_stmt : WHILE expression ':' statements ELIHW
	       ;
exp_list : exp_list ',' exp
	     | exp
	 	 ;
end_list : statements

%%
static String syn_err_msg = "Syntax Error: Line %d\n";
static String pass_msg = "Input Accepted\n";
static String undef_err_msg = 
        "Semantic Error: Line %d: ID %s not defined\n";
static String dupdef_err_msg = 
        "Semantic Error: Line %d: ID %s duplicate definition\n";

static String func_report = "IDs for function %s:\n";
static String global_report = "IDs for global:\n";
static String id_report = " %s: %s\n";

static HashMap<String, String> local_map; // storing local ids
static HashMap<String, String> global_map; // storing global ids
static ArrayList<String> array_of_global_ids; // the ids that it picks up in the global scope
static ArrayList<String> array_of_local_ids; // the ids that it picks up in the local scope
static boolean func_flag; // to determine if we are in a function

private lexer scanner; 
private int yylex() {
  int retVal = -1;

  try { 
     retVal = scanner.yylex(); 
  } catch (IOException e) { 
     System.err.println("IO Error:" + e); 
  } 
  return retVal; 
}

public void yyerror (String error) {
  System.err.format(syn_err_msg, scanner.getLine()+1); 
  System.exit(-1);
}

public p3_java (Reader r) { 
   scanner = new lexer (r, this); 
} 

public static void main (String [] args) throws IOException {
   p3_java yyparser = new p3_java(new InputStreamReader(System.in));
   //Init hash maps
   local_map = new HashMap<>();
   global_map = new HashMap<>();
   array_of_global_ids = new ArrayList<>();
   array_of_local_ids = new ArrayList<>();
   yyparser.yyparse();
   if (!global_map.isEmpty()){
		System.out.printf(global_report);
		array_of_global_ids.forEach(key -> System.out.printf(id_report, key, global_map.get(key)));
		System.out.println();
		global_map.clear();
		array_of_global_ids.clear();
	}
    System.err.printf(pass_msg);
}
