clear all;
close all;
clc;
%���ò���
%�״﹤��Ƶ��
GHz=1e9;
us=1e-9;
c=3e8;
f0=10*GHz;
lambda=c/f0;
d=lambda*2;
T=20*us;
%����Ƶ��
fs=4*f0;
t=0:1/fs:T;
s0=cos(2*pi*f0.*t);

%������Ƶ�����ź�
figure(1);
tx=t/us;
plot(t,s0);
ylim([-1.5 1.5]);%y���������ʾ��Χ
xlabel('Time(us)');
ylabel('����');
title('����Ƶ�����ź�');

%�趨����ָ��
theta0_deg=0;
theta0=-theta0_deg*pi/180;

%������������
N=32;%�趨��Ԫ��
theta=zeros(1,N);
for n=1:N
    theta(n)=(n-1)*2*pi*d*sin(theta0)/lambda;   
end
%���㲻ͬ�Ƕ���������
theta_deg_0=-90:0.1:90;
theta_deg=theta_deg_0.*pi/180;
N_theta=length(theta_deg);
%�Դ�-90�ȵ�90��ÿ���ǶȽ���
E=zeros(1,N_theta);
E_w=zeros(1,N_theta);
Nt=length(t);
for m=1:N_theta
    %������������
    sum=zeros(1,Nt);
    sum_w=zeros(1,Nt);
    w_hamming=hamming(N);
    for n=1:N
      %���������Ԫ�źŵ�������ȥ 
      xin_w=w_hamming(n)*cos(2*pi*f0*t+(n-1)*2*pi*d*sin(theta_deg(m))/lambda+theta(n)); 
      xin=cos(2*pi*f0*t+(n-1)*2*pi*d*sin(theta_deg(m))/lambda+theta(n)); 
      sum=sum+xin;
      sum_w=sum_w+xin_w;
    end
    %�����
    E(m)=max(abs(sum));
    E_w(m)=max(abs(sum_w));
end

%h������ͼ
figure(2);
subplot(2,1,1);
E=20*log10(E/max(E));%��һ��
plot(theta_deg_0,E);
xlim([-40 40]);
xlabel('�Ƕ�(��)');
ylabel('����(dB)');
title('ֱ�Ӳ����γɽ��(��Ԫ��32,dΪ2������)');
subplot(2,1,2);
E_w=20*log10(E_w/max(E_w));
plot(theta_deg_0,E_w);
xlim([-40 40]);
xlabel('�Ƕ�(��)');
ylabel('����(dB)');
title('��Ȩ�����γɽ��(��Ԫ��32,dΪ2������)');


