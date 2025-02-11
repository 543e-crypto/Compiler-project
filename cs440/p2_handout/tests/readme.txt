Valid Mython programs with no errors:
  - test0.my: simplest program w/ no function and one print stmt
  - test1.my: one function, no variables
  - test2.my: one function, one ID in endlist, expr, no variables
  - test3.my: function, ID as local variables 
  - test4.my: function w/ parameters, multiple different exprs
  - test5.my: multiple functions, input, print
  - test6.my: function call in another function
  - test7.my: a more complex example

  - check testX.out for expected output to stdout for testX.my
  - check testX.err for expected output to stderr for testX.my

===========================================================
Invalid Mython programs with errors:
  - error1.my: missing end marker of function (end of input, line 4 / 5)
  - error2.my: unknown token # (line 2)
  - error3.my: redundant comma (line 1)
  - error4.my: incorret assignment stmt (line 2)
  - error5.my: RETURN (case sensitive) (line 6)
  - error6.my: missing function body (line 2)

  - check errorX.err for expected output to stderr for errorX.my
  - It is possible/acceptable that the reported line number of error is off by 1, especially if the error cannot be determined until the end of the input. 

