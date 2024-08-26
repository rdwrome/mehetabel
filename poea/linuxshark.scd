//JACK HAS TO BE RUNNING WITH INTERFACE SELECTED BEFORE BOOT, RACHEL
(
s.options.numBuffers = 1024 * 256;
s.options.memSize = 8192 * 32;
s.options.maxNodes = 1024 * 32;
s.options.numOutputBusChannels = 2; // output
s.options.numInputBusChannels = 2;

s.waitForBoot {
    ~dirt = SuperDirt(2, s); // output
	~dirt.loadSoundFiles;
    ~dirt.loadSoundFiles("~/Desktop/mehetabel/Dirt/samples/**");
    s.sync;
    ~dirt.start(57120, 0 ! 12);
};
);
s.record(numChannels:2); // output
s.stopRecording;

(
SynthDef('shark', { |out,
    amps (#[0.03, 0.3, 0.6, 1.2])|
	var freqs, env, signal;
	freqs = Array.fill(4, Pxrand([156, 308, 352, 436, 592, 736], inf
	).iter);
	env = Env.sine(30, 1);
    signal = DynKlank.ar(`[freqs, amps], PinkNoise.ar([0.007,0.007]));
	Out.ar(out, signal*EnvGen.kr(env, doneAction: Done.freeSelf));
}).add;
)

a = Synth('shark');
a.free;

//shark01:9; shark02:4; shark03:1; sr01:6

b = Buffer.read(s, '/home/rd/Desktop/giants/poea/hum.wav');

(
Ndef(\verb, {
	var input, output, delrd, sig, deltimes;
	input = Pan2.ar(PlayBuf.ar(1, b, loop: 0), -0.5);
	delrd = LocalIn.ar(4);
	output = input + delrd[[0,1]];
	sig = [output[0]+output[1], output[0]-output[1], delrd[2]+delrd[3], delrd[2]-delrd[3]];
	sig = [sig[0]+sig[2], sig[1]+sig[3], sig[0]-sig[2], sig[1]-sig[3]];
	sig = sig * [0.4, 0.37, 0.333, 0.3];
	deltimes = [101, 143, 165, 177] * 0.001 - ControlDur.ir;
	LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));
	output
}).play
)

Ndef(\verb).free;

s.meter;
