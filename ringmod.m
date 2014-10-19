function [ out ] = ringmod( in, freq, depth, fs )
%RINGMOD ring modulates input signal at specified frequency and depth
% in is input signal
% modfreq is frequency of the ring mod
% depth ranges 0 (no ringmod added) to 1 (equal amplitude added)
% fs is sampling freq of input signal

dbstop if error

n = (1:length(in))';
wave = depth*sin(2*pi*freq/fs .*n);
modulated = wave.*in;

out = in + modulated;

end