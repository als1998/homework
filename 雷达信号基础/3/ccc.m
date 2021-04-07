clc,close all ,clear all;
Nx = 110;     %天线振源数量
Ny = 110;
dx =  0.03;      %振源距离 30cm
dy =  0.03;  
lambda = 0.1   ;%波长 1m
theta_0 = 0;  %天线指向
phi_0 = 0;

theta_i  =  [0:pi/1000:pi];    %来波方向
phi_i    =  [0:pi/1000:2*pi];

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
%E_phi=20*log(abs(E_phi)./max(max(abs(E_phi))));

theta=ones(1,length(phi_i))'*theta_i;
phi=phi_i'*ones(1,length(theta_i));

z=E_phi.*cos(theta);
x=E_phi.*sin(theta).*cos(phi);
y=E_phi.*sin(theta).*sin(phi);


figure(1)
mesh(x,y,z);
zlabel('z')
title('天线方向图');
axis([-max(max(x)),max(max(x)),-max(max(y)),max(max(y)),0,max(max(z))])
colorbar