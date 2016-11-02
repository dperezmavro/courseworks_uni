CC = gcc
OUTDIR = ./bin
CCFLAGS = -std=c99 -w -lm
OPTFLAG = -O3
SRCS = ./src/core/*.c
EXT=./src/ext/*.c
PLOTFILES = *.plg
DATAFILES = ./data/*.data

all:
	make core
	make ext

core : ${SRCS}
	${CC} ${SRCS} ${CCFLAGS} ${OPTFLAG} -o ${OUTDIR}/core.out 

ext : ${EXT}
	${CC} ${EXT} ${CCFLAGS} ${OPTFLAG} -o ${OUTDIR}/ext.out 

debug:
	${CC} ${SRCS} -g ${CCFLAGS}

plots : ./plots/scripts/*.plg ./data/*
	gnuplot -e "filename='data/ra.data.done'" plots/scripts/ra_plot.plg 
	gnuplot -e "filename='data/gr.data.done'" plots/scripts/gr_plot.plg 
	gnuplot -e "filename='data/ac.data.done'" plots/scripts/ac_plot.plg 
	gnuplot -e "filename='data/scw.data.done'" plots/scripts/scw_plot.plg
	gnuplot -e "filename='data/scw.data.done'" -e "filename2='data/scw.data.done.ext'" plots/scripts/scw_ext.plg
	gnuplot -e "filename='data/gr.data.done'" -e "filename2='data/gr.data.done.ext'" plots/scripts/gr_ext.plg
	gnuplot -e "filename='data/ra.data.done'" -e "filename2='data/ra.data.done.ext'" plots/scripts/ra_ext.plg
	gnuplot -e "filename='data/ac.data.done'" -e "filename2='data/ac.data.done.ext'" plots/scripts/ac_ext.plg

init :
	mkdir bin
	mkdir data
	mkdir plots
	mkdir plots/scripts

clean :
	rm ${OUTDIR}/* data/*.data