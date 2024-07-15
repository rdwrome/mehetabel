//dependencies: redFrik

(
c.stop;
d.stop;
e.stop;
f.stop;
g.stop;
h.free;
i.free;
)

(
SynthDef(\sid6581f, {|out= 0, gate= 1, freqLo= 0, freqHi= 0, pwLo= 0, pwHi= 0, ctrl= 65, atkDcy= 5, susRel= 5, fcLo= 0, fcHi= 0, res= 0, mode= 15, rate= 1, amp= 1, pan= 0|
    var e, z;
    e= EnvGen.kr(Env.asr(0.01, amp, 0.05), gate, doneAction:2);
    z= SID6581f.ar(
        freqLo, freqHi, pwLo, pwHi,
        ctrl, atkDcy, susRel,
        0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0,
        fcLo, fcHi,
        res, mode, rate
    );
    Out.ar(out, Pan2.ar(z*e, pan));
}).add;
);
(
SynthDef(\pokeySquare, {|out= 0, gate= 1, f1= 0, c1= 0, v1= 15, f2= 0, c2= 0, v2= 15, f3= 0, c3= 0, v3= 15, f4= 0, c4= 0, v4= 15, ctl= 0, amp= 1, pan= 0|
    var e, z;
    e= EnvGen.kr(Env.asr(0.01, amp, 0.05), gate, doneAction:2);
    z= PokeySquare.ar(f1, c1, v1, f2, c2, v2, f3, c3, v3, f4, c4, v4, ctl);
    Out.ar(out, Pan2.ar(z*e, pan));
}).add;
);
(
SynthDef(\ay8910square, {|out= 0, gate= 1, freq= 100, noise= 15, ctrl= 0, vol= 15, envRate= 200, envShape= 14, rate= 1, amp= 1, pan= 0|
    var e, z;
    e= EnvGen.kr(Env.asr(0.01, amp, 0.05), gate, doneAction:2);
    z= AY8910Square.ar(freq, noise, ctrl, vol, envRate, envShape, rate)[0];
    Out.ar(out, Pan2.ar(z*e, pan));
}).add;
)

//trashcan beat
( c =
Pbind(
    \instrument, \sid6581f,
    \dur, Pseq([0.1, 0.15], inf),
    \amp, Pseq([0.5, 0.25], inf),
    \ctrl, 2r10000001,
    \freqHi, Pseq([0, 24, 24, Pwrand([200, 230], [0.6, 0.4])], inf)
).play
)
c.stop;

//bubble glitch evolving sequence
( d =
Pbind(
    \instrument, \sid6581f,
    \dur, Pseq([0.03, 0.02], inf),
    \ctrl, Pseq([2r00110101, 2r00010101], inf),
    \amp, Pseq([1, 0.5], inf),
    \pwHi, Pn(Pseries(0, 0.01, 25400), inf),
    \atkDcy, Pn(Pseries(0, 0.005, 51000), inf),
    \susRel, Pn(Pseries(0, 0.004, 63750), inf),
    \freqLo, 32,
    \freqHi, Pseq([Pseq([3, 30, 3, 3, 10, 3], 4), Pseq([1, 20, 3, 4], 3), Pseq([10, 10, 10, 30], 2)], inf)*Pseq([Pn(1, 256), Pn(0.75, 128), Pn(1, 256), Pn(0.5, 128)], inf).midicps
).play
)
d.stop;

//noisy morse code short sequence
( e =
Pbind(
    \instrument, \pokeySquare,
    \dur, Pseq([Pn(0.1, 10), Pn(0.05, 12)], inf),
    \amp, 0.8,
    \ctl, 0,
    \f1, Pseq([100, 90, 120], inf),
    \c1, Pseq([7, 7, 7, 7, 6, 6, 7, 7], inf),
    \v1, Pseq([15, 0, 0, 0, 15, 0, 15, 0], inf),
    \f2, Pseq([Pn(180, 64-8), Pshuf([20, 22, 26, 28], 2)], inf),
    \c2, 3,
    \v2, Pseq([10, 0, 10, 0, 10, 0, 10, 0], inf),
    \f3, 11,
    \c3, 6,
    \v3, Pseq([Pseries(0, 0.05, 128)], inf)*Pseq([0, 1, 0.1, 1], inf),
    \f4, 31,
    \c4, 5,
    \v4, Pseq([Pn(0, 64), Pseq([Pseries(0, 0.1, 128)], inf)*Pseq([1, 0.1, 1, 0], inf)])
).play
)
e.stop;


// percussive beat
( f =
Pbind(
    \instrument, \ay8910square,
    \dur, Pseq([Pn(0.1, 12), Pn(0.05, 12)], inf),
    \amp, 1.2,
    \freq, Pseq([100, 90, 120, 400], inf),
    \ctrl, Pseq([6, 6, 6, 6, 5, 5, 6, 6], inf),
    \vol, Pseq([15, 0, 10, 0, 15, 0, 15, 0], inf),
    \envRate, Pseq([Pn(100, 64), Pshuf([200, 250, 300, 350], 8)], inf),
    \envShape, 9
).play
)
f.stop;

// EVOLVES SO NICELY ON iTS OWN, sounds great with r2d2
( g =
Pbind(
    \instrument, \ay8910square,
    \dur, 0.1,
    \amp, 0.1,
    \legato, 1.15,
    \freq, Pseq([15, 18, 15, 18, 15, 18, 15, 18, 15, 18, 15, 18, 72, 18, 15, 18], inf),
    \vol, Pseq([15, 15, 0, 0, 15, 0, 15, 0, 8, 8, 0, 0, 8, 0, 0, 15], inf),
    \envRate, Pseq([Pn(0, 32), Pn(255, 64), Pseq([0, 255, 255, 0, 25, 255, 0, 25, Pseries(8, -1, 8)], inf)]),
    \ctrl, Pseq([Pn(2, 12), Pn(6, 6), Pn(2, 4)], inf)
).play
)
g.stop;

//babbling R2D2
(
h = {	|period=0|
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
	sig = sig!2 * 0.12;
}.play;
)
h.free;

// n76489 MOUSEY GOODNESS IN ITS OWN PLAY FUNCTION

(i ={SN76489.ar(MouseX.kr(0, 1023), SinOsc.kr([0.35, 0.45], 0, 7.5, 7.5), 100, MouseY.kr(0, 7).round-[0, 7], SinOsc.kr(0.3, 0, 5.5, 5.5), 5, 2, 3)}.play);
i.free;

(
c.stop;
d.stop;
e.stop;
f.stop;
g.stop;
h.free;
i.free;
)
