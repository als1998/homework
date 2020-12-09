%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Author: Ziheng H. Shen @Tsinghua Univ.
%HybridGaussModel @Digital Image Process Practice
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all; 
cntFrame = 23;
obj = VideoReader('768x576.avi');
numFrames = obj.NumberOfFrames;
 for k = 1 : cntFrame
     frame = read(obj,k);
      imwrite(frame,...
          strcat('C:\Users\Zi-Heng Shen\Documents\MATLAB\BackGroundModel\��ϸ�˹������ģ\',...
          num2str(k),'.bmp'),'bmp');
 end
 
 I = imread('1.bmp');                    %�����һ֡��Ϊ����֡
fr_bw = I;     
[height,width] = size(fr_bw);           %��ÿ֡ͼ���С
width = width/3;                        %�ų���ɫͨ����
fg = zeros(height, width);              %����ǰ���ͱ�������
bg_bw = zeros(height, width);
 
C = 3;                                  % ����˹ģ�͵ĸ���(ͨ��Ϊ3-5)
M = 3;                                  % ��������ģ�͸���
D = 2.5;                                % ƫ����ֵ
alpha = 0.01;                           % ѧϰ��
sd_init = 15;                           % ��ʼ����׼��
w = zeros(height,width,C);              % ��ʼ��Ȩ�ؾ���
mean = zeros(height,width,C);           % ���ؾ�ֵ
sd = zeros(height,width,C);             % ���ر�׼��
u_diff = zeros(height,width,C);         % ������ĳ����˹ģ�;�ֵ�ľ��Ծ���
p = alpha/(1/C);                        % ��ʼ��p�������������¾�ֵ�ͱ�׼��
rank = zeros(1,C);                      % ������˹�ֲ������ȼ���w/sd)
 



