(
SynthDef(\mzpokey, {|out= 0, gate= 1, f1= 0, c1= 0, f2= 0, c2= 0, f3= 0, c3= 0, f4= 0, c4= 0, ctl= 0, amp= 1, pan= 0|
    var e, z;
    e= EnvGen.kr(Env.asr(0.01, amp, 0.05), gate, doneAction:2);
    z= MZPokey.ar(f1, c1, f2, c2, f3, c3, f4, c4, ctl);
    Out.ar(out, PanAz.ar(9, z*e, pan)); ///NUMBER OF CHANNELS HERE, RACHEL
}).add;
)
​
( ~unhingedjingle =
Pbind(
    \instrument, \mzpokey,
    \dur, 0.125,
    \amp, 1.4,
    \ctl, Pseq([2r10000001, 2r01000001, 2r00100000], inf),
    \f1, Pseq([Pn(88, 8), Pseq([120, 130, 140, 50], 4)], inf)+Pseq([Pn(0, 72), Pn(-10, 36)], inf),
    \c1, 2r10101111,
    \f2, Pseq([0, 255, 255, 0, 25, 255, 0, 25, Pn(13, 11)], inf),
    \c2, Pseq([2r10101111, 2r00100111], inf),
	\pan, Pxrand([0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], inf)
).play
)
~unhingedjingle.stop;​
​
( ~longindustrialseq =
Pbind(
    \instrument, \mzpokey,
    \dur, 0.1,
    \amp, 1.2,
    \legato, 1.25,
    \ctl, 2r10000000,
    \f1, Pseq([5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 5, 6, 140, 6, 5, 6], inf),
    \c1, Pseq([2r10000000], inf)|Pseq([15, 15, 0, 0, 15, 0, 15, 0, 8, 8, 0, 0, 8, 0, 0, 15+64], inf),
    \f2, Pseq([Pn(0, 32), Pn(255, 64), Pseq([0, 255, 255, 0, 25, 255, 0, 25, Pseries(8, -1, 8)], inf)]),
    \c2, Pseq([Pseq([2r10101111, 2r10101000], inf)], inf),
    \f3, Pseq([Pn(32, 15), Prand([33, 35])], inf),
    \c3, Pseq([Pn(0, 64), Pn(2r01101000, 32), Pn(2r11101100, 32)], inf),
    \f4, Pseq([0, 0, 100, 155], inf),
    \c4, Pseq([Pn(0, 128), Pseq([Pn(2r11001100, 7), 0], 128)], inf),
	\pan, Pxrand([0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9], inf)
).play
)
~longindustrialseq.stop;
