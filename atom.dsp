// atom.dsp - proposed sound atom

import("stdfaust.lib");

N = 50; // number of components in both directions from center frequency

gate = button("[0] Gate");
dur = hslider("[1] Duration (s)",0.5,0,10,0.001);
att = hslider("[2] Attack (s)",0.1,0,1,0.001);
dec = hslider("[3] Decay (s)",0.1,0,1,0.001);
sus = hslider("[4] Sustain (frac)",1.0,0,1,0.001);
rel = hslider("[5] Release (s)",1.0,0,10,0.001);

amp = hslider("[6] Level (dB)", -10, -70, 10, 0.1) : sf.db2linear;
frq = hslider("[7] Center Frequency (Hz)", 100, 20, 1000, 1);
fac = hslider("[8] Frequency Spacing (factor)", 1, 0.1, 10, 0.01);
rrr = hslider("[9] roll-off rate to the right (db/octave)", -6, -100, 0, 0.1);
rrl = hslider("[10] roll-off rate to the left (db/octave)", -6, -100, 0, 0.1);

A(i) = amp/float(i+1); // FIXME: use rrr and rrl

fsp = frq * fac;
fp(i) = frq+i*fsp;
fm(i) = frq-i*fsp;
fc(i) = select2(i>0,
           frq,
           fp(i)+fm(i)-freq);
modep(i) = select2(fp(i)<pl.SR/4.0, 0.0, os.oscrs(fp(i)));
modem(i) = select2(fm(i)>0.0, 0.0, os.oscrs(fm(i)));
modes = par(i,N,A(i)*modep(i)),
        par(i,N,A(i)*modem(i)) :> _;

process = en.adsr(att,dec,sus,rel,gate) * modes;

