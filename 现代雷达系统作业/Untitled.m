clc;
clear all;
close all;
imag=sqrt(-1);
element_num=10;
d_lamda=1/2;
theta=linspace(-pi/2,pi/2,200);
theta0=0;
w=exp(imag*2*pi*d_lamda*sin(theta0)*[0:element_num-1]');
for j=1:length(theta)
    a=exp(imag*2*pi*d_lamda*sin(theta(j))*[0:element_num-1]');
    p(j)=w'*a;
end
figure;
plot(theta,10*log(abs(p))),grid on
axis(-2,2,-20,15);
xlabel('theta/radian')
ylabel('amplitude')
title('10阵元均匀线阵方向图')