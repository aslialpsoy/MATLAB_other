%% morse code your name %%
clear;close all;clc;
%% morse alphabet
morse= struct;
morse.a='.-';
morse.b='-...';
morse.c='-.-.';
morse.d='-..';
morse.e='.';
morse.f='..-.';
morse.g='--.';
morse.h='....';
morse.i='..';
morse.j='.---';
morse.k='-.-';
morse.l='-...';
morse.m='--';
morse.n='-.';
morse.o='---';
morse.p='.--.';
morse.r='.-.';
morse.s='...';
morse.t='-';
morse.u='..-';
morse.v='...-';
morse.y='-.--';
morse.z='--..';
save 'data.mat' 'morse'
%% enter your name and get the morse code
text= input('Enter your name (use only English characters): ', 's');
text= lower(text); % morse code is not case sensitive
N= length(text); % number of letters
mors=[]; % initialization of morse code
for i=1:N
    if text(i)==' ' %if there are spaces in the text i.e. multiple words
         mors=[mors '/'];
    else
         mors=[mors getfield(morse,text(i))]; %#ok<*AGROW> %finding the morse code
         mors=[mors ' '];
    end
end
disp(['morse code:' mors]);
%% obtain sounds of the morse code
w=0.4*pi; %angular frequency (T=5, f=1/5, w=f*2*pi)
dit=sin(w*(1:150)); % for dot
dah=sin(w*(1:450)); % for dash
sp= zeros(1,150);   %short pause between dit and dah
lp= zeros(1,450);   %long pause between letters
llp=zeros(1,700);   %longer pause between words
msound=[];   %initialization of the morse sound 
K=length(mors);% length of the morse code
for i=1:K
    if strcmp(mors(i),'.') 
        msound=[msound dit sp];
    elseif strcmp(mors(i),'-')
        msound=[msound dah sp];
    elseif strcmp(mors(i),' ')
        msound=[msound lp];
    elseif strcmp(mors(i),'/')
        msound=[msound llp]; 
    end
end
fs=1600; %sampling frequency
pp= audioplayer(msound,fs);
play(pp);
%% obtain the plots and the sound file 
%plot
plot(msound);
xlabel('Mors Scheme Constructed Signal');
ylabel('Amplitude');
title('Signal vs Time');
%sound file
filename= [text '.wav'];
audiowrite(filename,msound,fs);