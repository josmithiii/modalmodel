all: strikem.app
	-killall strikem
	open strikem.app

strikem.app: strikem.dsp
	faust2caqt strikem.dsp

tclean: clean
	-/bin/rm -f strikem

clean:
	-/bin/rm -f strikem.m strikem.dsp.cpp
	-/bin/rm -rf strikem-svg strikem.app
