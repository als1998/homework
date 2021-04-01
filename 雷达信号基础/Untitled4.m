y1=cos(pi*K*t.^2);
y2=sin(pi*K*t.^2);
z=abs(y1+1j*y2);

plot(fftshift(abs(fft(It)))); hold on

plot(fftshift(abs(fft(y1)))+11);
figure
plot(abs(z))