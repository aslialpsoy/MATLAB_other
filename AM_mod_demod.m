% Conventional AM Modulator and Demodulator %
% Aslı Alpsoy %
clear; clc; close all
%% Inputs
% two-tone message signal
fs_m=100e3;  %sampling rate 
t_d=50e-3;   %duration
A_m=0.1;     %amplitude of the message, same for the both tones
fm_1=1650;   %first tone frequency
fm_2=2200;   %second tone frequency
% carrier signal
fs=100e3;    %sampling rate
fc=20e3;     %carrier frequency
m=0.5;      %modulation index
A_c=A_m/m;  %carrier amplitude
fpass=10e3;  %pass-band frequency
t=0:(1/fs_m):t_d; %time vector
%% Baseband Signal Generation
signal1=A_m*sin(2*pi*fm_1*t); 
signal2=A_m*sin(2*pi*fm_2*t);
signal=signal1+signal2;
signal_freq=fftshift(abs(fft(signal)/length(signal)));
% sound(signal,fs_m);
%% Modulation
y=(A_c+ signal).*sin(2*pi*fc*t); %modulated signal
y_freq=fftshift(abs(fft(y)/length(y)));
freqvector=linspace(-fs/2,fs/2,length(y_freq)); %frequency vector

%% Demodulation with envelope detector
%Series diode, eliminating negative values
y_pos=y.*(y>0);
%Series capacitor
y_pos=y_pos-mean(y_pos);
%Envelope detector, low pass filter
y_demod=pi*lowpass(y_pos,fpass,fs);
y_demod_freq=fftshift(abs(fft(y_demod)/length(y_demod)));
%% Figures
figure;
subplot(3,1,1)
plot(t,y,'r'); hold on; plot(t,signal,'k','LineWidth',1.2);
ylabel('Amplitude'); xlabel('Time(s)');
title('Baseband Signal and Modulated Signal vs Time')
legend('Amplitude Modulated Signal','Baseband Signal');
subplot(3,1,2)
plot(freqvector*1e-3,signal_freq,'k');
ylabel('Amplitude'); xlabel('Frequency(kHz)');
title('Frequency Spectrum of Baseband Signal')
subplot(3,1,3)
plot(freqvector*1e-3,y_freq,'r');
ylabel('Amplitude'); xlabel('Frequency(kHz)');
title('Frequency Spectrum of Amplitude Modulated Signal');

figure;
subplot(3,1,1)
plot(t,signal,'k','LineWidth',1.2);hold on; plot(t,y_demod,'m');
ylabel('Amplitude'); xlabel('Time(s)');
title('Baseband Signal and Demodulated Signal vs Time')
legend('Baseband Signal','Demodulated Signal');
subplot(3,1,2)
plot(freqvector*1e-3,signal_freq,'k');
ylabel('Amplitude'); xlabel('Frequency(kHz)');
title('Frequency Spectrum of Baseband Signal');
subplot(3,1,3)
plot(freqvector*1e-3,y_demod_freq,'m');
ylabel('Amplitude'); xlabel('Frequency(kHz)');
title('Frequency Spectrum of Demodulated Signal');

