% MORSE CODE %
clear;
close;
clc;
morse_alph = {'.-','-...','-.-.','-..','.','..-.','--.','....','..',...
              '.---','-.-','.-..','--','-.','---','.--.','--.-','.-.',...
              '...','-','..-','...-','.--','-..-','-.--','--..','/'};
          
letter={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p',...
        'q','r','s','t','u','v','w','x','y','z',' '};
%---------------------------------------------------------------------
% morse code
name= num2cell('furkan');
mor={}; % initialization 
for i=1:length(name)
      for j=1:length(letter)
        if strcmp(name(i),letter(j))==1
            mor=[mor morse_alph(j) ' '];                
        end
      end
end
mor=cell2mat(mor);
disp(mor);
%---------------------------------------------------------------------
% morse code signal
t=200;
w=0.2*pi; %frequency for T=10
dot=sin(w*(1:t));       %dit sound
dash=sin(w*(1:3*t));    %dah sound
short_p= zeros(1,t);    %pause between dot and dash
long_p= zeros(1,3*t);   %pause between letters
longer_p=zeros(1,7*t);  %pause between words
morse_sound=[];   %initialization  

for i=1:length(mor)
    if strcmp(mor(i),'.') ==1
        morse_sound=[morse_sound dot short_p];
    elseif strcmp(mor(i),'-')==1
        morse_sound=[morse_sound dash short_p];
    elseif strcmp(mor(i),' ')==1
        morse_sound=[morse_sound long_p];
    elseif strcmp(mor(i),'/')==1
        morse_sound=[morse_sound longer_p]; 
    end
end
Fs=1700; %sample frequency 
ms= audioplayer(morse_sound,Fs);
play(ms);

filename= [cell2mat(name) '.wav']; %sound file
audiowrite(filename,morse_sound,Fs); 

plot(morse_sound); %plot
xlabel('Time');
ylabel('Signal Amplitude');
title('Morse Signal vs. Time');
