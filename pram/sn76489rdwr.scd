s.meter
(
SynthDef(\sn76489, {|out= 0, gate= 1, tone0= 0, tone1= 0, tone2= 0, noise= 0, vol0= 0, vol1= 0, vol2= 0, vol3= 0, rate= 1, amp= 1, pan= 0|
    var e, z;
    e= EnvGen.kr(Env.asr(0.01, amp, 0.05), gate, doneAction:2);
    z= SN76489.ar(tone0, tone1, tone2, noise, vol0, vol1, vol2, vol3, rate);
    Out.ar(out, PanAz.ar(9, z*e, pan)); ///NUMBER OF CHANNELS HERE, RACHEL
}).add;
)

( ~prosaicbutplesant =
Pbind(
    \instrument, \sn76489,
    \dur, 0.25,
    \amp, 0.8,
    \tone0, Pseq([1000, 400, 500, 800], inf),
    \vol0, 10,
    \tone1, Pseq([200, 200, 600, 80], inf),
    \vol1, Pseq([Pn(0, 16), Pn(7, 16)], inf),
    \tone2, Pseq([300, 1000, 400, 1000], inf),
    \vol2, Pseq([Pn(0, 32), Pn(5, 32)], inf),
    \noise, Pseq([3, 4, 5, 6], inf),
    \vol3, Pseq([Pn(0, 64), Pn(7, 64)], inf),
	\pan, Pxrand([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], inf)
).play
)
~prosaicbutplesant.stop;

( ~stardust =
Pbind(
    \instrument, \sn76489,
    \dur, Pseq([0.12, 0.08], inf),
    \amp, 0.8,
    \rate, Pseq([Pn(1, 32), Pn(0.9, 32)], inf)*Pseq([Pn(1, 128), Pn(0.5, 128)], inf),
    \tone0, Pseq([10, 10, 10, 3], inf),
    \tone1, Pseq([300, 300, 300, 300, 1000], inf),
    \tone2, Pseq([10, 2, 13, 5], inf),
    \noise, Pseq([1, 2, 3], inf),
    \vol0, Pseq([Pn(10, 10), 0, 0], inf),
    \vol1, Pseq([Pn(10, 12), 0, 0], inf),
    \vol2, Pseq([Pn(10, 14), 0, 0], inf),
    \vol3, Pseq([Pn(10, 16), 0, 0], inf),
	\pan, Pxrand([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], inf)
).play
)
~stardust.stop

( ~twinkling =
Pbind(
    \instrument, \sn76489,
    \dur, Pbrown(0.1, 0.15, 0.1),
    \amp, 1,
    \tone0, 100,
    \tone1, Pseq([Pstutter(16, Pseq([200, 220])), Prand([22, 33, 44])], inf),
    \tone2, 300,
    \vol0, Pseq([9, 9, Pwrand([12, 7], [0.4, 0.6])], inf),
    \vol1, Pseq([1, 3, Pwrand([2, 1], [0.4, 0.6])], inf),
    \vol2, Pseq([2, 1, Pwrand([3, 1], [0.4, 0.6])], inf),
	\pan, Pxrand([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], inf)
).play
)
~twinkling.stop;

( ~alarm =
Pbind(
    \instrument, \sn76489,
    \dur, 0.1,
    \amp, 1,
    \legato, 1.5,
    \tone0, 20,
    \tone1, Pseq([Pn(2, 80), Pn(3, 80), Pn(4, 80), Pn(0, 40)], inf)*20,
    \tone2, Pseq([Pseries(40, 0.1, 30)], inf)*Pseq([Pn(1, 80), Pn(8, 80)], inf),
    \noise, Pseq([Pseries(1, 0.05, 100)], inf),
    \rate, Pseq([Pseries(0.25, 1, 20)], inf),
    \vol0, 10,
    \vol1, 10,
    \vol2, 4,
    \vol3, 2,
	\pan, Pxrand([0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1], inf)
).play
)
~alarm.stop;

