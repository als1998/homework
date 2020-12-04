function [outputArg1] = bbvar(inputArg1)

avg=mean2(inputArg1);  %求图像均值
[m,n]=size(inputArg1);
s=0;
outputArg1=0;
for x=1:m
    for y=1:n
    outputArg1=outputArg1+(inputArg1(x,y)-avg)^2; %求得所有像素与均值的平方和。
    end
end

