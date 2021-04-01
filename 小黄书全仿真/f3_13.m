close all;clear all;clc;
%%  
T = 10e-6;          % 脉冲持续时间
B = 15e6;           % 脉冲带宽
k = B/T;            %调频率
ratio = 1.2;          %过采样率
Fs = ratio*B;       %采样率
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

%%  滤波器生成
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
title('(a)输入阵列信号的实部');ylabel('幅度');
subplot(4,1,2),plot(t2,abs(out1));axis tight
title('(b)方式1的匹配滤波输出');ylabel('幅度');
subplot(4,1,3),plot(t2,abs(out2));axis tight
title('(c)方式2的匹配滤波输出');ylabel('幅度');
subplot(4,1,4),plot(t2,abs(out3));axis tight
title('(d)方式3的匹配滤波输出');xlabel('时间(采样点)');ylabel('幅度');