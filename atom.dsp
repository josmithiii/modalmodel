// atom.dsp - proposed sound atom

import("stdfaust.lib");

N = 50; // number of components in both directions from center frequency

gate = button("[1] Gate");
del = hslider("[2] Delay (s)",0,0,5,0.001);
dur = hslider("[3] Duration (s)",0.5,0,10,0.001);
att = hslider("[4] Attack (s)",0.1,0,1,0.001);
dec = hslider("[5] Decay (s)",0.1,0,1,0.001);
sus = hslider("[6] Sustain (frac)",1.0,0,1,0.001);
rel = hslider("[7] Release (s)",1.0,0,10,0.001);

amp = hslider("[8] Level (dB)", -10, -70, 10, 0.1) : sf.db2linear;
frq = hslider("[9] Center Frequency (Hz)", 100, 20, 1000, 1);
fac = hslider("[A] Frequency Spacing (factor)", 1, 0.1, 10, 0.01);
rrr = hslider("[B] roll-off rate to the right (db/octave)", -6, -100, 0, 0.1);
rrl = hslider("[C] roll-off rate to the left (db/octave)", -6, -100, 0, 0.1);

Ar(i) = 2.0 ^ (float(-i)*rrr/6.02);
Al(i) = 2.0 ^ (float(-i)*rrl/6.02);
fsp = frq * fac;
fp(i) = frq+i*fsp;
fm(i) = frq-i*fsp;
moder(i) = select2(fp(i)<pl.SR/4.0, 0.0, os.oscrs(fp(i)));
model(i) = select2(fm(i)>0.0, 0.0, os.oscrs(fm(i)));
modes = par(i,N,Ar(i)*moder(i)),
        par(i,N,Al(i)*model(i)) :> *(amp);

envelope = en.adsr(att,dec,sus,rel,gate);

process = envelope * modes <: _,_;
