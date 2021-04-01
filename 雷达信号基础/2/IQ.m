close all;clc;clear all;
%%
%   LFM ：linear frequency modulation
%% 参数设置
B  = 30e6;  % 带宽100MHz
T  = 10e-6;  % 脉宽2us
Fs = 150e6; % 采样率一般为1.1B或1.2B
N = T*Fs;   % 采样点数
t = -T/2:1/Fs:T/2-1/Fs;
K = B/T;
f = K*t; %信号频率
A = 1;
r = 0; %I路直流
k = 0; %Q路直流
delta_theta = pi/3;    %相位差
err = 0;          %幅度差
%% 
I = A*cos(pi*K*t.^2)+r;
Q = A*(1+err)*sin(pi*K*t.^2-delta_theta)+k;
St = I+1j*Q;   % 含有IQ误差信号的测量值
lfm = exp(1j*pi*K*t.^2); % 信号真实值
Sf = abs(fftshift(fft(St)));
LF = abs(fftshift(fft(lfm)));
matcher = conj(fliplr(lfm)); % 匹配滤波器
out_matcher=conv(lfm,matcher); % 匹配滤波的输出
out_matcher1=conv(St,matcher); % IQ误差信号匹配滤波的输出
% figure
% plot(F,angle(out_matcher1));
Amerr = out_matcher-out_matcher1; % 误差
out_matcher = abs(out_matcher);
out_matcher1 = abs(out_matcher1);
%% 
figure
subplot(2,1,1);plot(t,real(lfm),'r',t,real(St));title('实部');legend('理想LFM','含IQ误差的实际信号');
subplot(2,1,2);plot(t,imag(lfm),'r',t,imag(St));title('虚部');legend('理想LFM','含IQ误差的实际信号');


figure
plot(f,LF,'r',f,Sf);title('频谱比较，（theta=π,err=0.6，r = 0.2，k = 0.2）');
legend('理想LFM','含IQ误差的实际信号');

figure
F = -T+1/Fs:1/Fs:T-1/Fs;

plot(F,20*log10(out_matcher),'r',F,20*log10(out_matcher1+1e-6));title('匹配滤波脉冲输出比较,（theta=pi/3,err=0,r = 0，k = 0）');axis([-T/10,T/10,-80,70]);%axis tight;%
legend('理想LFM','含IQ误差的实际信号');

