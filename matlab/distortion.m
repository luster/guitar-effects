function [out] = distortion(in,gain,tone,fs)
%DISTORTION simulates a distorted guitar
%   IN - guitar input vector
%   FS - sampling rate of IN
%   GAIN - how much distortion
%   TONE - 0 -> bass , 1 -> treble
%       implemented as linearly mixed BPF

% GAIN SECTION
B=in;
B=B/max(abs(B));
B=gain*B;

% NONLINEARITY - error function, which ends asymptotically at 1 and is
%                mostly linear close to values ±0
B=erf(10*B);%+.01*randn(size(B));

% TONE SECTION - 2 overlapping 1st order butterworth filters
[ZL,PL,KL]=butter(1,1200/(fs/2),'low');
[ZH,PH,KH]=butter(1,265/(fs/2),'high');
[BL,AL]=zp2tf(ZL,PL,KL);
[BH,AH]=zp2tf(ZH,PH,KH);

% OUTPUT - filtering based on position/value of tone control
out=(1-tone)*filter(BL,AL,B)+tone*filter(BH,AH,B);
%out=B;

end