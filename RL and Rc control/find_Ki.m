clear;clc;
mp=0.25;
R=17;
L=18;
A=(log(mp)/pi);
ksi=sqrt(A^2/(1+A^2));
wn=R/(L*2*ksi);
Ki=(L/R)*wn^2;