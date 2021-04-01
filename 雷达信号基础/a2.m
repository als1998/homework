% �о�IQ�������Ե�Ƶ�ź�ƥ���˲���Ӱ��
clc,clear all,close all;
%% ����LFM
    B     =  10e6;
    f0    =  300e6;
    tao   =  10e-6;
    fs    =  10*f0;
    K     =  B/tao;
    N     =  fix(fs*tao);
    t     =  linspace(-tao/2,tao/2,N);
    LFM   =  cos(2*pi*f0*t+pi*K*t.^2);
    LFM_E =exp(1j*pi*K*t.^2);
%%  �����������
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
%% �������������
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
%     matcher = conj(fliplr(lfm)); % ƥ���˲���
%     out_st=conv(st,matcher); % ƥ���˲������
%     out_st_err=conv(st_err,matcher); % ƥ���˲������
%     
%     
%     figure
%     subplot(2,1,1);plot(t,real(st),'r',t,real(st_err));title('ʵ��');legend('����LFM','��IQ����ʵ���ź�');
%     subplot(2,1,2);plot(t,imag(st),'r',t,imag(st_err));title('�鲿');legend('����LFM','��IQ����ʵ���ź�');
%     
%     
%     F = -tao+1/fs:1/fs:tao-1/fs;
%     figure
%     plot(F,20*log10(out_st+1e-6),'r',F,20*log10(out_st_err+1e-6));
%     title('ƥ���˲���������Ƚ�,');
% %     axis([-2,2,0,40]);
%     legend('����LFM','��IQ����ʵ���ź�');
