close all;clear all;clc;
%%  
T = 10e-6;          % �������ʱ��
B = 15e6;           % �������
k = B/T;            %��Ƶ��
ratio = 1.2;          %��������
Fs = ratio*B;       %������
Ts = 1/Fs;
N=fix(T.*Fs);
t1 = linspace(-T/3,2*T/3,N);

st1=exp(1j*pi*k*t1.^2);
st0=zeros(1,N);
st3=zeros(1,fix(N/5));
st=[st3 st1 st0 st1 st0 st1 st3];

Nfft=size(st,2);

t2=[1:Nfft];
subplot(3,1,1)
plot(t2,st);

%%  �˲�������
f=linspace(-Fs/2,Fs/2,Nfft);

Sf = fftshift(fft(st));
hf1 = fftshift(fft(conj(fliplr(st1)),Nfft));
hf2 = fftshift(conj(fft(st1,Nfft)));
hf3 = exp(1j*pi/k.*f.^2);


out1 = ifft(ifftshift(Sf.*hf1));
out2 = ifft(ifftshift(Sf.*hf2));
out3 = ifft(ifftshift(Sf.*hf3));

figure,set(gcf,'Color','w');    
subplot(4,1,1),plot(t2,real(st));axis tight
title('(a)���������źŵ�ʵ��');ylabel('����');
subplot(4,1,2),plot(t2,abs(out1));axis tight
title('(b)��ʽ1��ƥ���˲����');ylabel('����');
subplot(4,1,3),plot(t2,abs(out2));axis tight
title('(c)��ʽ2��ƥ���˲����');ylabel('����');
subplot(4,1,4),plot(t2,abs(out3));axis tight
title('(d)��ʽ3��ƥ���˲����');xlabel('ʱ��(������)');ylabel('����');