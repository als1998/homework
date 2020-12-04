% SAR_Figure_3_13
% 2016/08/31
close all;clear all;clc;

T = 10e-6;          % �������ʱ��
B = 15e6;           % �������
K = B/T;            % ��Ƶ��
ratio = 5;          % ��������
Fs = ratio*B;       % ����Ƶ��
dt = 1/Fs;          % �������
Nr = ceil(T/dt);    % ��������
t0 = ((0:Nr-1)-Nr/2)/Nr*T;          % ����ʱ����

st0 = exp(1i*pi*K*(t0-T/5).^2);     % �����ź�
space1 = zeros(1,round(Nr/5));      % ���ɿ��ź�
space2 = zeros(1,Nr);               % ���ɿ��ź�
st = [space1,st0,space2,st0,space2,st0,space1];     % ʵ���ź�

N = length(st);             % ʵ���źų���
n = 0:N-1;                  % ������
f = ((0:N-1)-N/2)/N*Fs;     % ����Ƶ����

Sf = fftshift(fft(st));                         % ʵ���źŵĸ���Ҷ�任
Hf1 = fftshift(fft(conj(fliplr(st0)),N));       % ��ʽ1��ƥ���˲�����ʱ�䷴�޺�ȡ���������N�㲹��DFT
Hf2 = fftshift(conj(fft(st0,N)));               % ��ʽ2��ƥ���˲�������������DFT���Խ��ȡ������
Hf3 = exp(1i*pi*f.^2/K);                        % ��ʽ3��ƥ���˲�����ֱ����Ƶ������ƥ���˲���

out1 = ifft(ifftshift(Sf.*Hf1));
out2 = ifft(ifftshift(Sf.*Hf2));
out3 = ifft(ifftshift(Sf.*Hf3));

figure,set(gcf,'Color','w');    
subplot(4,1,1),plot(n,real(st));axis tight
title('(a)���������źŵ�ʵ��');ylabel('����');
subplot(4,1,2),plot(n,abs(out1));axis tight
title('(b)��ʽ1��ƥ���˲����');ylabel('����');
subplot(4,1,3),plot(n,abs(out2));axis tight
title('(c)��ʽ2��ƥ���˲����');ylabel('����');
subplot(4,1,4),plot(n,abs(out3));axis tight
title('(d)��ʽ3��ƥ���˲����');xlabel('ʱ��(������)');ylabel('����');