//dependencies: redFrik extensions
s.meter
MIDIClient.init;
~midiOut = MIDIOut.newByName("Scarlett 18i20 USB", "Scarlett 18i20 USB");

///as many analog outs as interface PLUS ONE!!!

(
s.options.numBuffers = 1024 * 256;
s.options.memSize = 8192 * 32;
s.options.maxNodes = 1024 * 32;
s.options.numOutputBusChannels = 9; // total number of output channels
s.options.numInputBusChannels = 9;

s.waitForBoot {
    ~dirt = SuperDirt(9, s); // total number of output channels
	~dirt.loadSoundFiles;
    ~dirt.loadSoundFiles("/Users/rrome/Documents/GitHub/mehetabel/Dirt/samples**");
	~dirt.soundLibrary.addMIDI(\mydevice, ~midiOut);
    s.sync;
    ~dirt.start(57120, 0 ! 16);
};
);

s.record(numChannels:2); // output channels again
s.stopRecording;

~lc = LinkClock.new.latency_(Server.default.latency);
~lc.numPeers; '0 means no connection, 1 means connection
~ltmc = LinkToMidiClock(~midiOut, ~lc);
~ltmc.start;
~ltmc.stop;

(
SynthDef(\ay8910square, {|out= 0, gate= 1, freq= 100, noise= 15, ctrl= 0, vol= 15, envRate= 200, envShape= 14, rate= 1, amp= 1, pan= 0|
    var e, z;
    e= EnvGen.kr(Env.asr(0.01, amp, 0.05), gate, doneAction:2);
    z= AY8910Square.ar(freq, noise, ctrl, vol, envRate, envShape, rate)[0];
    Out.ar(out, PanAz.ar(9, z*e, pan)); ///NUMBER OF CHANNELS HERE, RACHEL
}).add;
)

( ~cpo =
Pbind(
    \instrument, \ay8910square,
    \dur, 0.1,
    \amp, 0.1,
    \legato, 1.15,
    \freq, Pseq([15, 18, 15, 18, 15, 18, 15, 18, 15, 18, 15, 18, 72, 18, 15, 18], inf),
    \vol, Pseq([15, 15, 0, 0, 15, 0, 15, 0, 8, 8, 0, 0, 8, 0, 0, 15], inf),
    \envRate, Pseq([Pn(0, 32), Pn(255, 64), Pseq([0, 255, 255, 0, 25, 255, 0, 25, Pseries(8, -1, 8)], inf)]),
    \ctrl, Pseq([Pn(2, 12), Pn(6, 6), Pn(2, 4)], inf),
	\pan, Pxrand([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], inf)
).play
)
~cpo.stop;

//R2D2
(
w = {	|period=0|
	var change, rate, sig, carrierFreq, cfRamp, carrierLvl, clRamp,
	modulatorRatio, mrRamp, modulatorIndex, miRamp, outputAmplitude, oaRamp;

	period = period * 600 + 100;

	change = Impulse.kr(LocalIn.kr(1,10));
	rate = CoinGate.kr(1/3, change);
	rate = (TChoose.kr(rate, period/((0..1) + 1))/1000).reciprocal;
	LocalOut.kr(rate);

	# carrierFreq, cfRamp = TIRand.kr(0, [1000, 1], change);
	carrierFreq = Ramp.kr( carrierFreq / 1000, (cfRamp * period) / 1000 ) * 0.6;

	# carrierLvl, clRamp = TIRand.kr(0, [9000, 1], CoinGate.kr(1/3, change));
	carrierLvl = Ramp.kr( carrierLvl, (clRamp * period) / 1000) + 100;

	# modulatorRatio, mrRamp = TIRand.kr([800,1], CoinGate.kr(1/4, change));
	modulatorRatio = Ramp.kr(modulatorRatio, (mrRamp * period) / 1000) + 20;

	# modulatorIndex, miRamp = TIRand.kr(0, [100, 1], CoinGate.kr(1/4, change));
	modulatorIndex = Ramp.kr(modulatorIndex / 200, (miRamp * period) / 1000) + 0.2;

	# outputAmplitude, oaRamp = TIRand.kr(0!2, 1!2, CoinGate.kr(1/2, change));
	outputAmplitude = Ramp.kr(outputAmplitude, (oaRamp * period + 3) / 1000);

	sig = LFSaw.ar(carrierFreq, 1, 0.5, 0.5) * carrierLvl;
	sig = sig + SinOsc.ar(carrierFreq * modulatorRatio) * modulatorIndex;
	sig = cos(sig * 2pi) * outputAmplitude;

	sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
	sig = OnePole.ar(sig, exp(-2pi * (10000 * SampleDur.ir)));
	sig = (sig - OnePole.ar(sig, exp(-2pi * (100 * SampleDur.ir))));
	sig = (sig - OnePole.ar(sig, exp(-2pi * (100 * SampleDur.ir))));
	sig = sig!2 * 0.06;
	Out.ar(0, Mix.ar(PanAz.ar(9, sig))); /// NUM OF CHANNELS RACHEL
}.play;
)

// period controls the talk-speed. range: 0-1. 0 matches to fast, 1 to slow:
w.set(\period, 1);
w.set(\period, 0);
w.set(\period, 0.5);
w.set(\period, 0.7);
w.set(\period, 0.3);

// To stop:
w.free;