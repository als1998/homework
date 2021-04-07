clc,close all ,clear all;
Nx = 1000;     %天线振源数量
Ny = 1000;
dx =  0.3;      %振源距离 30cm
dy =  0.3;  
lambda = 1   ;%波长 1m
theta_0 = 0;  %天线指向
phi_0 = 0;

theta_i  =  [-pi/2:pi/200:pi/2];    %来波方向
phi_i    =  [-pi:pi/100:pi];

E_x =zeros(length(phi_i),length(theta_i));    %雷达方向图
E_y =zeros(length(phi_i),length(theta_i)); 

delta_phi_x = 2*pi/lambda*dx*(cos(phi_i)'*sin(theta_i));
delta_phi_y = 2*pi/lambda*dy*(sin(phi_i)'*sin(theta_i));
delta_phi_x0 = 2*pi/lambda*dx*(cos(phi_0)'*sin(theta_0));
delta_phi_y0 = 2*pi/lambda*dy*(sin(phi_0)'*sin(theta_0));
for  n=0:Nx-1
E_x=E_x+exp(i*n*delta_phi_x).*exp(-i*n*delta_phi_x0);
end
for  n=0:Ny-1
E_y=E_y+exp(i*n*delta_phi_y).*exp(-i*n*delta_phi_y0);
end
E_phi=abs(E_x).*abs(E_y);



x=ones(1,201)'*theta_i;
y=phi_i'*ones(1,201);
figure(1)
mesh(x/pi*180,y/pi*180,20*log(abs(E_phi)./max(max(abs(E_phi)))) );
title('天线方向图');
axis([-90,90,-180,180,-160,0])
colorbar