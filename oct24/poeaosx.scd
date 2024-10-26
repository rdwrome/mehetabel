~water=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/watergong.wav");

(
SynthDef("water", {

	arg bufnum = 0;
	var snd;

	snd=PlayBuf.ar(
		numChannels:2,
		bufnum:bufnum,
		loop: 1,
		rate:BufRateScale.kr(bufnum) * [0.3, 0.5, 0.7]
	);

	Out.ar(0,Pan2.ar(snd));
}).add;
)

~w=Synth("water",[\bufnum,~water]);
~w.free;

//

b = Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/hum.wav");

(
Ndef(\verb, {
	var input, output, delrd, sig, deltimes;
	input = Pan2.ar(PlayBuf.ar(1, b, loop: 1), -0.5);
	delrd = LocalIn.ar(4);
	output = input + delrd[[0,1]];
	sig = [output[0]+output[1], output[0]-output[1], delrd[2]+delrd[3], delrd[2]-delrd[3]];
	sig = [sig[0]+sig[2], sig[1]+sig[3], sig[0]-sig[2], sig[1]-sig[3]];
	sig = sig * [0.4, 0.37, 0.333, 0.3];
	deltimes = [101, 143, 165, 177] * 0.001 - ControlDur.ir;
	LocalOut.ar(DelayC.ar(sig, deltimes, deltimes));
	output
}).add
)

~hum = Ndef(\verb).play;
~hum.free;

//

~blessed=Buffer.read(s,thisProcess.nowExecutingPath.dirname++"/blessed.wav");

(
SynthDef("blessed", {

	arg bufnum = 0;
	var snd;

	snd=PlayBuf.ar(
		numChannels:2,
		bufnum:bufnum,
		loop: 1,
		rate:BufRateScale.kr(bufnum) * -0.8
	);

	Out.ar(0,Pan2.ar(snd));
}).add;
)

~q=Synth("blessed",[\bufnum,~blessed]);
~q.free;