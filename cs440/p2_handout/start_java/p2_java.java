/* CS440 Proj 2 Fall 2024
      Name: Shevyn Buhary
      G#: G01284443  

      Language: Java

      Note:  
  */
import java.io.*;
import java.util.*; // for access to special data structures to store the ids

public class p2_java
{
    static int lookahead = 0; // to pick up lookahead symbols
    static lexer scanner = null; // lexer object to talk to the parser

    static String syntax_error_msg = "Syntax Error: Line %d\n";
    static String pass_msg = "Input Accepted\n";

    static String func_msg = "Function %s: Line %d\n";
    static String end_msg = "Global: Line %d\n";
    static String id_msg = " %s: Line %d\n";

    //init the HashMap
    static HashMap<String,Integer> map = new HashMap<String, Integer>(); // hashmap to pair ids with line numbers
    static ArrayList<String> id_log_table = new ArrayList<>(); // table of ids
    static boolean end_flag = false; // flag to know when your at the end list
    public static void main (String [] args) throws IOException
    {
    	scanner = new lexer(new InputStreamReader(System.in));
	    lookahead = scanner.yylex();
	    while (lookahead != 0){ //yylex() returns zero at EOF
	      //System.err.print(lookahead+" "); // for debugging
        program();
	      lookahead = scanner.yylex();
	    }
      //start logging at the end_list (global area as well)
      for (String key:id_log_table) {
        System.out.printf(id_msg, key, map.get(key));
      }
      System.err.print(pass_msg); // made to the end of the input so we accept the strin
      
    }

    public static void match(int symbol) {
      if (lookahead == symbol) {
        // if (symbol == scanner.ID && end_flag == true) {
        //   map.put(scanner.yytext(), scanner.getLineNumber()); // for adding ids at the end of the file
        // }
        try {
          lookahead = scanner.yylex();
        } catch (IOException e) {

        }
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void program() {
      function_list(); // if you dont see the def keyword then dont pursue this direction
      end_list(); // this will anyway continue to statements and it will try to to parse that
    }

    public static void function_list(){
      if (lookahead == scanner.DEF) {
        function_list_tail();
      }
      else {
        return; //accept even when there is no function
      }
    }

    public static void function_list_tail() {
      function();
      if (lookahead == scanner.DEF)
        function_list_tail();
      else 
        return;
    }

    public static void function() {
      match(scanner.DEF); // match def and move lookahead symbol forward
      System.out.printf(func_msg, scanner.yytext(), scanner.getLineNumber());
      match(scanner.ID); // match ID and move the lookahead forward
      match(scanner.OPEN_PAREN); // match the open parenthesis and move the lookahead forward.
      function_tail(); // call the function_tail to match the rest of the function
    }

    public static void function_tail() {
      if (lookahead == scanner.ID) {
        parameters(); //call if an ID is found
        match(scanner.CLOSING_PAREN);
        match(scanner.COLON);
        statements(); //function body
        match(scanner.FED);
        //printing all of the variable names and their occurrences
        for (String entry:id_log_table){
          System.out.printf(id_msg, entry, map.get(entry));
        }
        map.clear(); // clear the entries of the function id table
        id_log_table.clear();
        System.out.println();
      }
      else if (lookahead == scanner.CLOSING_PAREN) {
        match(scanner.CLOSING_PAREN); // match if a closing parenthesis is found
        match(scanner.COLON);
        statements(); // function body
        match(scanner.FED);
        //printing all of the variable names and their occurrences
        for (String entry:id_log_table){
          System.out.printf(id_msg, entry, map.get(entry));
        }
        map.clear(); // clear the entries of the function id table
        id_log_table.clear();
        System.out.println();
      }
      else {
        return;
      }
    }

    public static void parameters() {
      String token = scanner.yytext();
      map.put(token, scanner.getLineNumber());
      id_log_table.add(token);
      match(scanner.ID);
      parameters_tail();
    }

    public static void parameters_tail() {
      if (lookahead == scanner.COMMA) {
        match(scanner.COMMA);
        String token = scanner.yytext();
        map.put(token, scanner.getLineNumber());
        id_log_table.add(token);
        match(scanner.ID);
        parameters_tail();
      }
      else {
        return;
      }
    }

    //end list will start matching tokens that it comes across in case there is no function to match
    public static void statements() {
      if (lookahead == scanner.ID || lookahead == scanner.RETURN || lookahead == scanner.PRINT) {
        statements_tail(); // try to match any other statements
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void statements_tail() {
      statement();
      if (lookahead == scanner.ID || lookahead == scanner.RETURN || lookahead == scanner.PRINT) {
        statements_tail();
      }
      else {
        return; // single statement is acceptable
      }
    }

    public static void statement() {
      if (lookahead == scanner.ID) {
        String token = scanner.yytext();
        if (!end_flag && map.get(token) != null) {
          map.replace(token, scanner.getLineNumber());//add the id to the hashmap
        }
        else if (!end_flag && map.get(token) == null){
          map.put(token, scanner.getLineNumber());
          id_log_table.add(token);
        }
        if (end_flag && map.get(token) != null) {
          map.replace(token, scanner.getLineNumber());//add the id to the hashmap
        }
        else if (end_flag && map.get(token) == null){
          map.put(token, scanner.getLineNumber());
          id_log_table.add(token);
        }
        match(scanner.ID);
        statement_tail();
      }
      else if (lookahead == scanner.RETURN) {
        match(scanner.RETURN);
        exp();
      }
      else if (lookahead == scanner.PRINT) {
        match(scanner.PRINT);
        match(scanner.OPEN_PAREN);
        exp();
        match(scanner.CLOSING_PAREN);
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void statement_tail() {
      if (lookahead == scanner.ASSIGN) {
        match(scanner.ASSIGN);
        statement_assign();
      }
      else if (lookahead == scanner.OPEN_PAREN) {
        match(scanner.OPEN_PAREN);
        statement_open_paren();
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void statement_assign() {
      if (lookahead == scanner.INPUT) {
        match(scanner.INPUT);
        match(scanner.OPEN_PAREN);
        match(scanner.CLOSING_PAREN);
      }
      else {
        exp();
      }
    }

    public static void statement_open_paren() {
      if (lookahead == scanner.OPEN_PAREN || lookahead == scanner.SUBTRACT || lookahead == scanner.INT || lookahead == scanner.STRING || lookahead == scanner.ID) {
        exp_list();
        match(scanner.CLOSING_PAREN);
      }
      else if (lookahead == scanner.CLOSING_PAREN) {
        match(scanner.CLOSING_PAREN);
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void exp() {
      term();
      exp_tail(); 
    }

    public static void exp_tail() {
      if (lookahead == scanner.ADD) {
        match(scanner.ADD);
        term();
        exp_tail();
      }
      else if (lookahead == scanner.SUBTRACT) {
        match(scanner.SUBTRACT);
        term();
        exp_tail();
      }
      else {
        return;
      }
    }

    public static void term() {
      factor();
      term_tail();
    }

    public static void term_tail() {
      if (lookahead == scanner.MULTIPLY) {
        match(scanner.MULTIPLY);
        factor();
        term_tail();
      }
      else if (lookahead == scanner.DIVIDE) {
        match(scanner.DIVIDE);
        factor();
        term_tail();
      }
      else {
        return;
      }
    }

    public static void factor() {
      if (lookahead == scanner.OPEN_PAREN) {
        match(scanner.OPEN_PAREN);
        exp(); // try_to_match(exp)
        match(scanner.CLOSING_PAREN);
      }
      else if (lookahead == scanner.SUBTRACT) {
        match(scanner.SUBTRACT);
        factor();
      }
      else if (lookahead == scanner.INT) {
        match(scanner.INT);
      }
      else if (lookahead == scanner.STRING) {
        match(scanner.STRING);
      }
      else if (lookahead == scanner.ID) {
        //map.put(scanner.yytext(), scanner.getLineNumber());
        String token = scanner.yytext();
        if (!end_flag && map.get(token) != null) {
          map.replace(token, scanner.getLineNumber());//add the id to the hashmap
        }
        else if (!end_flag && map.get(token) == null){
          map.put(token, scanner.getLineNumber());
          id_log_table.add(token);
        }
        if (end_flag && map.get(token) != null) {
          map.replace(token, scanner.getLineNumber());//add the id to the hashmap
        }
        else if (end_flag && map.get(token) == null){
          map.put(token, scanner.getLineNumber());
          id_log_table.add(token);
        }
        match(scanner.ID);
        factor_tail();
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void factor_tail() {
      if (lookahead == scanner.OPEN_PAREN) {
        match(scanner.OPEN_PAREN);
        factor_open_paren();
      }
      else {
        return; // accept if you have a standalone ID as well
      }
    }

    public static void factor_open_paren() {
      if (lookahead == scanner.CLOSING_PAREN) {
        match(scanner.CLOSING_PAREN);
      }
      else if (lookahead == scanner.OPEN_PAREN || lookahead == scanner.SUBTRACT || lookahead == scanner.INT || lookahead == scanner.STRING || lookahead == scanner.ID) {
        exp_list();
        match(scanner.CLOSING_PAREN);
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void exp_list() {
      if (lookahead == scanner.OPEN_PAREN || lookahead == scanner.SUBTRACT || lookahead == scanner.INT || lookahead == scanner.STRING || lookahead == scanner.ID) { 
        exp();
        exp_list_tail();
      }
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }

    public static void exp_list_tail() {
      if (lookahead == scanner.COMMA) {
        match(scanner.COMMA);
        exp();
        exp_list_tail();
      }
      else {
        return;
      }
    }

    public static void end_list() {
      System.out.printf(end_msg, scanner.getLineNumber());
      end_flag = true;
      if (lookahead == scanner.ID || lookahead == scanner.PRINT)
        statements();
      else {
        System.err.printf(syntax_error_msg, scanner.getLineNumber());
        System.exit(1);
      }
    }
}
