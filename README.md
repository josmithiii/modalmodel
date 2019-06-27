# modalmodel
Experiments in modal modeling

It should work on a Mac to type "make" and give it a try.  For Linux, change faust2caqt to faust2jaqt, etc.

Model: N modes excited by up to M strikers

* Parameters:
  - N = number of modes max
  - M = number of strikers max (e.g., M=2 for two drum sticks)
 
* Modes:
  -  fc
  -  bw
  -  g

* Strikers:
  -  A = amplitude
  -  D = duration = 1/bandwidth

Striker signal is presently a raised cosine, or maybe t e^{-t/D}, or maybe K x^p (piano hammer), or ?

---

# GOAL:

I want to convince myself with various examples (hand-edited and otherwise) that our striker model is sufficient, or decide what to add to it.

* The modalBar.dsp example in the Faust-STK port uses a sample.  I would like to avoid that and go fully parametric.

* Various past efforts have used a raised cosine (variable width).

* Cascading a one-pole exponential with itself has also been used to soften the attack (t e^{-t}, t^2 e^{-t}, etc.).

* Piano-hammer models use a nonlinear spring model f = k x^p, where p is 1 for linear and higher for more nonlinear. (Higher p is higher brightness and shorter "duration".)

* Chant multiplies decaying exponentials by a "half-Hann window".

* LPC has used "multipulse" excitation, optimally choosing a sparse set of impulses in place of 1.  (The first few can be relatively quiet, etc.)

* Any excitation can of course go through a "shaping filter".
  - Commuted synthesis uses this for piano-hammer modeling, with the shaping filter conditioned on striking velocity
  - (higher velocity => more bandwidth)
