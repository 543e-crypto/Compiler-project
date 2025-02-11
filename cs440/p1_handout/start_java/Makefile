p1_java: p1_java.java
	javac p1_java.java

p1_java.java: p1_java.l
	java -jar ./jflex-full-1.7.0.jar --legacydot p1_java.l 

clean:
	rm -f p1_java.java p1_java.java~ p1_java.class

