SRCDIR = ../../../src
MCD = ./dev/mgridclient

all : CharCounter CharCounterMain applet appletjar
	make applet
	make appletjar
	make CharCounter
	make CharCounterMain
	make normaljar

normaljar : CharCounter.class CharCounterMain.class
	jar -cfm jars/CharCounterMain.jar Manifest.MF *.class

appletjar : counterapplet/CounterApplet.class
	jar -cf jars/CounterApplet.jar counterapplet/

applet : ../../../src/counterapplet/CounterApplet.java
	javac -d ./ $(SRCDIR)/counterapplet/CounterApplet.java

CharCounter : ../../../src/CharCounter.java
	javac -d ./ $(SRCDIR)/CharCounter.java

CharCounterMain : ../../../src/CharCounterMain.java
	javac -d ./ $(SRCDIR)/CharCounterMain.java

move :
	cp -r jars/CounterApplet.jar $(MCD)/jars/
	cp -r counterapplet/ $(MCD)/ 
	cp $(SRCDIR)/../counterapplet.html $(MCD)

clean : 
	rm *.class counterapplet/*.class jars/*.jar

zip :
	zip -j submission parameters.txt dev/gridsam-2.3.0-client/GridSAMExample.java ../../../src/counterapplet/CounterApplet.java ../../../report/lsd_report.pdf
