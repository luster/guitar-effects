function [ out ] = tremolo( in, fs, rate, depth, lag, LFO )
%TREMOLO simulates a guitar tremolo stomp box
%   IN - input guitar vector
%   FS - sampling rate of IN
%   RATE - frequency of LFO
%   DEPTH - amplitude of modulating LFO
%   LAG - stereo lag in msec
%   LFO - low frequency oscillator - sin, tri, or squ

dbstop if error

% depth 0 to 1 (amplitude 0 to 1)
% rate 0.05 to 5 Hz

lagSamples=ceil(lag/1000*fs); %converts ms of lag to # samples

n = (1:length(in))';
argWaveLeft = 2*pi*rate/fs * n;
argWaveRight = 2*pi*rate/fs * (n+lagSamples);
% delay implemented as phase difference of the right channel with respect
% to the left

switch LFO
    case{'squ','square'}
        wave_left = depth*square(argWaveLeft);
        wave_right = depth*square(argWaveRight);
    case{'tri','triangle'}
        wave_left = depth*sawtooth(argWaveLeft,.5);
        wave_right = depth*sawtooth(argWaveRight,.5);
    case{'sin','sine'}
        wave_left = depth*sin(argWaveLeft);
        wave_right = depth*sin(argWaveRight);
end

left = in.*(1+wave_left);
right = in.*(1+wave_right);
out=[left,right]; % creating a stereo output

end