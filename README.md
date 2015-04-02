# topcoder-to-python
Topcoder question parser. Gives python file with the class and function's base structure created with the code for testing the output taken from the example.

##Dependencies:
 + flex
##Usage
####Compile using:
	lex questionParser.lex
	cc lex.yy.c -lfl -o top-to-py
####To access it from anywhere:
	sudo mv top-to-py /usr/bin/top-to-py
####Execute using:
	top-to-py < [input_file] > [output_file]