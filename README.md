# modalmodel
Experiments in modal modeling

Model: N modes excited by up to M strikers

Parameters:

 N = number of modes max
 M = number of strikers max (e.g., M=2 for two drum sticks)
 
 Modes:
  fc
  bw
  g

 Strikers:
  A = amplitude
  D = duration = 1/bandwidth

Striker signal is presently a raised cosine, or maybe t e^{-t/D}, or maybe K x^p (piano hammer), or ?
