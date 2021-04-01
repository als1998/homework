function [LFM,K,N,t]=SetLFM(B,tao,fs)
    K = B/tao;
    N   =  fix(fs*tao);
    t   =  linspace(-tao/2,tao/2,N);
    LFM = exp(1j*pi*K*(t.^2));
end