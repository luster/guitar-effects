# Guitar Effects in MATLAB
ECE313 Music & Engineering, Fall 2012

The Cooper Union, New York, NY

The purpose of this project was to simulate different kinds of guitar effects in MATLAB. I recorded some sample guitar riffs using a Digidesign MBox & Audacity software in order to test the effects. The effects I coded in particular were:
* Compressor
* Digital Delay
* Distortion
* Stereo Tremolo
* Ring Modulator
* Flanger
* Chorus

Of these effects, distortion's design requirements were freer, since you have to consider what 
nonlinearity to apply to your signal and the specific tone stack (the tone knob). 
The Boss DS-1 is a popular distortion pedal, known for using a potentiometer blended high pass 
and low pass filter, so I attempted to model that using simple first-order overlapping Butterworth filters 
in MATLAB. The nonlinearity I decided to apply was erf(.) (the error function). It is a smooth, odd 
function that gives rise to odd harmonics and softer clipping. 

Overall the distortion is organized as follows:
* Normalize signal to (±1)
* Apply gain (distortion knob)
* Apply nonlinearity (this is built into the circuitry in hardware, typically an op amp, diodes, and/or transistors)
* Shape signal with tone section

To run the code, simply run hw4script.m in MATLAB in the matlab folder.
