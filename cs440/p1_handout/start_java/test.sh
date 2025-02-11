#!/bin/sh

# to run this script:
#   - make sure you have the class p1_java.class
#   - for input with no lexical errors, run with "./test.sh INPUT_NUM"
#   - e.g. "./test.sh 0" to test with test0.my
#
#   - for input with lexical errors, run with "./test.sh INPUT_NUM -e"
#   - e.g. "./test.sh 0 -e" to test with error0.my

OUTDIR=./my_output
INDIR=../tests/input
EXPECTED=../tests/output_expected

if [ ! -d "$OUTDIR" ]; then
  echo "$OUTDIR created."
  mkdir "$OUTDIR"
fi

if (( $# == 1 )); then
echo "Test with test$1.my:"
echo " - Token summary output stored as test$1.err"
echo " - Defined Identifiers output stored as test$1.out"
java p1_java <$INDIR/test$1.my >$OUTDIR/test$1.out 2>$OUTDIR/test$1.err

echo "--------------------------------------------------"
echo " - Compare $OUTDIR/test$1.err with $EXPECTED/test$1.err"
echo "--------------------------------------------------"
diff $OUTDIR/test$1.err $EXPECTED/test$1.err
error=$?
if [ $error -eq 0 ]
then
   echo "Passed: identical token summary as expected!"
elif [ $error -eq 1 ]
then
   echo "Failed: token summary not as expected."
fi

echo "--------------------------------------------------"
echo " - Compare $OUTDIR/test$1.out with $EXPECTED/test$1.out"
echo "--------------------------------------------------"
diff $OUTDIR/test$1.out $EXPECTED/test$1.out
error=$?
if [ $error -eq 0 ]
then
   echo "Passed: identical defined identifiers as expected!"
elif [ $error -eq 1 ]
then
   echo "Failed: defined identifiers not as expected."
fi

elif [[ ( $# -eq 2 ) &&  ( $2 == '-e') ]]; then
  echo "Test error checking with error$1.my:"
  echo " - Stderr output stored to error$1.err"
  echo " - Stdout output ignored"
java p1_java <$INDIR/error$1.my >/dev/null 2>$OUTDIR/error$1.err

echo "--------------------------------------------------"
echo " - Compare $OUTDIR/error$1.err with $EXPECTED/error$1.err"
echo "--------------------------------------------------"
diff $OUTDIR/error$1.err $EXPECTED/error$1.err
error=$?
if [ $error -eq 0 ]
then
   echo "Passed: identical error report as expected!"
elif [ $error -eq 1 ]
then
   echo "Failed: error report not as expected."
fi

else
  echo "incorrect usage of test.sh"
fi
