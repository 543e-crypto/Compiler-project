#!/bin/sh

# to run this script:
#   - make sure you have the Java class p2_java.class
#   - for input with no errors, run with "./test.sh INPUT_NUM"
#   - e.g. "./test.sh 0" to test with test0.my
#
#   - for input with errors, run with "./test.sh INPUT_NUM -e"
#   - e.g. "./test.sh 1 -e" to test with error1.my

OUTDIR=./my_output
INDIR=../tests/input
EXPECTED=../tests/output_expected

if [ ! -d "$OUTDIR" ]; then
  echo "$OUTDIR created."
  mkdir "$OUTDIR"
fi

if (( $# == 1 )); then
echo "Test with test$1.my:"
echo " - Parsing result stored as test$1.err"
echo " - Function / identifiers report stored as test$1.out"
java p2_java <$INDIR/test$1.my >$OUTDIR/test$1.out 2>$OUTDIR/test$1.err
echo "--------------------------------------------------"
echo " - Compare $OUTDIR/test$1.err with $EXPECTED/test$1.err"
echo "--------------------------------------------------"
diff $OUTDIR/test$1.err $EXPECTED/test$1.err
error=$?
if [ $error -eq 0 ]
then
   echo "STDERR Passed: parsing result as expected!"
elif [ $error -eq 1 ]
then
   echo "STDERR Failed: parsing result not as expected."
fi

echo "--------------------------------------------------"
echo " - Compare $OUTDIR/test$1.out with $EXPECTED/test$1.out"
echo "--------------------------------------------------"
diff $OUTDIR/test$1.out $EXPECTED/test$1.out
error=$?
if [ $error -eq 0 ]
then
   echo "STDOUT Passed: function / identifier report as expected!"
elif [ $error -eq 1 ]
then
   echo "STDOUT Failed: function / identifier report not as expected."
fi

elif [[ ( $# -eq 2 ) &&  ( $2 == '-e') ]]; then
  echo "Test error checking with error$1.my:"
  echo " - Stderr output stored to error$1.err"
  echo " - Stdout output ignored"
java p2_java <$INDIR/error$1.my >/dev/null 2>$OUTDIR/error$1.err

echo "--------------------------------------------------"
echo " - Compare $OUTDIR/error$1.err with $EXPECTED/error$1.err"
echo "--------------------------------------------------"
diff $OUTDIR/error$1.err $EXPECTED/error$1.err
error=$?
if [ $error -eq 0 ]
then
   echo "STDERR Passed: error report as expected!"
elif [ $error -eq 1 ]
then
   echo "STDERR Failed: error report not as expected."
fi

else
  echo "incorrect usage of test.sh"
fi
