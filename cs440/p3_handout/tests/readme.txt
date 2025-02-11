Valid Mython programs with no errors:

  Group 1: test cases from P2; only INT and FUNC types
  - test0.my: simplest program w/ no function and one print stmt
  - test1.my: one function, no variables
  - test2.my: one function, one ID in endlist, expr, no variables
  - test3.my: function w/ local variables
  - test4.my: function w/ parameters, multiple different exprs
  - test5.my: multiple functions, input, print
  - test6.my: example from spec
  - test7.my: more complicate example

  Group 2: new test cases; more data types
  - test8.my: no function; global scope has multiple names with different 
types
  - test9.my: recursive factorial program (conditional stmt)
  - test10.my: iterative factorial program (while stmt)
  - test11.my: nested if statements
  - test12.my: iterative factorial with more type variations
  - test13.my: lots of copying between IDs

  - check testX.out for expected output to stdout for testX.my
  - check testX.err for expected output to stderr for testX.my

===========================================================
Invalid Mython programs with errors:

Group 1: test cases from P2; lexical / syntax errors
  - error1.my: missing enddef (end of input, line 4 / 5)
  - error2.my: unknown token # (line 2)
  - error3.my: redundant comma (line 1)
  - error4.my: incorret assignment stmt (line 2)
  - error5.my: RETURN (case sensitive) (line 6)
  - error6.my: missing function body (line 2)

Group 2: new test cases; no lexical/syntax errors but with semantic errors
  - error7.my: undefined ID in function scope (line 3)
  - error8.my: undefined ID in global scope (line 7)
  - error9.my: undefined function name (line 7)
  - error10.my: function duplicate definition (line 5)

  - check errorX.err for expected output to stderr for errorX.my
  - It is possible/acceptable that the reported line number of error is off by 1, especially if the error cannot be determined until the end of the input. 

