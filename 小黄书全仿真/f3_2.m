clc;clear;
close all;

%%�ź�����
T=7.24e-6;
B=99.4e6;
k=B/T;
fs=1.25.*B;
Ts=1/fs;
N=ceil(T/Ts);
t=linspace(-T/2,T/2,N);
signal=exp(1i*pi*k*t.^2); 
signalf=fftshift(fft(fftshift(signal)));

%%��ͼ
subplot(2,2,1);
plot(t,real(signal));
title('�źŵ�ʵ��');

subplot(2,2,2);
plot(t,imag(signal));
title('�źŵ��鲿')
subplot(2,2,3);
plot(t,abs(signalf));
title('Ƶ�׷���')
subplot(2,2,4);
plot(t,unwrap(angle(signalf)));
title('Ƶ����λ')

