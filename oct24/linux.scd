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
);,
s.record(numChannels:2); // output
s.stopRecording;