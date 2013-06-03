Guitar Effects in MATLAB
Music & Engineering, Fall 2012

The purpose of this project was to simulate different kinds of guitar effects in MATLAB. I recorded some sample guitar riffs using a Digidesign MBox & Audacity software in order to test the effects. The effects I coded in particular were:
Compressor
Digital Delay
Distortion
Stereo Tremolo
Ring Modulator
Flanger
Chorus

Of these effects, the only one that needed a design was the distortion, since you have to figure out what nonlinearity to apply to your signal and the specific tone stack (the tone knob). The Boss DS-1 is a popular distortion pedal, known for using a potentiometer blended high pass and low pass filter, so I attempted to model that using simple first-order overlapping Butterworth filters in MATLAB. The nonlinearity I decided to apply was erf(.) (the error function). It is a smooth, odd function that gives rise to odd harmonics and softer clipping. Overall the basic idea of distortion is:
Normalize signal to (±1) and apply gain (distortion knob)
Apply nonlinearity (this is built into the circuitry in practice, typically an op amp, diodes, and/or transistors)
Shape signal with tone section
