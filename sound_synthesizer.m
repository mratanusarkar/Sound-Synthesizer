%% Description
% Author: Atanu Sarkar
% Starting date: 10/08/2018 08:21 PM
% 
% v1.0 (10/08/2018)
% Implementing 'play command' of Wolfram Mathematica in MATLAB.
% creating signal defined by mathematical equation and playing it using 
% sound function (which works using audioplayer function).
% also, plotting signal's time domain waveform as well as 
% frequency domain waveform of the signal using fourier transform (FFT).
% Wolfram Mathematica has all these features inbuilt in it's 'play' command.
%
% v1.1 (06/10/2018)
% Added stereo playback as well as sterio visualization features.
% corrected the frequency domain analysis using 'frequency-time' spectrum 
% analysis instead of FFT (which is exactly what Mathematica does!)
% Added feature of exporting created signal as music file.
% corrected bug related to:
% 1. creating signals using mathematical summation function.
% 2. sound distortion by introducing normalization for signal values
%    not in -1 to +1 range.

%% configure signal settings
 duration = 3;                          % duration in seconds
 amplitude = 1;                         % amplitude
 f = 440;                               % frequency in Hertz
 phi = 2*pi*0;                          % phase offset, e.g.: 2*pi*0.25 = 1/4 cycle
 %% configure output settings
 fs = 48000;                            % sampling rate
 T = 1/fs;                              % sampling period
 t = 0:T:duration-T;                    % time vector
 Left=zeros(1,length(t));               % Initialize Left Audio channel with zeros
 Right=zeros(1,length(t));              % Initialize Right Audio channel with zeros
 signal=zeros(2,length(t));             % initialize Sterio 2-Channel Audio signal with zeros
 %% create the signal
 omega = 2*pi*f;                        % angular frequency in radians
 
 % write your audio signal in Left and Right audio channels in form of mathematical equation here:
 % use loops here for mathematical functions in terms of ?, ?, etc.
 Left = Left + amplitude*sin(omega*t + phi);
 Right = Right + amplitude*sin(omega*t + phi+pi);
 
 % normalize your signal here, if it's values are not in -1 to +1 range.
 Left=Left/max(Left);
 Right=Right/max(Right);
 
 % Finally form your 2-channel Stereo Audio signal ready to be played
 signal(1,:)=Left;
 signal(2,:)=Right;
 %% plot the signal
 
 %  Time-Domain Analysis
 subplot(2,2,[1:2]);
 plot(t, signal);
 xlabel('Time (seconds) --->');
 ylabel('amplitude --->');
 title('Sound Signal in Time-Domain ( blue:L | red:R )');
 
 %  Time-Frequency Analysis
 nwin = 128;
 wind = hamming(nwin);
 nlap = nwin-20;
 nfft = 256;

 subplot(2,2,3);
 spectrogram(signal(1,:),wind,nlap,nfft,fs,'yaxis');
 title('Left-Channel Spectrum (L)');
 subplot(2,2,4);
 spectrogram(signal(2,:),wind,nlap,nfft,fs,'yaxis');
 title('Rignt-Channel Spectrum (R)');

 %% play the signal
  sound(signal, fs);
 %% save signal as stereo wave file
 
 % Suppoeted Export Formats by MATLAB:
 % WAVE (.wav), OGG (.ogg), FLAC (.flac), MPEG-4 AAC (.m4a, .mp4).
 
 %  Sample rate 'fs', in hertz, of audio data y, specified as a positive scalar 
 %  greater than 0. Values of Fs are truncated to integer boundaries. 
 %  When writing to .m4a or .mp4 files on Windows platforms, 
 %  audiowrite supports only samples rates of 44100 and 48000.
 
 stereo_signal=signal.';
 audiowrite('sample sound.wav',stereo_signal,fs)