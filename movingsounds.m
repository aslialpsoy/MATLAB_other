%moving random sounds%
%Aslı Alpsoy
clear;clc;close all
a=-10;b=10;  % end ranges 
p=[0 ;0; 0]; % initial position
for j=[1 2 3 4 5 6]
    c=["red" "green" "blue" "cyan" "magenta" "black"];%color codes
    %1:red 2:green 3:blue 4:cyan 5:magenta 6:black
    for i=1:5 
        grid on
        h=plot3(p(1),p(2),p(3),'o','Color',c(j),'MarkerFaceColor',c(j));
        xlim([-75 75]);ylim([-75 75]);zlim([-75 75])
        hold on
        r=a +(b-a)*rand(3,1);%random x-y-z coordinates in (a,b)
        p=p+r; %take the step 
        mysound(p(1));
        f=getframe;       
    end
end
movie(f);
function mysound(p)
s=["pianoA.mp3" "pianoB.mp3" "pianoCsharp.mp3" "pianoD.mp3" "pianoDsharp.mp3"...
    "pianoE.mp3" "pianoF.mp3" "pianoFsharp.mp3" "pianoG.mp3" "pianomiddleC.mp3"];
srev=["revpianoA.mp3" "revpianoB.mp3" "revpianoCsharp.mp3" "revpianoD.mp3"...
    "revpianoDsharp.mp3" "revpianoE.mp3" "revpianoF.mp3" "revpianoFsharp.mp3"...
    "revpianoG.mp3" "revpianomiddleC.mp3"];
p=single(p);
p=p*10^8;
% if p<0
%     p=p*(-1);
% end
if p>=0
    Pc=unique((dec2base(p,10) - '0'),'stable');    
    for k=1:10
        if ismember(k-1,Pc)
           [y, Fs] = audioread(s(k));
            sound(y, Fs);
        end
    end
else
    p=p*(-1);
    Pc=unique((dec2base(p,10) - '0'),'stable');
    for k=1:10
        if ismember(k-1,Pc)
           [y, Fs] = audioread(srev(k));
            sound(y, Fs);
        end
    end   
end
end
