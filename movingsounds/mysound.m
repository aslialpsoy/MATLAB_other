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
