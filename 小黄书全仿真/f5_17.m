R_etac = 20e3;
V_r = 150;
T_r = 25e-6;
Kr = 0.25e+12;
f0 = 5.3e9;
B_dop = 80;
Fs = 7.5e6;
PRF = 104;
Naz = 256;
Nrg = 256;
theta_sq=22.8;
eta_c=-51.7;
f_etac=2055;
R0=sqrt(R_etac^2-V_r^2*eta_c^2);

DeltaEta=1/PRF;


eta = linspace(-DeltaEta*Naz/2,DeltaEta*Naz/2,Naz)+eta_c;
tau = 