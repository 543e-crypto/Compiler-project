#!/bin/sh
# to run this script: 
#   - make sure you have the class p4_java.class
#   - run with "./run.sh TEST_CASE_NUM"
#   - e.g. "./run.sh 0"
INPUTDIR=../tests/input
OUTPUTDIR=./my_output
EXPECTEDDIR=../tests/output_expected

if [ ! -d "$OUTPUTDIR" ]; then
  mkdir "$OUTPUTDIR"
  echo "$OUTPUTDIR created."
fi

echo "Test with test$1.my:"
echo "-------------------------------------------------------------"
echo " - Use your compiler to generate x86 translation test$1.s"
echo "-------------------------------------------------------------"
java p4_java <$INPUTDIR/test$1.my >$OUTPUTDIR/test$1.s

echo "-------------------------------------------------------------"
echo " - Verify generated x86 assembles "
echo "   and runs with expected behavior "
echo "-------------------------------------------------------------"
echo "Assemble x86 code your compiler generated ($OUTPUTDIR/test$1.s):"
if gcc -g $OUTPUTDIR/test$1.s -o $OUTPUTDIR/test$1 ; then
  echo " - Gcc assemble passed; Next: run the generated executable"
  echo "-------------------------------------------------------------"
  $OUTPUTDIR/test$1
else
  echo "-- Gcc assemble failed"

fi

