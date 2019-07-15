// strikem.dsp - test modal model interactively

NMAX = 100; // number of modes
M = 1;  // number of strikers

import("sf.lib");

N = hslider("[1] NModes",10,1,NMAX,1);

gate = button("[9] Gate");
D = hslider("[8] Duration",0.1,0,1,0.001);
impulse = (gate - gate') > 0;
shape = fi.pole(fi.tau2pole(D));

striker = impulse : shape : sf.dcblocker;

Amp = hslider("[8] level (db)", -10, -70, 10, 0.1) : sf.db2linear : sf.smooth(0.999);
F0 = hslider("[6] F0 (Hz)", 100, 20, 1000, 1); // : sf.smooth(0.999);
Q0 = 10.0 ^ hslider("[7] log10_Q", 2, 0, 5, 0.1); // : sf.smooth(0.999);

A(i) = Amp/float(i+1);
fc(i) = F0*(i+1);
Q(i) = Q0;

mode(i) = fi.resonbp(fc(i),Q(i),A(i));

modes = par(i,NMAX,mode(i) : *(i<N));

pan2stereo(nIn,nActive) = si.bus(nIn) <: si.bus(2*nIn) : ro.interleave(nIn,2) :
	     par(i,nIn,*(panGainLeft(i)),*(panGainRight(i))) :> _,_
with {
  pan(i) = i/nActive;
  // needs work: scale = 1.0/sqrt(nActive/2.0); // assume half in each channel
  scale = 1; // go ahead and work level slider manually
  panGainLeft(i) = scale * (1.0-pan(i));
  panGainRight(i) = scale * pan(i);
};

model = striker <: modes;
process = model : pan2stereo(NMAX,N);
// process = 1-1' : shape <: modes :> _;
//process = 1-1' : shape <: _, mode(0);
