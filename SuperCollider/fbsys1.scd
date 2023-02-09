(
Server.local.options.numInputBusChannels_(2);
Server.local.options.numOutputBusChannels_(2);
Server.local.options.hardwareBufferSize_(64);
Server.local.options.memSize_(65536 * 16);
s.boot;
)


(
Ndef(\fb1, {
	var w;
	var wfb, mfccs, vib, comx,gain, thresh, env, gate;
	wfb = InFeedback.ar(10);
	w = DWGBowed.ar([49,50,100,SinOsc.ar(0.1).linexp(-1,1,39,60)], 0.5, 0.2, 1, Phasor.ar(1, 1.0/SampleRate.ir * 0.1), 0.4, 1, 1, 0.55, 2).mean;
	w = w + wfb.madd(MouseY.kr(0.18,0.25));
	w = DWGSoundBoard.ar(w);
	comx = FluidShannonEntropy.ar(w, 256, 1000, 2000, 500);
	// comx.poll;
	// comx = comx.linlin(0,8,0,1);
	// comx.poll;
	thresh=7.5;
	comx = 1.0-comx.min(thresh).linlin(0,thresh,0,1);
	comx.poll;
	env = Amplitude.ar(comx, 0.02,0.5) * MouseX.kr(0,3);
	gain = 1 - env;
	gain.poll;
	// gain = comx.min(thresh);
	// gain = comx.linlin(0,thresh,0,1);
	// gain = pow(gain,2.4);
	// gain = Lag2UD.ar(gain,0.4,0.4);
	// gain.poll;
	// w = BPF.ar(w,118,1)+w;
	// w = BPF.ar(w,430,1)+w;
	// w = BPF.ar(w,490,1)+w;
	w = LPF.ar(w,6000);
	// gain=1;
	Out.ar(10, w * gain);
	w!2
}).play;
)

(
Ndef(\fb2, {
	var w;
	var wfb, mfccs, vib, comx,gain, thresh, env, gate;
	wfb = InFeedback.ar(10);
	w = DWGBowed.ar([49,50,100], 0.5, 0.2, 1, Phasor.ar(1, 1.0/SampleRate.ir * 0.1), 0.4, 1, 1, 0.55, 2).mean;
	w = w + wfb.madd(MouseY.kr(0.18,0.25));
	w = DWGSoundBoard.ar(w);
	comx = FluidRPC.ar(w, 1000, 2000, 500);
	// comx.poll;
	// comx = comx.linlin(0,8,0,1);
	comx.poll;
	thresh=450;
	comx = 1.0-comx.min(thresh).linlin(0,thresh,0,1);
	env = Amplitude.ar(comx, 0.02,0.5) * MouseX.kr(0,3);
	gain = 1 - env;
	gain.poll;
	// gain = comx.min(thresh);
	// gain = comx.linlin(0,thresh,0,1);
	// gain = pow(gain,2.4);
	// gain = Lag2UD.ar(gain,0.4,0.4);
	// gain.poll;
	// w = BPF.ar(w,118,1)+w;
	// w = BPF.ar(w,430,1)+w;
	// w = BPF.ar(w,490,1)+w;
	w = LPF.ar(w,6000);
	// gain=1;
	Out.ar(10, w * gain);
	w!2
}).play;
)



(
{ Streson.ar(LFSaw.ar([220, 180], 0, mul:EnvGen.kr(Env.asr(0.5, 1, 0.02), 1.0) * 0.2), LinExp.kr(LFCub.kr(0.1, 0.5*pi), -1, 1, 280, 377).reciprocal, 0.9, 0.3) }.play
)