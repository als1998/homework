clc,close all ,clear all;
N = 10;     %天线振源数量
d =  0.5;      %振源距离 30cm
lambda = 1   ;%波长 1m
theta_0 = 10*pi/180;  %天线指向
theta_i  =  [-pi/4+pi/1000:pi/1000:pi/4-pi/1000];    %#ok<NBRAK> %来波方向
E_phi =zeros(1,length(theta_i));    %雷达方向图

cccc = zeros(1,100);
% 
for N = 2:1:100

   
E_phi =zeros(1,length(theta_i));    %雷达方向图
        for  n=0:N-1
          E_phi=E_phi+exp(i*n*2*pi*(d/lambda).*sin(theta_i))*exp(-1*i*n*d*2*(pi/lambda)*sin(theta_0)); %#ok<*IJCL>

        end
    c12=20*log(abs(E_phi)./max(abs(E_phi)));

%       E_phi=abs(E_phi).^2;
%       cccc(N+1)=4*pi*max(E_phi)/sum(E_phi) ;
%     plot(theta_i/pi*180,c12 );
%     title('天线方向图 theta=30');
%     xlabel('角度'),ylabel('功率（dB）')
%     axis([-90,90,-60,0])
    cccc(N)=W_3dB(c12);
  end
    
