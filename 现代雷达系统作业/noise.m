%% logistic
clc ,clear;
close all;
xn0 = [0:0.001:1];
xn1 = [0:0.001:1];
r = [2:0.0005:4];
x_out=zeros(size(xn0,2),size(r,2));
for i_r=1:size(r,2)
    for i=1:100
        xn1 = r(i_r).*xn1.*(1-xn1);
    end
    x_out(:,i_r)=xn1.';  
    xn1=xn0;
end   

logistic=x_out;

drawpic(logistic);

%% tent

xn0 = [0:0.001:1];
xn1 = [0:0.001:1];
a = [1.0:0.0005:2];
x_out=zeros(size(xn0,2),size(a,2));
for i_a=1:size(a,2)
    for i=1:100
        xn1 = a(i_a).*xn1.*(xn1<=0.5)+a(i_a).*(1-xn1).*(xn1>0.5);
    end
    x_out(:,i_a)=xn1.';
    xn1=xn0;
end   

tent=x_out;
drawpic(tent);

%% bernoulli

xn0 = [-0.5:0.001:0.5];
xn1 = xn0;
B = [1.0:0.0005:2];
x_out=zeros(size(xn0,2),size(B,2));
for i_B=1:size(B,2)
    for i=1:100
        xn1 = (B(i_B).*xn1+0.5).*(xn1<0)+(B(i_B).*xn1-0.5).*(xn1>0);
    end
    x_out(:,i_B)=xn1.';
    xn1=xn0;
end   

bernoulli=x_out;
drawpic(bernoulli);


