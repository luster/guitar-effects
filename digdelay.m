function [out]=digdelay(in,depth,delay,feedback,fs)
%DIGDELAY simulates a digital delay guitar effects box
%   IN - input guitar audio vector
%   DEPTH - 0 (no delay sig added) to 1 (equal amplitude delay signal)
%   DELAY - delay time from 0.1 msec (0.0001 sec) to 8 sec (in seconds)
%   FEEDBACK - feedback gain - amplitude of delayed signal to be fedback

dbstop if error

sampleDelay = ceil(delay*fs); % delay in sec * samp/sec = samples
delayedSignal = [zeros(sampleDelay,1);in(1:end);zeros(64*fs-sampleDelay,1)];
% first delay by padding beginning with proper # zeros
% then zero pad the end of the delayed signal for the rest of the delays
% that come from feedback
% below, in is also padded with the same # zeros to handle longer delay
% times
in=[in;zeros(64*fs,1)];

n=1; %iterator variable for # delays
while feedback >= 0.0001 %going to continually decrease feedback inside loop
    delayedSignal=delayedSignal+...
        feedback*[zeros(sampleDelay*n,1);...
        delayedSignal(1:end-sampleDelay*n)];
    feedback=feedback^2;
    n=n+1;
end

out = in + depth*delayedSignal;

% removing excess zeros from the end
content = find(out,1,'last');
out=out(1:content);

end