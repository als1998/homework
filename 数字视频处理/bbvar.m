function [outputArg1] = bbvar(inputArg1)

avg=mean2(inputArg1);  %��ͼ���ֵ
[m,n]=size(inputArg1);
s=0;
outputArg1=0;
for x=1:m
    for y=1:n
    outputArg1=outputArg1+(inputArg1(x,y)-avg)^2; %��������������ֵ��ƽ���͡�
    end
end

