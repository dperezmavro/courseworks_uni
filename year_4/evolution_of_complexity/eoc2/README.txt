In order to compile the software, run (while in the root directory of the project)
    make init
    make core
    make ext

the core implementation of pdj will be under bin/core.out, while the extension will be under bin/ext.out .

when the programs have finished running, rename all the xxx.data files under data/ to xxx.data.done (if running core.out) or xxx.data.done.ext (if running ext.out).

plots/ has plot files generated. to make the plots type
    make plots
