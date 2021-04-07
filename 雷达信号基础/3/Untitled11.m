clear all;
close all;
clc;
%设置参数
%雷达工作频率
GHz=1e9;
us=1e-9;
c=3e8;
f0=10*GHz;
lambda=c/f0;
d=lambda*2;
T=20*us;
%采样频率
fs=4*f0;
t=0:1/fs:T;
s0=cos(2*pi*f0.*t);

%画单载频发射信号
figure(1);
tx=t/us;
plot(t,s0);
ylim([-1.5 1.5]);%y轴的数据显示范围
xlabel('Time(us)');
ylabel('幅度');
title('单载频发射信号');

%设定波速指向
theta0_deg=0;
theta0=-theta0_deg*pi/180;

%计算阵内相移
N=32;%设定阵元数
theta=zeros(1,N);
for n=1:N
    theta(n)=(n-1)*2*pi*d*sin(theta0)/lambda;   
end
%计算不同角度阵外相移
theta_deg_0=-90:0.1:90;
theta_deg=theta_deg_0.*pi/180;
N_theta=length(theta_deg);
%对从-90度到90度每个角度进行
E=zeros(1,N_theta);
E_w=zeros(1,N_theta);
Nt=length(t);
for m=1:N_theta
    %计算阵外相移
    sum=zeros(1,Nt);
    sum_w=zeros(1,Nt);
    w_hamming=hamming(N);
    for n=1:N
      %加入各个阵元信号的相移中去 
      xin_w=w_hamming(n)*cos(2*pi*f0*t+(n-1)*2*pi*d*sin(theta_deg(m))/lambda+theta(n)); 
      xin=cos(2*pi*f0*t+(n-1)*2*pi*d*sin(theta_deg(m))/lambda+theta(n)); 
      sum=sum+xin;
      sum_w=sum_w+xin_w;
    end
    %求幅度
    E(m)=max(abs(sum));
    E_w(m)=max(abs(sum_w));
end

%h画方向图
figure(2);
subplot(2,1,1);
E=20*log10(E/max(E));%归一化
plot(theta_deg_0,E);
xlim([-40 40]);
xlabel('角度(°)');
ylabel('幅度(dB)');
title('直接波束形成结果(阵元数32,d为2倍波长)');
subplot(2,1,2);
E_w=20*log10(E_w/max(E_w));
plot(theta_deg_0,E_w);
xlim([-40 40]);
xlabel('角度(°)');
ylabel('幅度(dB)');
title('加权后波束形成结果(阵元数32,d为2倍波长)');


