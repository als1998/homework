clc,close all ,clear all;
N = 10;     %������Դ����
d =  0.5;      %��Դ���� 30cm
lambda = 1   ;%���� 1m
theta_0 = 10*pi/180;  %����ָ��
theta_i  =  [-pi/4+pi/1000:pi/1000:pi/4-pi/1000];    %#ok<NBRAK> %��������
E_phi =zeros(1,length(theta_i));    %�״﷽��ͼ

cccc = zeros(1,100);
% 
for N = 2:1:100

   
E_phi =zeros(1,length(theta_i));    %�״﷽��ͼ
        for  n=0:N-1
          E_phi=E_phi+exp(i*n*2*pi*(d/lambda).*sin(theta_i))*exp(-1*i*n*d*2*(pi/lambda)*sin(theta_0)); %#ok<*IJCL>

        end
    c12=20*log(abs(E_phi)./max(abs(E_phi)));

%       E_phi=abs(E_phi).^2;
%       cccc(N+1)=4*pi*max(E_phi)/sum(E_phi) ;
%     plot(theta_i/pi*180,c12 );
%     title('���߷���ͼ theta=30');
%     xlabel('�Ƕ�'),ylabel('���ʣ�dB��')
%     axis([-90,90,-60,0])
    cccc(N)=W_3dB(c12);
  end
    
