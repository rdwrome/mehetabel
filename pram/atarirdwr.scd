(
SynthDef(\atari2600, {|out= 0, gate= 1, tone0= 5, tone1= 8, freq0= 10, freq1= 20, rate= 1, amp= 1, pan= 0|
    var e, z;
    e= EnvGen.kr(Env.asr(0.01, amp, 0.05), gate, doneAction:2);
    z= Atari2600.ar(tone0, tone1, freq0, freq1, 15, 15, rate);
    Out.ar(out, PanAz.ar(9, z*e, pan)); ///NUMBER OF CHANNELS HERE, RACHEL
}).add;
)
s.meter;
( ~cyborgtrash =
Pbind(
    \instrument, \atari2600,
    \dur, 0.125,
    \amp, 0.8,
    \tone0, Pseq([Pn(3, 64), Pn(2, 128), Pn(10, 8)], inf),
    \tone1, Pseq([Pn(8, 32), Pwhite(0, 15, 12)], inf),
    \freq0, Pseq([Pn(10, 17), Pn(Prand([1, 2, 3]), 4), Pn(10, 3)], inf),
    \freq1, Pseq([10, 3, Pwrand([20, 1], [0.6, 0.4])], inf),
	\pan, Pxrand([0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], inf)
).play
);
~cyborgtrash.stop;



( ~cyborgchaos =
Pbind(
    \instrument, \atari2600,
    \dur, Pseq([0.06, 0.04], inf),
    \amp, 1.2,
    \tone0, Pseq([10, 10, 10, 3], inf),
    \tone1, Pseq([3, 3, 3, 3, 10], inf),
    \freq0, Pseq([1, 2, 3], inf),
    \freq1, Pseq([10, 2, 13, 5], inf),
	\pan, Pxrand([0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], inf)
).play
);
~cyborgchaos.stop;
