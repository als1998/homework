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
          strcat('C:\Users\Zi-Heng Shen\Documents\MATLAB\BackGroundModel\混合高斯背景建模\',...
          num2str(k),'.bmp'),'bmp');
 end
 
 I = imread('1.bmp');                    %读入第一帧作为背景帧
fr_bw = I;     
[height,width] = size(fr_bw);           %求每帧图像大小
width = width/3;                        %排除颜色通道数
fg = zeros(height, width);              %定义前景和背景矩阵
bg_bw = zeros(height, width);
 
C = 3;                                  % 单高斯模型的个数(通常为3-5)
M = 3;                                  % 代表背景的模型个数
D = 2.5;                                % 偏差阈值
alpha = 0.01;                           % 学习率
sd_init = 15;                           % 初始化标准差
w = zeros(height,width,C);              % 初始化权重矩阵
mean = zeros(height,width,C);           % 像素均值
sd = zeros(height,width,C);             % 像素标准差
u_diff = zeros(height,width,C);         % 像素与某个高斯模型均值的绝对距离
p = alpha/(1/C);                        % 初始化p变量，用来更新均值和标准差
rank = zeros(1,C);                      % 各个高斯分布的优先级（w/sd)
 



