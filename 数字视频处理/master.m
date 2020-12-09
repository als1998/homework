clc;clear;
close all;
alpha=0.1;
file_path =  '.\pic\';% ͼ���ļ���·��
img_path_list = dir(strcat(file_path,'*.png'));%��ȡ���ļ���������jpg��ʽ��ͼ��
img_num = length(img_path_list);%��ȡͼ��������
images=zeros(194,164,3,21);
if img_num > 0 %������������ͼ��
        for j = 1:img_num %��һ��ȡͼ��
            image_name = img_path_list(j).name;% ͼ����
            images(:,:,:,j) =  imread(strcat(file_path,image_name));
            fprintf('%d %d %s\n',i,j,strcat(file_path,image_name));% ��ʾ���ڴ����ͼ����
        end
end
images2=zeros(194,164,21);
for j = 1:img_num %�ҶȻ�
images2(:,:,j)=fix((images(:,:,1,j)+images(:,:,2,j)+images(:,:,3,j))/3);              
end
images3=images2(:,:,1);
for i=1:194         %��ֵ
    for j=1:164
        for n=1:11
            images3(i,j)=fix(alpha*images3(i,j)+(1-alpha)*images2(i,j,n)); 
            
        end
       
    end    
end

images4=zeros(194,164);
for i=1:194         %��ֵ
    for j=1:164
        a=zeros(1,11);
        for n=1:11
            a(n)=images2(i,j,n);   
        end
        images4(i,j)= median(a);
    end    
end

imwrite(uint8(images3),'images3.png');
imwrite(uint8(images4),'images4.png');
figure(1)
imshow('images3.png');
figure(2)
imshow('images4.png');

imdelt1=zeros(194,164,10);
imdelt2=zeros(194,164,10);

for i=1:194         %��ֵ
    for j=1:164
        a=zeros(12,21);
        for n=1:11
            imdelt1(i,j,n)=images2(i,j,n+10)-images3(i,j);
            imdelt2(i,j,n)=images2(i,j,n+10)-images4(i,j); 
            images3(i,j)=fix(alpha*images3(i,j)+(1-alpha)*images2(i,j,n+10));
        end
    end    
end

for n=1:11
    imwrite(uint8(abs(imdelt1(:,:,n))),['.\pic1\hd',num2str(n),'.png']);
    imwrite(uint8(abs(imdelt2(:,:,n))),['.\pic1\zz',num2str(n+100),'.png']);
end


for n=1:11
    imdelt10=(imdelt1(:,:,n)>0);
    imdelt20=(imdelt2(:,:,n)>0);
    imdelt1(:,:,n)=imdelt1(:,:,n).*(imdelt1(:,:,n)>(bbvar(imdelt1(:,:,n))/(sum(imdelt10(:)))/100));
    imdelt2(:,:,n)=imdelt2(:,:,n).*(imdelt2(:,:,n)>(bbvar(imdelt2(:,:,n))/(sum(imdelt10(:)))/100));    
end


for n=1:11
    imdelt10=(imdelt1(:,:,n)>0);
    imdelt20=(imdelt2(:,:,n)>0);
    imwrite(uint8(abs(imdelt1(:,:,n))),['.\pic1\hd',num2str(n+200),'.png']);
    imwrite(uint8(abs(imdelt2(:,:,n))),['.\pic1\zz',num2str(n+300),'.png']);
end

display('finished')

















