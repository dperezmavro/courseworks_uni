wekatitles :
	./printer.pl wp > wekatitles

popular :
	./printer.pl wp > wekatitles
	cat data | grep -e "[1|2|10]$$" > popular
	cp wekatitles wekatitles.arff
	cat popular >> wekatitles.arff 
	mv wekatitles.arff popular.arff
	rm popular

arff :	
	./printer.pl wp > wekafile
	cat data >> wekafile
	mv wekafile data.arff
csv :
	./printer.pl tf
	cp titles titles2
	cat data >> titles2
	mv titles2 data.csv
clean : 
	rm titles
	rm wekatitles
	rm popular.arff
	rm data.*
