% Ethan Lusterman
% ECE 313 Music & Engineering, Fall 2012
% Project 4: Effects
% The Cooper Union, New York, NY

% Set Paths
addpath('../wav/');

% 1 - Compressor
[hc,hcFS]=wavread('harmonyChorus');
[compd,gains]=comp(hc,hcFS,.1,0,.3);
disp('Playing Original')
soundsc(hc,hcFS)
disp('Playing Compressed Track, threshold .3, ratio 10:1 (slope .1)')
soundsc(compd,hcFS)

% plots
t=1:length(hc);
figure
subplot(2,1,1)
plot(t/hcFS,hc), hold on
plot(t/hcFS,compd,'r'), hold off
legend('origianl','compressed thr .3 slope .1')
xlabel('time (sec)'), ylabel('amplitude'), title('compressor plots')
subplot(2,1,2)
plot(t/hcFS,20*log10(gains)), legend('gains')
xlabel('time (sec)'), ylabel('gain (dB)'), title('gains')

% 2 - Ring Modulator
[dclick,dclick_fs]=wavread('deltaclick.wav');
deltaring=ringmod(dclick,1500,.7,dclick_fs);
disp('Playing Ring Mod Input')
soundsc(dclick,dclick_fs)
disp('Playing Ring Mod Out, fc=880Hz, depth=0.7')
soundsc(deltaring,dclick_fs)

% 3 - Stereo Tremolo
[pen15,fs15]=wavread('pen15');
trem=tremolo(pen15,fs15,4,.7,100,'tri');
disp('Playing Stereo Tremolo Input')
soundsc(pen15,fs15)
disp('Playing Stereo Tremolo Output, 4 Hz, 0.7 depth, 100ms lag, tri')
soundsc(trem,fs15)

% 4 - Distortion
[hc,hcFS]=wavread('harmonyChorus');
distorted=distortion(hc,11,.4,hcFS);
disp('Distortion')
disp('Playing Original Signal')
soundsc(hc,hcFS)
disp('Playing Distorted Signal, gain 11, tone .4')
soundsc(distorted,hcFS)

[lead,fs_lead]=wavread('lead');
dist2=distortion(lead,11,.4,fs_lead);
disp('Playing Another Original')
soundsc(lead,fs_lead)
disp('Playing Distorted Signal')
soundsc(dist2,fs_lead)

figure
subplot(2,2,1),plot(distortion(hc,2,.4,hcFS),'c'), legend('gain 2')
subplot(2,2,2),plot(distorted,'r'), legend('gain 11')
subplot(2,2,3),plot(distortion(hc,5,.4,hcFS),'g'), legend('gain 5')
subplot(2,2,4),plot(hc), legend('original')
xlabel('samples'), ylabel('amplitude')
title('Distorted Signals, all with tone 0.4')

% Since the Boss DS-1 is one of the main distortion pedals in production
% today and for the past 20 years or so, I decided to look into its design.
% A reverse-engineered schematic I found used a dual-opamp stage followed
% by a tone control, where the tone was a blend (via potentiometer) between
% a high pass and low pass RC filter. I wasn't positive, but to
% avoid too much mid-range scooping for tone control, I used the 
% higher cutoff frequency as the LPF cutoff and the lower cutoff 
% frequency calculated as the HPF cutoff. The wikipedia page also 
% mentioned using a LPF and a HPF to shape the tone after distortion. 
% Using 1/(2*pi*R*C), I calculated approximate values of 1200 and 265 Hz.
% For the gain stage, I multiplied the input signal by the gain before
% applying the nonlinearity. The nonlinearity I used was the error function,
% or erf(x). It is roughly linear and asymptotically approaches ±1 quickly. 
% I used a slope of 10, which I chose by testing a few values. 
% The sound is a bit tinny but not completely awful for what some
% solid-state amplifier distoritons sound like. It is also symmetric
% soft-clipping, which gives rise to odd harmonics. Even harmonics might
% make the sound a little nicer.

% DS-1 Schematic 
%   http://cdn.tonegeek.com/wp-content/uploads/Boss-DS-1-schematic.png
% Wiki Page DS-1 http://en.wikipedia.org/wiki/Boss_DS-1

% Note: I also attached a different distortion function, 'gtrdist.m', with
% the same tone section but different transfer characteristic using
% parabolas.

% 5 - Single Tap Delay
[dclick,dclick_fs]=wavread('deltaclick.wav');
delayed=digdelay(dclick,.8,1/3,.25,dclick_fs);
disp('Tempo Matched Delay')
disp('Playing Original Signal')
soundsc(dclick,dclick_fs)
disp('Playing Delayed Signal, mix .8, delay 1/3, feedback .25')
soundsc(delayed,dclick_fs)

[sweet,sweetFS]=wavread('sweetdis');
delS=digdelay(sweet,.8,3/8,.25,sweetFS);
disp('Playing Temper Trap - Sweet Disposition Clean')
soundsc(sweet,sweetFS)
disp('Playing Temper Trap - Sweet Disposition with Delay')
disp('    mix .8, delay 3/8, feedback .25')
soundsc(delS,sweetFS)

[fcp,fcpFS]=wavread('fcpremix');
del=digdelay(fcp,.4,.283,.3,fcpFS);
disp('Playing Fall of Troy - FCPREMIX Clean')
soundsc(fcp,fcpFS)
disp('Playing Fall of Troy - FCPREMIX with Delay')
disp('    mix .4, delay .283, feedback .3')
soundsc(del,fcpFS)

[lead,fs_lead]=wavread('lead');
slap=digdelay(lead,.8,.1,.2,fs_lead);
disp('Slapback Delay')
disp('Playing Original Lead')
soundsc(lead,fs_lead)
disp('Playing Slapback Lead, mix .8, delay .1, feedback .2')
soundsc(slap,fs_lead)

[mutes,mutes_fs]=wavread('mutes');
cavern=digdelay(mutes,.7,.1,.9,mutes_fs);
disp('Cavern Sound')
disp('Playing Original')
soundsc(mutes,mutes_fs)
disp('Cavern Delay, mix .7, delay .1, feedback .9')
soundsc(cavern,mutes_fs)

% Note: Had I implemented multiple taps, I could have done a short delay
% time plus a long delay time to simulate the reverb and repeat effects of
% a cave.


% 6 - Flanger
[pen15,fs15]=wavread('pen15');
flanged=flanger(pen15,.8,5,5,.4,fs15);
disp('Playing Original')
soundsc(pen15,fs15)
disp('Playing Flanged Signal, mix .8, delay 5, width 5 rate .4')
soundsc(flanged,fs15)

% 7 - Chorus
chorus=flanger(pen15,.5,30,10,.2,fs15);
disp('Playing Chorus Signal, mix .4 delay 25 width 10 rate .4')
soundsc(chorus,fs15)

[snare,fs]=wavread('snaresamp');
efxsnare=flanger(snare,.4,30,10,.2,fs);
disp('Playing Snare Clip')
soundsc(snare,fs)
disp('Playing Chorus Snare')
soundsc(efxsnare,fs)
