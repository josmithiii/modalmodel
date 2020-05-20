# Interactive test app:
all: strikem.app
	-killall strikem
	open strikem.app

strikem.app: strikem.dsp
	faust2caqt strikem.dsp

# Generate data for training a synth model:
data:
	faust2sndfile strikem.dsp
	strikem -nmodes 10 -duration 1 -f0 100 -gate 1 -level -6 -log10q 2 strikem_n10_d1_f100_Q2_stereo.wav
	sox strikem_n10_d1_f100_Q2_stereo.wav strikem_n10_d1_f100_Q2_mono.wav remix -
	play strikem_n10_d1_f100_Q2_stereo.wav
	echo say "audacity strikem_n10_d1_f100_Q2_mono.wav"
	open -a Audacity strikem_n10_d1_f100_Q2_mono.wav
	echo "NEED TO NORMALIZE AMPLITUDE"

data-api:
	faust2api -juce -soundfile strikem.dsp
	unzip dsp-faust.zip

# faust2api -juce -soundfile -nozip strikem.dsp

tclean: clean
	-/bin/rm -f strikem

clean:
	-/bin/rm -f strikem.m strikem.dsp.cpp
	-/bin/rm -rf strikem-svg strikem.app
