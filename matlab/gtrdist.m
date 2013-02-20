function [out]=gtrdist(in,gain,tone,fs)
%GTRDIST simulates a guitar distortion stompbox
%   IN - input guitar audio column vector
%   GAIN - amount of gain before nonlinearity 0-11
%   TONE - 0 for bassy, 1 for trebly (one pole BPF)

dbstop if error

% GAIN BEFORE NONLINEARITY
b=in;
b=b/max(abs(b));
b=gain*b;

% NONLINEARITY
i=(b>=0.75); b(i)=1;  % hard clipping on +ve edge
i=(b<=-2/3); b(i)=-1; % hard clipping on -ve edge

% linear region left alone between -1/3 and 1/2
% parabola to connect linear and saturated regions

% parabola coefficients soft clipping on +ve edge
c1=4*sqrt(2); c2=3*sqrt(2);
i=(b>=0.5 & b<=0.75);
b(i)=(4-(c2-c1*b(i)).^2)./4;

% parabola coefficients soft clipping on -ve edge
c2=4-sqrt(6); c1=6-3*sqrt(6);
i=(b<=-1/3 & b>=-2/3);
b(i)=(3-(c2+c1*b(i)).^2)./3;

% TONE SECTION - 2 overlapping, mixed 1st order butterworth filters
[ZL,PL,KL]=butter(1,1200/(fs/2),'low');
[ZH,PH,KH]=butter(1,265/(fs/2),'high');
[BL,AL]=zp2tf(ZL,PL,KL);
[BH,AH]=zp2tf(ZH,PH,KH);

out=(1-tone)*filter(BL,AL,b)+tone*filter(BH,AH,b);

end