clc,close all ,clear all;
N = 10;     %������Դ����
d =  0.8;      %��Դ���� 30cm
lambda = 1   ;%���� 1m
theta_0 = 0;  %����ָ��
theta_i  =  [-pi/2:pi/100:pi/2];    %��������

E_phi =zeros(1,length(theta_i));    %�״﷽��ͼ

for  n=0:N-1
E_phi=E_phi+exp(i*n*2*pi*(d/lambda).*sin(theta_i))*exp(-1*i*n*d*2*(pi/lambda)*sin(theta_0));
end
figure(1)
plot(theta_i/pi*180,20*log(abs(E_phi)./max(abs(E_phi))) );
title('���߷���ͼ');
axis([-90,90,-60,0])