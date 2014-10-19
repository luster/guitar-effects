function [out,gains]=comp(in,fs,slope,avglen,thr)
%COMP simulates an audio compression effect
%   IN - input audio vector
%   THR - threshold - default to 0.5 - range 0 to 1
%   SLOPE - should be less than 1 to apply to values above threshold THR
%   AVGLEN - average length - # samples to use for power calculation
%           this affects the attack/release times of the compressor

dbstop if error

in=in/max(abs(in));

if nargin < 5
    thr=0.5;
end

out=in;
pos=(in>thr);
neg=(in<-thr);
out(pos)=slope*(in(pos)-thr)+thr;
out(neg)=slope*(in(neg)+thr)-thr;

gains=ones(size(out));
gains(pos)=out(pos)./in(pos);
gains(neg)=out(neg)./in(neg);

fs;
avglen;

% not implemented using exponentials or avglen value
% gives rise to some distortion, but is kind of like a compressor

end