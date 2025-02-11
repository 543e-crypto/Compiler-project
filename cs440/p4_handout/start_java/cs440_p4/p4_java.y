%{
import java.io.*;
import java.util.*;
import java.lang.Boolean;

%}
 
%token ADD MINUS MUL DIV EQ LT LE GT GE ASSIGN NE
%token DEF ENDDEF IF ENDIF ELSE WHILE ENDWHILE PRINT INPUT TRUE FALSE RETURN
%token LP RP COLON COMMA
%token ID NUMBER STRING COMMENT

%%

program		: { //generate IO set up lines
            }
            function_list end_list
			; /*void type*/ 

function_list 	: function_list function 
		| /* empty */
		; /*void type*/

function	: DEF 
			  ID {
					func_flag = true; 
			  		func_name = $2.sval; 
					System.out.println(func_name + ":"); 
					prologue();
				 } 
			  LP
			  parameters {addFunc = 1;}
			  RP
			  COLON
			  statements { 
							System.out.println("\tjmp " + func_name + "_exit\n" + func_name + "_exit:");
							epilogue();
						 }
			  ENDDEF {
						local_id_list.clear(); 
						local_map.clear();
						while (!used_registers.empty()) {
							freeRegister(used_registers.pop());
						} 
						func_flag = false;
					 }
			; /*void type*/

parameters	: parameters COMMA ID {
										if (!local_id_list.contains(func_name + "_" + $3.sval)) {
											System.out.println(".data\n\t" + func_name + "_" + $3.sval + ": .long 0");
											local_id_list.add(func_name + "_" + $3.sval);
											addFuncParameter(func_name + "_" + $3.sval);
										}
										addFunc++;
								  } // no registers needed here
		| ID {
				if (!local_id_list.contains(func_name + "_" + $1.sval)) {
					System.out.println(".data\n\t" + func_name + "_" + $1.sval + ": .long 0");
					local_id_list.add(func_name + "_" + $1.sval);
					addFuncParameter(func_name + "_" + $1.sval);
				}
				addFunc++;
			 } // no registers no needed here 
		| /*empty*/
		; /*void type*/

statements	: statements statement 
		| statement
		; /*void type*/

statement	: assignment_stmt
		| print_stmt
		| input_stmt 
		| condition_stmt
		| while_stmt
		| call_stmt {
						addCall = 1; 
						post_call();
						while (!used_registers.empty()) {
							freeRegister(used_registers.pop());
						}
					}
		| return_stmt
		; /*void type*/

assignment_stmt	: ID ASSIGN expression {
											if (!func_flag && !global_id_list.contains($1.sval)) {
												System.out.println(".data\n\tglobal_" + $1.sval + ": .long 0");
												global_id_list.add($1.sval);
											}
											//System.err.println(func_flag);
											if (func_flag && !local_id_list.contains(func_name + "_" + $1.sval)){
												System.out.println(".data\n\t" + func_name + "_" + $1.sval + ": .long 0");
												local_id_list.add(func_name + "_" + $1.sval);
											}
											String register1 = null;
											if (!used_registers.empty()) {
												register1 = used_registers.pop();
												if (!func_flag) {
													System.out.println(".text\n\tmovl " + register1 + ", global_" + $1.sval + "(%rip)");
													global_map.put($1.sval, register1);
												}
												else {
													System.out.println(".text\n\tmovl " + register1 + ", " + func_name + "_" + $1.sval + "(%rip)");
													local_map.put((func_name + "_" + $1.sval), register1);
												}
												freeRegister(register1);
											}
									   }
				;

return_stmt	: RETURN exp {
							return_count++;
							String reg = used_registers.pop();
							System.out.println("\tmovl " + reg + ", %eax");
							freeRegister(reg);
						 } // once you havce returned free the register
			; /*void type*/

expression	: rel_exp
		| exp 
			;

rel_exp		: exp EQ exp {
							$$.obj = new p4_javaVal($1.ival == $3.ival);
							
							if (if_flag) {
								String reg1 = null;
								String reg2 = null;
								if (!used_registers.empty() && used_registers.size() > 1) {
									reg1 = used_registers.pop();
									reg2 = used_registers.pop();
									System.out.println("\tcmpl " + reg1 + ", " + reg2);
									System.out.println("\tsete %al");
									System.out.println("\tmovzbl %al, %eax");
									freeRegister(reg1);
									freeRegister(reg2);
								}
							}
							else {
								String reg1 = null;
								String reg2 = null;
								if (!used_registers.empty() && used_registers.size() > 1) {
									reg1 = used_registers.pop();
									reg2 = used_registers.pop();
									System.out.println("\tcmpl " + reg1 + ", " + reg2);
									System.out.println("\tsete " + reg2.substring(0,4) + "b");
									System.out.println("\tmovzbl " + reg2.substring(0,4) + "b" + ", " + reg2);
									used_registers.push(reg2);
									freeRegister(reg1);
								}
							}
						 } 
		| exp NE exp {
						$$.obj = new p4_javaVal($1.ival != $3.ival);
						if (if_flag) {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetne %al");
								System.out.println("\tmovzbl %al, %eax");
								freeRegister(reg1);
								freeRegister(reg2);
							}
						}
						else {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetne " + reg2.substring(0,4) + "b");
								System.out.println("\tmovzbl " + reg2.substring(0,4) + "b" + ", " + reg2);
								used_registers.push(reg2);
								freeRegister(reg1);
							}
						}
					 } 
		| exp LT exp {
						$$.obj = new p4_javaVal($1.ival < $3.ival);
						if (if_flag) {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetl %al");
								System.out.println("\tmovzbl %al, %eax");
								freeRegister(reg1);
								freeRegister(reg2);
							}
						}
						else {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetl " + reg2.substring(0,4) + "b");
								System.out.println("\tmovzbl " + reg2.substring(0,4) + "b" + ", " + reg2);
								used_registers.push(reg2);
								freeRegister(reg1);
							}
						}
					 }
		| exp LE exp {
						$$.obj = new p4_javaVal($1.ival <= $3.ival);
						if (if_flag) {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetle %al");
								System.out.println("\tmovzbl %al, %eax");
								freeRegister(reg1);
								freeRegister(reg2);
							}
						}
						else {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetle " + reg2.substring(0,4) + "b");
								System.out.println("\tmovzbl " + reg2.substring(0,4) + "b" + ", " + reg2);
								used_registers.push(reg2);
								freeRegister(reg1);
							}
						}
					 }
		| exp GT exp {
						$$.obj = new p4_javaVal($1.ival > $3.ival);
						if (if_flag) {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetg %al");
								System.out.println("\tmovzbl %al, %eax");
								freeRegister(reg1);
								freeRegister(reg2);
							}
						}
						else {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetg " + reg2.substring(0,4) + "b");
								System.out.println("\tmovzbl " + reg2.substring(0,4) + "b" + ", " + reg2);
								used_registers.push(reg2);
								freeRegister(reg1);
							}
						}
					 } 
		| exp GE exp {
						$$.obj = new p4_javaVal($1.ival >= $3.ival);
						if (if_flag) {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetge %al");
								System.out.println("\tmovzbl %al, %eax");
								freeRegister(reg1);
								freeRegister(reg2);
							}
						}
						else {
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tcmpl " + reg1 + ", " + reg2);
								System.out.println("\tsetge " + reg2.substring(0,4) + "b");
								System.out.println("\tmovzbl " + reg2.substring(0,4) + "b" + ", " + reg2);
								used_registers.push(reg2);
								freeRegister(reg1);
							}
						}
					 } 
		| LP rel_exp RP
		;

exp		: exp ADD term {
							
							$$.ival = $1.ival + $3.ival;
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\taddl " + reg1 + ", " + reg2);
								used_registers.push(reg2);
								freeRegister(reg1);
							}
					   } 
		| exp MINUS term {
							$$.ival = $1.ival - $3.ival;
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tsubl " + reg1 + ", " + reg2);
								used_registers.push(reg2);
								freeRegister(reg1);
							}
						 } 
		| term
		;

term		: term MUL factor {
									
								$$.ival = $1.ival * $3.ival;
								String reg1 = null;
								String reg2 = null;
								if (!used_registers.empty() && used_registers.size() > 1) {
									reg1 = used_registers.pop();
									reg2 = used_registers.pop();
									System.out.println("\timull " + reg1 + ", " + reg2);
									used_registers.push(reg2);
									freeRegister(reg1);
								}
							  } 
		| term DIV factor {
							//div_flag = true;
							if ($3.ival != 0)
								$$.ival = $1.ival / $3.ival;
							
							String reg1 = null;
							String reg2 = null;
							if (!used_registers.empty() && used_registers.size() > 1) {
								reg1 = used_registers.pop();
								reg2 = used_registers.pop();
								System.out.println("\tmovl " + reg2 + ", %eax");
								System.out.println("\tcdq");
								System.out.println("\tmovl " + reg1 + ", %ebx");
								System.out.println("\tidivl %ebx");
								used_registers.push(reg1);
								freeRegister(reg2);
								System.out.println("\tmovl %eax, " + reg1);
							}
						  }
		| factor
		;

factor		: LP exp RP 
		| NUMBER {
					$$.ival = $1.ival;
					//find an available register to use and put in the used array
					String register = getRegister();
					//put value in the available register.
					System.out.println("\tmovl $" + $1.ival + ", " + register);
					used_registers.push(register);
					//System.err.println(used_registers.toString());
				 }
		| STRING {
					$$.sval = $1.sval;
					//find an available register to use and put in the used array
					String register = getRegister();
					// put value in the register.
					System.out.println("\t.section .rodata\n\tstr" + string_count + ":\t.string " + $1.sval);
					System.out.println("\t.text");
					System.out.println("\tmovq $str" + string_count + ", " + register.substring(0,4));
					string_count++; // increment the string count to generate a new string id
					used_registers.push(register.substring(0,4)); // put the rtegistr name in the list of used registers
				 }
		| ID {
				$$.sval = $1.sval;
				if (!func_flag) { //global scope
					String register1 = getRegister();
					if (register1 != null) {
						used_registers.push(register1);
					}
					System.out.println("\tmovl global_" + $1.sval + "(%rip), " + register1); //move the value into the free register
				}
				else { 
					String register1 = getRegister();
					if (register1 != null) {
						used_registers.push(register1);
					}
					System.out.println("\tmovl " + func_name + "_" + $1.sval + "(%rip), " + register1); //move the value into the free register	
					local_map.put((func_name + "_" + $1.sval), register1);
				}
			 } 
		| TRUE {
					$$.obj = new p4_javaVal(true);
					//find an available register to use and put in the used array
					String register = getRegister();
					//put value in the available register.
					System.out.println("\tmovl $1, " + register);
					used_registers.push(register); // put the rtegistr name in the list of used registers
			   }
		| FALSE {
					$$.obj = new p4_javaVal(false);
					//find an available register to use and put in the used array
					String register = getRegister();
					//put value in the available register.
					System.out.println("\tmovl $0, " + register);
					used_registers.push(register); // put the rtegistr name in the list of used registers
				}  
		| MINUS factor {
							$$.ival = -$2.ival; 
							System.out.println("\tnegl " + used_registers.peek());
					   } 
		| call_stmt {
						addCallF++;
						post_call();
						addCallParameter(used_registers.pop(), addCallF - 1);
						/*
						while (!used_registers.empty()) {
							freeRegister(used_registers.pop());
						}*/
					}
		;

print_stmt	: PRINT LP expression RP {
										//System.out.println(".text");
										String register1 = null;
										//System.err.println(used_registers.toString());
										if (!used_registers.empty()) {
											register1 = used_registers.pop();
										}
										else {
											register1 = getRegister();
											used_registers.push(register1);
											used_registers.pop();
										}

										if (func_flag) {
											pre_call();
										}

										if (($3.sval != null) && (($3.sval).contains("\""))) { // regular string
											System.out.println("\tmovq $LPRINT1, %rdi");
											System.out.println("\tmovq " + register1.substring(0,4) + ", %rsi");
											System.out.println("\txorl %eax, %eax");
											System.out.println("\tcall printf");
										}
										else {
											System.out.println("\tmovq $LPRINT0, %rdi");
											System.out.println("\tmovl " + register1 + ", %esi");
											System.out.println("\txorl %eax, %eax");
											System.out.println("\tcall printf");
										}

										freeRegister(register1);

										if (func_flag) {
											post_call();
										}		
									 }/*void type*/
			;

input_stmt	: ID ASSIGN INPUT LP RP {
										if (!func_flag && !global_id_list.contains($1.sval)) {
											System.out.println(".data\n\tglobal_" + $1.sval + ": .long 0");
											global_id_list.add($1.sval);
										}
										else if (func_flag && !local_id_list.contains($1.sval)){
											System.out.println(".data\n\t" + func_name + "_" + $1.sval + ": .long 0");
											local_id_list.add($1.sval);
										}
										input_flag = true;
										System.out.println(".text");
										System.out.println("\tmovq $LGETINT, %rdi");
										if (!func_flag) {
											System.out.println("\tmovq $global_" + $1.sval + ", %rsi");
										}
										else {
											System.out.println("\tmovq $" + func_name + "_" + $1.sval + ", %rsi");
										}
										System.out.println("\txorl %eax, %eax");
										System.out.println("\tcall scanf");
										global_map.put($1.sval, "%d");
										while (!used_registers.empty()) {
											freeRegister(used_registers.pop());
										} 
									}
			;

call_stmt	: ID LP RP {
							pre_call();
							if (return_count >= 1) {
								String reg = getRegister();
								used_registers.push(reg);
							}
							System.out.println("\tcall " + $1.sval); 
					   }
		| ID LP {pre_call(); addCall = 1;} expr_list RP {
															System.out.println("\tcall " + $1.sval);
													    }
		;

condition_stmt	: if_head statements {
										String if_header = used_if_headers.remove(used_if_headers.size() - 1);
										System.out.println("else" + if_header.substring(2,3) + ":\n\tjmp end_" + if_header + "\nend_" + if_header + ":");
										while (!used_registers.empty()) {
											freeRegister(used_registers.pop());
										}
									 } ENDIF 
				| if_head statements { 
										String if_header = used_if_headers.remove(used_if_headers.size() - 1);
										System.out.println("\tjmp end_" + if_header);
										System.out.println("else" + if_header.substring(2,3) + ":");
										used_if_headers.add(if_header);
									 } ELSE COLON statements {
																String if_header = used_if_headers.remove(used_if_headers.size() - 1);
																System.out.println("\tjmp end_" + if_header + "\nend_" + if_header + ":");
																while (!used_registers.empty()) {
																	freeRegister(used_registers.pop());
																}
															 } ENDIF
				;

if_head		: IF {
					if_flag = true;
					inner_if++;
					System.out.println("if" + inner_if + ":");
					used_if_headers.add("if" + inner_if);
				 } 
			  expression {
							System.out.println("\tcmpl $0, %eax"); /*for an expression evaluating to false*/
							System.out.println("\tje else" + inner_if);
						 } 
			  COLON
			; /*void type*/

while_stmt	: WHILE {
						while_flag = true;
						while_count++;
						System.out.println("while" + while_count + ":");
						used_while_headers.add("while" + while_count);
					}
			  expression {
							String reg = null;
							if (!used_registers.empty()) {
								reg = used_registers.pop();
								System.out.println("\tcmpl $0, " + reg);
								freeRegister(reg);
								System.out.println("\tje while" + while_count + "_exit");
							}
			  			 } 
			  COLON statements {
									String while_header = used_while_headers.remove(used_while_headers.size() - 1);
									System.out.println("\tjmp " + while_header);
									System.out.println(while_header + "_exit:");
									while (!used_registers.empty()) {
										freeRegister(used_registers.pop());
									}
			  				   } 
			  		ENDWHILE
			; /*void type*/

expr_list	: expr_list COMMA exp {
										addCall++;
										if (!used_registers.empty()) {
											String reg = used_registers.pop();
											addCallParameter(reg, addCall);
											used_registers.push(reg);
										}
								  }
		| exp {
					addCall = 1;
					if (!used_registers.empty()) {
						String reg = used_registers.pop();
						addCallParameter(reg, addCall);
						used_registers.push(reg);
					}	
			  }
		; /*void type*/

end_list: {
			System.out.println();
			System.out.print(io_setup);
			// System.err.println(used_registers.toString());
			System.out.println(".text\n.globl main\nmain:\n\tpushq %rbp"); /*global main where the funcs are going to be called from*/
		  } 
			statements {
							System.out.print(".text\n\tpopq %rbp\n\tret\n");
							while (!used_registers.empty()) {
								freeRegister(used_registers.pop());
							} 
					   }
		; /*void type*/


%%
static String pass_msg = "Input Accepted.\n";
static String syn_err_msg = "Syntax error at line ";
static String func_name = null;
String return_reg;

/*local symbol tables to collect ids in the local scope*/
static HashMap<String, String> local_map;

 /*global symbol tables to collect ids in the global scope*/
static HashMap<String, String> global_map;

static ArrayList<String> local_id_list; /*local array to collect names of ids in the local scope*/
static ArrayList<String> global_id_list; /*global array to collect names of ids in the global scope*/

static ArrayList<String> used_while_headers; /*to keep track of the used while headers*/
static ArrayList<String> used_if_headers; /*to keep track of the used while headers*/

static int[] registers = new int[6]; //initially all of the registers are free 
static Stack<String> used_registers; // keep track of the register being used

static boolean func_flag;
static boolean div_flag;
static boolean input_flag;
static boolean if_flag;
static boolean while_flag;
static boolean exp_flag;
static boolean call_flag;
static boolean return_flag;

static int inner_if = 0; /*used for generating new if labels everytime a unique if stmt is found*/
static int string_count = 1; /*this counter will be used for generating new ids*/
static int while_count = 0; /*while_start = 1, i = 0;*/
static int return_count = 0;
static int addCall = 1;
static int addCallF = 1;
static int addFunc = 1;

public static String getRegister() {
	for (int i = 0; i < registers.length; i++) {
		if (registers[i] == 0) { //if a register is free
			registers[i] = 1; // mark the register as being used
			if (i == 0)
				return "%r10d";
			else if (i == 1)
				return "%r11d";
			else if (i == 2)
				return "%r12d";
			else if (i == 3)
				return "%r13d";
			else if (i == 4)
				return "%r14d";
			else return "%r15d";
		}
	}
	return "sorry";
}

public static void freeRegister(String register) {
	if (register.contains("%r10"))
		registers[0] = 0;
	else if (register.contains("%r11"))
		registers[1] = 0;
	else if (register.contains("%r12"))
		registers[2] = 0;
	else if (register.contains("%r13"))
		registers[3] = 0;
	else if (register.contains("%r14"))
		registers[4] = 0;
	else if (register.contains("%r15")) registers[5] = 0;
}

public static void pre_call() { //pre call
	System.out.println("\tmovq %rdi, 72(%rsp)");
	System.out.println("\tmovq %rsi, 80(%rsp)");
	System.out.println("\tmovq %rdx, 88(%rsp)");
	System.out.println("\tmovq %rcx, 96(%rsp)");
	System.out.println("\tmovq %r8, 104(%rsp)");
	System.out.println("\tmovq %r9, 112(%rsp)");
	System.out.println("\tmovq %r10, 120(%rsp)");
	System.out.println("\tmovq %r11, 128(%rsp)");
	System.out.println("\tmovq %rax, 136(%rsp)");
	//System.out.println();
}

public static void post_call() {//after return
	//call function done in the call_stmt rule
	//System.out.println();
	System.out.println("\tmovq 72(%rsp), %rdi ");
	System.out.println("\tmovq 80(%rsp), %rsi ");
	System.out.println("\tmovq 88(%rsp), %rdx ");
	System.out.println("\tmovq 96(%rsp), %rcx ");
	System.out.println("\tmovq 104(%rsp), %r8");
	System.out.println("\tmovq 112(%rsp), %r9");
	System.out.println("\tmovq 120(%rsp), %r10");
	System.out.println("\tmovq 128(%rsp), %r11");
	if (return_count >= 1 && !used_registers.empty()) { 
		String reg = used_registers.pop();
		System.out.println("\tmovl %eax, " + reg);
		used_registers.push(reg);
	}
	System.out.println("\tmovq 136(%rsp), %rax");
	System.out.println();
}

public static void prologue() { //at the start of a function
	System.out.println("\tpushq %rbp");
	System.out.println("\tpushq %rbx");
	System.out.println("\tpushq %r12");
	System.out.println("\tpushq %r13");
	System.out.println("\tpushq %r14");
	System.out.println("\tpushq %r15");
	System.out.println("\tsubq $144, %rsp");
}

public static void epilogue() { //at the return point of a function
	System.out.println("\taddq $144, %rsp");
	System.out.println("\tpopq %r15");
	System.out.println("\tpopq %r14");
	System.out.println("\tpopq %r13");
	System.out.println("\tpopq %r12");
	System.out.println("\tpopq %rbx");
	System.out.println("\tpopq %rbp");
	System.out.println("\tret");
}

public static void addFuncParameter(String parameter) {
	System.out.println(".text");
	if (addFunc == 1) System.out.println("\tmovl %edi, " + parameter + "(%rip)");
	else if (addFunc == 2) System.out.println("\tmovl %esi, " + parameter + "(%rip)");
	else if (addFunc == 3) System.out.println("\tmovl %edx, " + parameter + "(%rip)");
	else if (addFunc == 4) System.out.println("\tmovl %ecx, " + parameter + "(%rip)");
	else if (addFunc == 5) System.out.println("\tmovl %r8d, " + parameter + "(%rip)");
	else if (addFunc == 6) System.out.println("\tmovl %r9d, " + parameter + "(%rip)");
}

public static void addCallParameter(String parameter, int call) {
	System.out.println(".text");
	//System.err.println("Call: " + addCall);
	if (call == 1) System.out.println("\tmovl "  + parameter + ", %edi");
	else if (call == 2) System.out.println("\tmovl "  + parameter + ", %esi");
	else if (call == 3) System.out.println("\tmovl "  + parameter + ", %edx");
	else if (call == 4) System.out.println("\tmovl "  + parameter + ", %ecx");
	else if (call == 5) System.out.println("\tmovl "  + parameter + ", %r8d");
	else if (call == 6) System.out.println("\tmovl "  + parameter + ", %r9d");
	//freeRegister(parameter);
	used_registers.push(parameter);
}

static String io_setup = ".section .rodata\n" +
                       "LPRINT0:  .string \"%d\\n\"\n" +
                       "LPRINT1:  .string \"%s\\n\"\n" +
                       "LGETINT:  .string \"%d\"\n";

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
   System.err.print( error + " at line " + (scanner.getLine()+1) +"\n"); 
   System.exit(-1);
}

public p4_java (Reader r) { 
   scanner = new lexer (r, this); 
} 

public static void main (String [] args) throws IOException {
   p4_java yyparser = new p4_java(new InputStreamReader(System.in));
   used_registers = new Stack<>();
   local_map = new HashMap<>();
   global_map = new HashMap<>();
   local_id_list = new ArrayList<>();
   global_id_list = new ArrayList<>();
   used_while_headers = new ArrayList<>();
   used_if_headers = new ArrayList<>();
   div_flag = false;
   input_flag = false;
   if_flag = false;
   while_flag = false;
   func_flag = false;
   yyparser.yyparse();
   //used_registers.clear();
   global_map.clear();
   global_id_list.clear();
   used_while_headers.clear();
   used_if_headers.clear();
   System.err.print( pass_msg);
}