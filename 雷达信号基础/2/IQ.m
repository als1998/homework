close all;clc;clear all;
%%
%   LFM ��linear frequency modulation
%% ��������
B  = 30e6;  % ����100MHz
T  = 10e-6;  % ����2us
Fs = 150e6; % ������һ��Ϊ1.1B��1.2B
N = T*Fs;   % ��������
t = -T/2:1/Fs:T/2-1/Fs;
K = B/T;
f = K*t; %�ź�Ƶ��
A = 1;
r = 0; %I·ֱ��
k = 0; %Q·ֱ��
delta_theta = pi/3;    %��λ��
err = 0;          %���Ȳ�
%% 
I = A*cos(pi*K*t.^2)+r;
Q = A*(1+err)*sin(pi*K*t.^2-delta_theta)+k;
St = I+1j*Q;   % ����IQ����źŵĲ���ֵ
lfm = exp(1j*pi*K*t.^2); % �ź���ʵֵ
Sf = abs(fftshift(fft(St)));
LF = abs(fftshift(fft(lfm)));
matcher = conj(fliplr(lfm)); % ƥ���˲���
out_matcher=conv(lfm,matcher); % ƥ���˲������
out_matcher1=conv(St,matcher); % IQ����ź�ƥ���˲������
% figure
% plot(F,angle(out_matcher1));
Amerr = out_matcher-out_matcher1; % ���
out_matcher = abs(out_matcher);
out_matcher1 = abs(out_matcher1);
%% 
figure
subplot(2,1,1);plot(t,real(lfm),'r',t,real(St));title('ʵ��');legend('����LFM','��IQ����ʵ���ź�');
subplot(2,1,2);plot(t,imag(lfm),'r',t,imag(St));title('�鲿');legend('����LFM','��IQ����ʵ���ź�');


figure
plot(f,LF,'r',f,Sf);title('Ƶ�ױȽϣ���theta=��,err=0.6��r = 0.2��k = 0.2��');
legend('����LFM','��IQ����ʵ���ź�');

figure
F = -T+1/Fs:1/Fs:T-1/Fs;

plot(F,20*log10(out_matcher),'r',F,20*log10(out_matcher1+1e-6));title('ƥ���˲���������Ƚ�,��theta=pi/3,err=0,r = 0��k = 0��');axis([-T/10,T/10,-80,70]);%axis tight;%
legend('����LFM','��IQ����ʵ���ź�');

