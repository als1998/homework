clc;clear;
close all;

T=7.24e-6;
B=5.8e6;
k=B/T;
fs=5.*B;
Ts=1/fs;
N=ceil(T/Ts);
t=linspace(-T/2,T/2,N);
signal=exp(1i*pi*k*t.^2); 
signalf=fftshift(fft(signal));


subplot(2,2,1);
plot(t,real(signal));
subplot(2,2,2);
plot(t,imag(signal));
subplot(2,2,3);
plot(t,pi*k*t.^2);
subplot(2,2,4);
plot(t,k*t/2);