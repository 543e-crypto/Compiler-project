For all test cases:
  - Check testX.s for sample x86-64 translation. 
  - Your compiler does NOT have to generate identical x86 code.
  - Requirements for your translation:
     - It must have the same semantic as the orignal Mython code;
     - It must be a working assembly program that gcc can assemble;
     - It must follow the specific requirements we have in P4 PDF. 
===========================================================
Group 1: Mython programs with only end_list (no functions):
  - test0.my: print constant integer
  - test1.my: print arithmetic experssions w/ constants only
  - test2.my: integer variables initialized w/ constants
              (assignment, expression, print)
  - test3.my: integer variables initialized w/ input() 
        [NOTE: need user-input when execute]
  - test4.my: integer variables, expressions w/ division
  - test5.my: boolean variables in assignment and printing
  - test6.my: string constant and printing
  - test7.my: relational expressions
  - test8.my: if statements
  - test9.my: if-else
        [NOTE: need user-input when execute]
  - test10.my: while-loop w/ comparison 
  - test11.my: while-loop w/ boolean variable 
        [NOTE: need user-input when execute]
  - test12.my: if nested inside a while loop
===========================================================
Mython programs with functions:
  - test20.my: function with no parameters, no return, no local variables
  - test21.my: function with a return, no parameters, no local variables 
  - test22.my: multiple function definitions, no parameters/return/locals, 
               a sequence of >1 function calls 
  - test23.my: function with local variables, no parameters, no return
  - test24.my: function with parameters, nested if, no return, no local variables
  - test25.my: multiple function definitions and nested function calls


