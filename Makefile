all: strikem.app
	-killall strikem
	open strikem.app

strikem.app: strikem.dsp
	faust2caqt strikem.dsp

data:
	faust2api -juce -soundfile strikem.dsp
	unzip dsp-faust.zip

# faust2api -juce -soundfile -nozip strikem.dsp

tclean: clean
	-/bin/rm -f strikem

clean:
	-/bin/rm -f strikem.m strikem.dsp.cpp
	-/bin/rm -rf strikem-svg strikem.app
