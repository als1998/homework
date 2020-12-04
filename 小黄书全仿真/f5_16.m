clc;clear;
close all;

R_etac = 20e3;      
V_r = 150;
T_r = 25e-6;
Kr = 0.25e+12;
f0 = 5.3e9;
B_dop = 80;
Fs = 7.5e6;
PRF = 104;
Naz = 256;
Nrg = 254;
theta_sq=0;
eta_c=0;
f_etac=0;
c=3e8;
lambda=c/f0;
PRT=1/PRF;
Ft=1/Fs;
Ka=2*V_r^2*f0/(c*R_etac);
N=T_r.*Fs;

eta=linspace(-Naz*PRT/2,Naz*PRT/2,Naz);
t=linspace(-Nrg*Ft/2,Nrg*Ft/2,Nrg);

R_eta=sqrt(R_etac^2+(V_r.*eta).^2);
tau=2*R_eta/c;

st=zeros(Naz,Nrg);
for i=1:Naz
    st(i,:)=exp(-1j*4*pi*R_etac/lambda)*exp(-1j*pi*Ka*eta(i).^2).*exp(1j*pi*Kr.*(t-tau(i)).^2).*((t-tau(i))>-N/2).*((t-tau(i))<N/2);
    st(i,:)=exp(-1j*pi*Ka*eta(i).^2).*exp(1j*pi*Kr.*t.^2).*((t-tau(i))>-N/2).*((t-tau(i))<N/2);

end


stf=fty(st);
figure(2)
surf(angle(stf));
xlabel('距离时间');
ylabel('方位频率');




