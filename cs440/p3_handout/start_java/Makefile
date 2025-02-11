BYACC=/opt/cec/bin/yacc32-1.15
JFLEX=./jflex-full-1.7.0.jar

p3_java: p3_java.java lexer.java
	javac -classpath "" *.java

lexer.java: p3_java.l
	java -jar $(JFLEX) --legacydot p3_java.l 

p3_java.java: p3_java.y
	$(BYACC) -Jclass=p3_java p3_java.y

clean:
	rm -f lexer.java lexer.java~ p3_java*.class p3_java*.java lexer.class

