Input with no lexical errors:
  - check output_expected folder for:
     - testX.err file (output to standard error) 
     - testX.out file (output to standard out) 

test0.my: trivial "hello world" mython program
test1.my: basic mython program with all token types (example in spec)
test2.my: keywords only
test3.my: examples of numbers and operators
test4.my: strings
test5.my: examples with "defined" identifiers

Input with lexical errors:
  - check output_expected folder for:
     - errorX.err file (output to standard error) 
     - no output expected to standard out (empty files omitted) 

error0.my: unrecognized character (#) at line 2
error1.my: unrecognized charater (%) at line 5

