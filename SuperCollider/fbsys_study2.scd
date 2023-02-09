(
Server.local.options.numInputBusChannels_(2);
Server.local.options.numOutputBusChannels_(2);
Server.local.options.hardwareBufferSize_(64);
Server.local.options.memSize_(65536 * 16);
s.boot;
)

(
b = Buffer.alloc(s, s.sampleRate * 20);
b.write("~/src/pies/complexity/study2audio/fb_10.wav".standardizePath, "wav", "int16", 0, 0, true);
)

~notes = {70.rand}!6
~notes = [68, 66, 5, 5, 43, 13]
(
Ndef(\fb1, {
	var w;
	var wfb, mfccs, vib, comx,gain, thresh, env, gate;
	wfb = InFeedback.ar(10);
	w = DWGBowed.ar(~notes.midicps, 0.5, 0.2, 1, 0.5, 0.4, 1, 1, 0.55, 2).mean;
	w = w + wfb.madd(0.189);
	w = DWGSoundBoard.ar(w);
	// w = LPF.ar(w,6000);
	Out.ar(10, w);
	DiskOut.ar(b, w);
	w!2
}).play;
)

b.close;
b.free
s.sampleRate


