function [out] = flanger(in,mix,delay,width,rate,fs)
%FLANGER simulates a guitar flanger effect pedal
%   IN - input vector
%   MIX - depth - amt of delayed signal added to IN (0 to 1)
%   DELAY - min delay time - 100usec to 10msec (in msec) 0.1 to 10
%   WIDTH - sweep depth - how wide sweep is (100nsec to 10msec) 
%           (in msec, 0.0001)
%   RATE - frequency of LFO - 0.05 to 5 Hz

in=interp1(1:length(in),in,1:.25:length(in));
fsn=fs*4;

minDelaySamp=ceil(delay*fsn/1000); %convert to msec, then samples
maxDelaySamp=ceil((delay+width)*fsn/1000); %convert to msec, then samples
n=(1:length(in)+maxDelaySamp)'; %how long to extend in by for LFO
LFO=sawtooth(2*pi*rate/(fsn)*n,.5); %sawtooth more commonly used in flangers
delayTimeSamples=(delay+width/2+width/2*LFO)*fsn/1000; 
% instantaneous delay in samples (computed by looking at graph from class
% PDF)

out=zeros(length(in)+minDelaySamp,1); %initialized output vec

out(1:maxDelaySamp)=in(1:maxDelaySamp); 
% copy front of signal before min delay

for i=maxDelaySamp+1:length(in) % starting from next sample
    delaySamples=ceil(delayTimeSamples(i)); %whole number of current delay
    out(i)=in(i)+mix*out(i-delaySamples); %add input and fraction of delay 
end

out=downsample(out,4);

end