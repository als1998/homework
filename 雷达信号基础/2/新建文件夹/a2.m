% 研究IQ误差对线性调频信号匹配滤波的影响
clc,clear all,close all;
%% 生成LFM
    B     =  10e6;
    f0    =  300e6;
    tao   =  10e-6;
    fs    =  10*f0;
    K     =  B/tao;
    N     =  fix(fs*tao);
    t     =  linspace(-tao/2,tao/2,N);
    LFM   =  cos(2*pi*f0*t+pi*K*t.^2);
    LFM_E =exp(1j*pi*K*t.^2);
%%  进行正交解调
    It  =  LFM.*cos(2*pi*f0*t);
    It  =  lowpass(It,f0,fs);
    
    Qt  =  LFM.*sin(2*pi*f0*t);
    Qt  =  lowpass(Qt,f0,fs);
    
    z=It+j*Qt;
    figure 
    plot(It)
    figure 
    plot(Qt)
    figure 
    plot(abs(z));

    figure 
    plot(LFM)
%     
%% 正交解调误差分析
%     A_err = 3;
%     theta_err = 0;
%     i_err = 0;
%     q_err = 0; 
%     
%     I = cos(pi*K*t.^2);
%     Q = sin(pi*K*t.^2);
%     I_err = (1+A_err)*cos(pi*K*t.^2-theta_err)+i_err;
%     Q_err = sin(pi*K*t.^2)+q_err;
%     
%     st_err = I_err+1j*Q_err;
%     st = I+j*Q;
%     lfm = exp(1j*pi*K*t.^2);
%     
%     matcher = conj(fliplr(lfm)); % 匹配滤波器
%     out_st=conv(st,matcher); % 匹配滤波的输出
%     out_st_err=conv(st_err,matcher); % 匹配滤波的输出
%     
%     
%     figure
%     subplot(2,1,1);plot(t,real(st),'r',t,real(st_err));title('实部');legend('理想LFM','含IQ误差的实际信号');
%     subplot(2,1,2);plot(t,imag(st),'r',t,imag(st_err));title('虚部');legend('理想LFM','含IQ误差的实际信号');
%     
%     
%     F = -tao+1/fs:1/fs:tao-1/fs;
%     figure
%     plot(F,20*log10(out_st+1e-6),'r',F,20*log10(out_st_err+1e-6));
%     title('匹配滤波脉冲输出比较,');
% %     axis([-2,2,0,40]);
%     legend('理想LFM','含IQ误差的实际信号');
